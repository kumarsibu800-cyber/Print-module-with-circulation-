// Library Circulation offline helper.
// The app page itself always comes fresh from the internet when there is a connection,
// and from the saved copy only when offline, so a new upload shows up on the next open.
const CACHE = "library-circulation-v20";
const ASSETS = ["./", "./index.html", "./manifest.webmanifest", "./icon-180.png", "./icon-192.png", "./icon-512.png", "./icon-maskable-512.png"];

self.addEventListener("install", (e) => {
  // cache: "reload" skips the phone's short-term web cache, so the saved copy is the real latest one.
  e.waitUntil(
    caches.open(CACHE)
      .then((c) => c.addAll(ASSETS.map((u) => new Request(u, { cache: "reload" }))))
      .then(() => self.skipWaiting())
  );
});

self.addEventListener("activate", (e) => {
  e.waitUntil(
    caches.keys()
      .then((keys) => Promise.all(keys.filter((k) => k !== CACHE).map((k) => caches.delete(k))))
      .then(() => self.clients.claim())
  );
});

const isPage = (req) => {
  if (req.mode === "navigate") return true;
  const p = new URL(req.url).pathname;
  return p.endsWith("/") || p.endsWith(".html") || p.endsWith("admin.json");
};

self.addEventListener("fetch", (e) => {
  const req = e.request;
  if (req.method !== "GET") return;
  // Never touch requests to other sites (Google, jsonbin), only this app's own files.
  if (new URL(req.url).origin !== self.location.origin) return;

  if (isPage(req)) {
    // Network first: newest app when online, saved copy when offline.
    e.respondWith(
      fetch(req.url, { cache: "no-cache" })
        .then((res) => {
          if (res.ok && !new URL(req.url).pathname.endsWith("admin.json")) {
            const copy = res.clone();
            caches.open(CACHE).then((c) => c.put("./index.html", copy));
          }
          return res;
        })
        .catch(() =>
          new URL(req.url).pathname.endsWith("admin.json")
            ? new Response("offline", { status: 503 })
            : caches.match("./index.html").then((hit) => hit || caches.match("./"))
        )
    );
    return;
  }

  // Icons and the manifest: saved copy first, internet if missing.
  e.respondWith(
    caches.match(req, { ignoreSearch: true }).then(
      (hit) =>
        hit ||
        fetch(req).then((res) => {
          if (res.ok) {
            const copy = res.clone();
            caches.open(CACHE).then((c) => c.put(req, copy));
          }
          return res;
        })
    )
  );
});
