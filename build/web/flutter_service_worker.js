'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "27cd0cdd3b0a313c374918aacb4617aa",
"assets/AssetManifest.bin.json": "afff2419f3ea0d466d3de5bd7fe6c4c9",
"assets/AssetManifest.json": "b6c38586bb9dbe91974ae8106bc8d324",
"assets/assets/bg1.png": "aad3bf3bc3acd9aff7539b046bd86ff7",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"assets/NOTICES": "d8a8870445259857263f177e4da93446",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/flutter_inappwebview_web/assets/web/web_support.js": "509ae636cfdd93e49b5a6eaf0f06d79f",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "89888520c711cc50c41c6f48177fe3b9",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "a110bc9c2473ce1400997a4238ff379f",
"icons/android-icon-144x144.png": "4e7de7394de55fa1dfc336d056447378",
"icons/android-icon-36x36.png": "306d2ae6c1e6fdb740f27713fe480252",
"icons/android-icon-48x48.png": "44e2f7365cc2cd6df1d73eb5a0e45737",
"icons/android-icon-72x72.png": "169df72ed06f0d8e26826edf95bf941d",
"icons/android-icon-96x96.png": "89888520c711cc50c41c6f48177fe3b9",
"icons/apple-icon-114x114.png": "566a702a7abe019098a1e2259591de40",
"icons/apple-icon-120x120.png": "6626c2afa1f3df741bde578e6b8a4344",
"icons/apple-icon-144x144.png": "4e7de7394de55fa1dfc336d056447378",
"icons/apple-icon-152x152.png": "caec73f2b3518f1699abde5e4f9b85d5",
"icons/apple-icon-180x180.png": "9aee3fa3f16a7f24b328997c22259b64",
"icons/apple-icon-57x57.png": "f5816d6af8c8e616ff2ad275348157ae",
"icons/apple-icon-60x60.png": "1aa1170f2228b33ff94d2f42c5b3e961",
"icons/apple-icon-72x72.png": "169df72ed06f0d8e26826edf95bf941d",
"icons/apple-icon-76x76.png": "4007121f40c013aa589c0847cf071bb8",
"icons/apple-icon-precomposed.png": "bea7b2ad65553c49c478c0ab90eaf1d3",
"icons/apple-icon.png": "bea7b2ad65553c49c478c0ab90eaf1d3",
"icons/browserconfig.xml": "653d077300a12f09a69caeea7a8947f8",
"icons/favicon-16x16.png": "0150d878657eff0c6045d59e142f3e7c",
"icons/favicon-32x32.png": "ce2cab2c46100ed4f715f961467d95f9",
"icons/favicon-96x96.png": "89888520c711cc50c41c6f48177fe3b9",
"icons/favicon.ico": "15dcb98c23bcb3490c5c010a06959313",
"icons/Icon-192.png": "f8492c1f83be596b67a1d544dd6de77c",
"icons/Icon-512.png": "9807d8313238dc80322bc6b13a7d1f2d",
"icons/Icon-maskable-192.png": "f8492c1f83be596b67a1d544dd6de77c",
"icons/Icon-maskable-512.png": "9807d8313238dc80322bc6b13a7d1f2d",
"icons/manifest.json": "b58fcfa7628c9205cb11a1b2c3e8f99a",
"icons/ms-icon-144x144.png": "4e7de7394de55fa1dfc336d056447378",
"icons/ms-icon-150x150.png": "0d51f0a875a4c6e2c8bc76e77e6270d2",
"icons/ms-icon-310x310.png": "f271643a8ba12ca959d38cd5efaff066",
"icons/ms-icon-70x70.png": "821125c881ae1bdab3a15ad92bbb6bda",
"index.html": "a9cd5a8483da7ef129183f7b30af0904",
"/": "a9cd5a8483da7ef129183f7b30af0904",
"main.dart.js": "f22e5589bc7dfac466d5237cbf35295a",
"manifest.json": "e4ab3deab994e63d2e1c24867b952302",
"version.json": "027975ae79106b3150f050e262a09a94"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
