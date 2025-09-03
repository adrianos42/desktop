'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "39f03fa9d52c020c8d6520d6c947a311",
"index.html": "18edd36a01025eee2a5cebd70b185df7",
"/": "18edd36a01025eee2a5cebd70b185df7",
"main.dart.mjs": "06e45e8ec99b0747e5a22bc73d0f38f3",
"main.dart.wasm": "aad9edb0f23370d812fe0b9cae44642c",
"main.dart.js": "1f9dd7c7a945d44196b24fbd975130fe",
"version.json": "e7e473f26700fe94fe1b3f32eb51ef6f",
"assets/assets/GitHub-Mark-32px.png": "f87561b8bb354ef83b09a66e54f70e08",
"assets/assets/GitHub-Mark-Light-32px.png": "d56df49a807a9fd06eb1667a84d3810e",
"assets/assets/dart-logo.png": "edef732fd94e18eab2fefe7c5e3edae3",
"assets/assets/cats_small/pexels-1653357.webp": "a50ae37ed052c3284d868578645709f4",
"assets/assets/cats_small/pexels-1571724.webp": "0df24633f1df7e4404ae1262b9a43f96",
"assets/assets/cats_small/pexels-3127729.webp": "ba057e1901a3be867ae5e04efc6d5de5",
"assets/assets/cats_small/pexels-1828875.webp": "ff9fb9b401874bc2cafb25de32fdcabe",
"assets/assets/cats_small/pexels-1299518.webp": "ebb75219045eaa8f784797d7b2d2b8da",
"assets/assets/cats_small/pexels-45201.webp": "6a26ed3706a9792344abed6f875b8618",
"assets/assets/cats_small/pexels-2693561.webp": "fb113abee53f07398820286464d10de4",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-Thin.ttf": "19dbee61fc3b65e55edc0ae9c2b554a8",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-ThinItalic.ttf": "0ee07c10aedebe8356053d4b966f4feb",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-ExtraLight.ttf": "200536200b4ce3dc0c7b3cb1b7372b88",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-ExtraLightItalic.ttf": "4f3e56ccdd10a413613fc1a2176a8291",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-LightItalic.ttf": "fe20230f0cc36e530e86b666c1f43a50",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-Light.ttf": "e4d250a879ee12a7a240e9db101d272d",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-Regular.ttf": "cb46f1f18358474393e7ccd02be3998a",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-Italic.ttf": "0d808068d751810c39b3c92048c169f8",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-Medium.ttf": "1f86f6c46bf066316c13a9cba815ccfd",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-MediumItalic.ttf": "bdeb32c4b391812ae6cc7d1cad64bd07",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-SemiBoldItalic.ttf": "c58fa699a6cdc4b01066077fcc172a1f",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-BoldItalic.ttf": "b03a7a2377df83ff85df47516874447c",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-Bold.ttf": "36183581f89e93328498c9073e402f85",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-Thin.ttf": "969246a285e76a59329d5e003f1a28a0",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-ThinItalic.ttf": "984c6ee79e119ff312f599e0e1b21932",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-LightItalic.ttf": "453b2bbf7ad0bb52a93f64ac96641f24",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-ExtraLight.ttf": "dc4c7cbc44c833f9a7540a6464a015fa",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-ExtraLightItalic.ttf": "71efb00c2fc462eb4c4f778dac53e6dc",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-Light.ttf": "29047654270fd882ab9e9ec10e28f7c5",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-Italic.ttf": "40bbef08ca6f6edea2a9a9e882541ce0",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-Regular.ttf": "c02b4dc6554c116e4c40f254889d5871",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-Medium.ttf": "ee83103a4a777209b0f759a4ff598066",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-MediumItalic.ttf": "eb7dadea8e7c37ce1a1406045dda7c1e",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-SemiBoldItalic.ttf": "25178032f9e824996f04622926833459",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-BoldItalic.ttf": "ee425cc83f37323665790c89758cf359",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-Bold.ttf": "5159a5d89abe8bf68b09b569dbeccbc0",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-Thin.ttf": "356f326e338e991f8c7eca31a6db41a7",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-ThinItalic.ttf": "3abd420548d595a59789abaf56b1b96d",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-Italic.ttf": "b38b47f1cb5acc36e0e232043be25f28",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-Medium.ttf": "9ca7848f37491852b10287aca8bf390b",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-Bold.ttf": "58e4633f72e3feca1e4fcf9f32d2217c",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-SemiBoldItalic.ttf": "6ca2b9b68fab48e40b6b8bf57acbf0a6",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-MediumItalic.ttf": "2a624013df90c5a04cf7a34e6b25919b",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-BoldItalic.ttf": "159f2530bfd7c6fcd2e8c035c37c8789",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-ExtraLight.ttf": "04ec9cb3d43a36d072456ca568b40214",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-ExtraLightItalic.ttf": "3046cfbc0a34e7459330e0f1c41c0c63",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-Light.ttf": "fabde431316f09ed8c275e20e817fbef",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-LightItalic.ttf": "4aa3ba0a6d390e30a75d4762dca7057e",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-Regular.ttf": "bfc0c1efd48c7e6dcbd2504c849a3a51",
"assets/packages/desktop/fonts/Material_Icons_Sharp_Regular/MaterialIconsSharp-Regular.otf": "ca3f9796f3c9766ae4135db0251436a0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.json": "f35e4d31e3c048e47b898613dc7f50c1",
"assets/AssetManifest.bin": "6a96cce6a1631a21907f3d69b32903e7",
"assets/AssetManifest.bin.json": "5eb4608a171b4bc9fdfb3c7c99e68f55",
"assets/FontManifest.json": "690bd94bbfad2fd6d2e4b7ceb664a425",
"assets/NOTICES": "d0651a92239988d394c7db64985cbdbc",
"docs.png": "f9606f95519ac4aac78099a8873f5116",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "f9606f95519ac4aac78099a8873f5116",
"icons/Icon-512.png": "f9606f95519ac4aac78099a8873f5116",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"manifest.json": "b84436d4ff185318efa7890db21d84b2"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"main.dart.wasm",
"main.dart.mjs",
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
