// service-worker.js - Generic offline storage for media apps
// Works for: Kavita, Komga, and similar web-based readers

const CACHE_VERSION = 'v1';
const CACHE_NAME = `better-storage-${CACHE_VERSION}`;

// Install: Pre-cache core assets
self.addEventListener('install', (event) => {
  console.log('[SW] Installing...');
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      console.log('[SW] Cache opened');
      // Pre-cache will be populated on-demand
      return Promise.resolve();
    })
  );
  self.skipWaiting();
});

// Activate: Clean old caches
self.addEventListener('activate', (event) => {
  console.log('[SW] Activating...');
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheName !== CACHE_NAME) {
            console.log('[SW] Deleting old cache:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
  self.clients.claim();
});

// Fetch: Cache-first strategy for media, network-first for API
self.addEventListener('fetch', (event) => {
  const url = new URL(event.request.url);
  
  // Cache strategy based on resource type
  if (isMediaResource(url)) {
    // Cache-first for images/pages
    event.respondWith(cacheFirst(event.request));
  } else if (isAPIResource(url)) {
    // Network-first for API (with cache fallback)
    event.respondWith(networkFirst(event.request));
  } else {
    // Default: network-first
    event.respondWith(networkFirst(event.request));
  }
});

// Helper: Detect media resources (images, pages)
function isMediaResource(url) {
  return url.pathname.match(/\.(jpg|jpeg|png|webp|gif|pdf|cbz|cbr|epub)$/i) ||
         url.pathname.includes('/api/image/') ||
         url.pathname.includes('/api/page/');
}

// Helper: Detect API resources
function isAPIResource(url) {
  return url.pathname.includes('/api/');
}

// Strategy: Cache-first (offline reading)
async function cacheFirst(request) {
  const cache = await caches.open(CACHE_NAME);
  const cached = await cache.match(request);
  
  if (cached) {
    console.log('[SW] Cache hit:', request.url);
    return cached;
  }
  
  console.log('[SW] Cache miss, fetching:', request.url);
  const response = await fetch(request);
  
  // Cache successful responses
  if (response.ok) {
    cache.put(request, response.clone());
  }
  
  return response;
}

// Strategy: Network-first (fresh data preferred)
async function networkFirst(request) {
  try {
    const response = await fetch(request);
    
    // Cache successful responses
    if (response.ok) {
      const cache = await caches.open(CACHE_NAME);
      cache.put(request, response.clone());
    }
    
    return response;
  } catch (error) {
    console.log('[SW] Network failed, trying cache:', request.url);
    const cached = await caches.match(request);
    
    if (cached) {
      return cached;
    }
    
    throw error;
  }
}

// Message handler (for cache management)
self.addEventListener('message', (event) => {
  if (event.data.action === 'clearCache') {
    event.waitUntil(
      caches.delete(CACHE_NAME).then(() => {
        console.log('[SW] Cache cleared');
        event.ports[0].postMessage({ success: true });
      })
    );
  }
  
  if (event.data.action === 'getCacheSize') {
    event.waitUntil(
      caches.open(CACHE_NAME).then(async (cache) => {
        const keys = await cache.keys();
        event.ports[0].postMessage({ size: keys.length });
      })
    );
  }
});
