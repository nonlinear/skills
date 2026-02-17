// service-worker.js - Offline storage for Kavita
// Enable offline reading via browser cache

const CACHE_VERSION = 'kavita-v1';
const CACHE_NAME = `better-kavita-${CACHE_VERSION}`;

// Install
self.addEventListener('install', (event) => {
  console.log('[Kavita SW] Installing...');
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      console.log('[Kavita SW] Cache opened');
      return Promise.resolve();
    })
  );
  self.skipWaiting();
});

// Activate
self.addEventListener('activate', (event) => {
  console.log('[Kavita SW] Activating...');
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheName !== CACHE_NAME) {
            console.log('[Kavita SW] Deleting old cache:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
  self.clients.claim();
});

// Fetch: Cache-first for images/pages
self.addEventListener('fetch', (event) => {
  const url = new URL(event.request.url);
  
  // Cache images and pages
  if (url.pathname.match(/\.(jpg|jpeg|png|webp|pdf|cbz|cbr)$/i) ||
      url.pathname.includes('/api/image/') ||
      url.pathname.includes('/api/page/')) {
    event.respondWith(cacheFirst(event.request));
  } else {
    event.respondWith(networkFirst(event.request));
  }
});

async function cacheFirst(request) {
  const cache = await caches.open(CACHE_NAME);
  const cached = await cache.match(request);
  
  if (cached) {
    console.log('[Kavita SW] Cache hit:', request.url);
    return cached;
  }
  
  const response = await fetch(request);
  if (response.ok) {
    cache.put(request, response.clone());
  }
  return response;
}

async function networkFirst(request) {
  try {
    const response = await fetch(request);
    if (response.ok) {
      const cache = await caches.open(CACHE_NAME);
      cache.put(request, response.clone());
    }
    return response;
  } catch (error) {
    const cached = await caches.match(request);
    if (cached) return cached;
    throw error;
  }
}
