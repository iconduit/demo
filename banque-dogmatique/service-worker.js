self.addEventListener('install', event => {
  event.waitUntil(
    caches.open("cache-1623624359728")
      .then(cache => cache.add('.'))
  )
})

self.addEventListener('fetch', event => {
  const {request} = event

  event.respondWith(
    caches.match(request)
      .then(response => response || fetch(request))
  )
})
