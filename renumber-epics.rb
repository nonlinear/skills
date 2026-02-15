#!/usr/bin/env ruby

# Renumber skills ROADMAP epics to sequential v1.x.0

roadmap = File.read('backstage/ROADMAP.md')

# Epic version mapping (old → new)
VERSION_MAP = {
  'v0.1.0' => 'v1.0.0',
  'v1.0.0' => 'v1.1.0',
  'v1.1.0' => 'v1.2.0',
  'v1.4.0' => 'v1.3.0',
  'v1.6.0' => 'v1.4.0',
  'v1.7.0' => 'v1.5.0',
  'v2.0.0' => 'v1.6.0',
  'v2.1.0' => 'v1.7.0',
  'v2.2.0' => 'v1.8.0',
  'v2.3.0' => 'v1.9.0'
}

# Replace version numbers in order (longest first to avoid partial matches)
VERSION_MAP.keys.sort_by(&:length).reverse.each do |old_version|
  new_version = VERSION_MAP[old_version]
  roadmap.gsub!(old_version, new_version)
  puts "#{old_version} → #{new_version}"
end

# Write back
File.write('backstage/ROADMAP.md', roadmap)

puts "\n✅ ROADMAP renumbered!"
puts "Next: Renumber epic-notes folders and mermaid diagram"
