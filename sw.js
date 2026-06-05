const CACHE_VERSION = 'lemienote-v1.2.71';

const STATIC_ASSETS = [
  './',
  './index.html',
  './manifest.json',
  './sw.js',
  './icons/icon-144.png',
  './icons/icon-192.png',
  './js/react.production.min.js',
  './js/react-dom.production.min.js',
  './js/jspdf.umd.min.js'
];

// Installa e pre-cacha tutti gli asset statici
self.addEventListener('install', e => {
  e.waitUntil(
    caches.open(CACHE_VERSION).then(cache => {
      return Promise.allSettled(
        STATIC_ASSETS.map(url =>
          cache.add(new Request(url, {
            credentials: 'same-origin',
            mode: url.startsWith('http') ? 'cors' : 'same-origin'
          }))
        )
      );
    })
  );
  self.skipWaiting();
});

// Attiva: elimina le vecchie versioni della cache
self.addEventListener('activate', e => {
  e.waitUntil(
    caches.keys()
      .then(keys =>
        Promise.all(keys.filter(k => k !== CACHE_VERSION).map(k => caches.delete(k)))
      )
      .then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', e => {
  const url = new URL(e.request.url);

  // Ignora richieste non-GET e protocolli interni
  if (e.request.method !== 'GET' || url.protocol === 'chrome-extension:') return;

  // Network-first per l'HTML principale (per ricevere aggiornamenti)
  if (e.request.mode === 'navigate') {
    e.respondWith(
      fetch(e.request)
        .then(response => {
          const clone = response.clone();
          caches.open(CACHE_VERSION).then(c => c.put(e.request, clone));
          return response;
        })
        .catch(() => caches.match('./index.html'))
    );
    return;
  }

  // Cache-first per tutto il resto (JS, CSS, immagini, CDN React)
  e.respondWith(
    caches.match(e.request).then(cached => {
      if (cached) return cached;
      return fetch(e.request).then(response => {
        if (response && response.status === 200) {
          const clone = response.clone();
          caches.open(CACHE_VERSION).then(c => c.put(e.request, clone));
        }
        return response;
      });
    })
  );
});
