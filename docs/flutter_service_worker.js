'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"main.dart.js": "dc32d5e540fc4a2b6b0643a91ee16ff2",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"assets/NOTICES": "71a15b7ac0118645d3e2549de8fd1997",
"assets/assets/GitHub-Mark-32px.png": "f87561b8bb354ef83b09a66e54f70e08",
"assets/assets/cats_small/pexels-5044690.webp": "2f5830b9100502a89dfb9173cce87038",
"assets/assets/cats_small/pexels-479009.webp": "e3ec36cd82bc773da3d5f46a0a752154",
"assets/assets/cats_small/pexels-1687831.webp": "6a707f553f860daeb679442f66b64a35",
"assets/assets/cats_small/pexels-731553.webp": "36538afbddb35c9a649d71edd7b77091",
"assets/assets/cats_small/pexels-2817405.webp": "641976663f1addbaa69447616627b7fd",
"assets/assets/cats_small/pexels-4858815.webp": "e30d4db46b7a4e73ca38696005b85a99",
"assets/assets/cats_small/pexels-5456616.webp": "63046f1086bdfe06fd690841916ba279",
"assets/assets/cats_small/pexels-1299518.webp": "ebb75219045eaa8f784797d7b2d2b8da",
"assets/assets/cats_small/pexels-979503.webp": "cbb52e29a5062cf121f3ec439306a7c2",
"assets/assets/cats_small/pexels-979247.webp": "9c3d4721e1922ecaf64331b343cd5e95",
"assets/assets/cats_small/pexels-2255565.webp": "6ffe2a6c6a9501190a156cbb9031e0f9",
"assets/assets/cats_small/pexels-96428.webp": "8f0d2f6e168d47df7403d82c613df7fc",
"assets/assets/cats_small/pexels-160755.webp": "9c3b1028675f68539171ad16515b958a",
"assets/assets/cats_small/pexels-3127729.webp": "ba057e1901a3be867ae5e04efc6d5de5",
"assets/assets/cats_small/pexels-192384.webp": "bddbee6d234538894eda4f6cf9d49c8c",
"assets/assets/cats_small/pexels-2693561.webp": "fb113abee53f07398820286464d10de4",
"assets/assets/cats_small/pexels-720684.webp": "04acec3d09a28cb9a88b34ec9f59fa1b",
"assets/assets/cats_small/pexels-1784289.webp": "e2771908ea5fd3c0a04849eea7ab3e0f",
"assets/assets/cats_small/pexels-1754986.webp": "d712de49adc233af0cb48d0c40f0bcf1",
"assets/assets/cats_small/pexels-1416792.webp": "0871a7a092914931a6a9501c728c2a83",
"assets/assets/cats_small/pexels-4391733.webp": "6981bed9d32565099b1699ec08623967",
"assets/assets/cats_small/pexels-4734723.webp": "7204ac5f37c574ed4cf9391318c41bdd",
"assets/assets/cats_small/pexels-4411430.webp": "e92c2e42aefcf50a33081ef7d77a3fc0",
"assets/assets/cats_small/pexels-2611939.webp": "e588265dc76ace63fa56217ae6f1987b",
"assets/assets/cats_small/pexels-45201.webp": "6a26ed3706a9792344abed6f875b8618",
"assets/assets/cats_small/pexels-1828875.webp": "ff9fb9b401874bc2cafb25de32fdcabe",
"assets/assets/cats_small/pexels-1643457.webp": "57aa8df494e7f2133fa6a0635f1f10c6",
"assets/assets/cats_small/pexels-1571724.webp": "0df24633f1df7e4404ae1262b9a43f96",
"assets/assets/cats_small/pexels-5800065.webp": "de5cf8d4c10a045638f6a13be8708a19",
"assets/assets/cats_small/pexels-45170.webp": "a97d123891b627f18c14a917e89d8c4b",
"assets/assets/cats_small/pexels-156321.webp": "36966fbb9f2c73b64cf22dba745fb408",
"assets/assets/cats_small/pexels-1653357.webp": "a50ae37ed052c3284d868578645709f4",
"assets/assets/cats_small/pexels-1770918.webp": "cc11437fddfb2cebd456517c3328581b",
"assets/assets/cats_small/pexels-3030635.webp": "fb92c65b37c6d4091576c71e63e04905",
"assets/assets/cats_small/pexels-3772262.webp": "b83f0335e79e764a0cffbca96f6d2211",
"assets/assets/cats_small/pexels-104827.webp": "dd5116fc3418dab601b6180a2d4876c9",
"assets/assets/cats/pexels-5044690.webp": "95644e6a960c15b717cf429da0879f3c",
"assets/assets/cats/pexels-479009.webp": "b186a64986d36b3912cb2b8b75d778e7",
"assets/assets/cats/pexels-1687831.webp": "2af6d7ff8c7016b07b9d5c85043baa0b",
"assets/assets/cats/pexels-731553.webp": "edc53176c6b1686ee69b3910feb48a46",
"assets/assets/cats/pexels-2817405.webp": "e4a61aa860e74e3ee45f204aa54601b5",
"assets/assets/cats/pexels-4858815.webp": "6797194276c63af3a4f0d24b3dabb58a",
"assets/assets/cats/pexels-5456616.webp": "f0216abcda78d97a44e36aac76bb17ee",
"assets/assets/cats/pexels-1299518.webp": "40fa0e94198952f3d63140c2c653e7f5",
"assets/assets/cats/pexels-979503.webp": "4d4c83882c160f1bcd0f716b0cc7d3c1",
"assets/assets/cats/pexels-979247.webp": "2233befe693004b0484689b5b06c350c",
"assets/assets/cats/pexels-2255565.webp": "5d55dafa4068261676c1d2c897b24e63",
"assets/assets/cats/pexels-96428.webp": "8004f91831d894808dff9c898947215d",
"assets/assets/cats/pexels-160755.webp": "25412bc55ca0aaf87c124f6412fbce4a",
"assets/assets/cats/pexels-3127729.webp": "bdab6a39f149ffd4c323b0106c55c551",
"assets/assets/cats/pexels-192384.webp": "96fb0ba5e10ead8291e1cb568bf6f01f",
"assets/assets/cats/pexels-2693561.webp": "52c281c4b49a641cc7ca6cad500bbf65",
"assets/assets/cats/pexels-720684.webp": "9502fb24b321eef45469dd513234aa8f",
"assets/assets/cats/pexels-1784289.webp": "ab530cbcbb522a3a5ae7562fbf6d6e33",
"assets/assets/cats/pexels-1754986.webp": "794aeda2e7648457d44934ea968ff809",
"assets/assets/cats/pexels-1416792.webp": "d0c5a010f50381e564bf26f6c3cc3729",
"assets/assets/cats/pexels-4391733.webp": "24d7424da071d4f037ba619e97f85fa4",
"assets/assets/cats/pexels-4734723.webp": "ad4f2c0464a889ff9c833f2a95eb2791",
"assets/assets/cats/pexels-4411430.webp": "0e15a37f97045368c86d8af91a37c6e7",
"assets/assets/cats/pexels-2611939.webp": "f757445a293b97dec155f62821ea0d45",
"assets/assets/cats/pexels-45201.webp": "0b823177d15da4afc8ec57f20c4ff350",
"assets/assets/cats/pexels-1828875.webp": "f0a306a82cce0feb5e0ebe79a856e2b9",
"assets/assets/cats/pexels-1643457.webp": "104717665382e8a355d70b839a4f6a74",
"assets/assets/cats/pexels-1571724.webp": "acbf1542d0c5aa4a7d8d016f3fc727c3",
"assets/assets/cats/pexels-5800065.webp": "254ec4f4d52510a330d5be37408ed069",
"assets/assets/cats/pexels-45170.webp": "4a0390459c41d426d1cfeef5444a2ffa",
"assets/assets/cats/pexels-156321.webp": "adbf6cf7f654b13b96d888973df523e9",
"assets/assets/cats/pexels-1653357.webp": "8db9e2b93cc3a99eccd9a25e06633409",
"assets/assets/cats/pexels-1770918.webp": "9944bfa74de3fd534ba6491b4435a448",
"assets/assets/cats/pexels-3030635.webp": "53ab58eb54a1e64869a5502901fc2cfd",
"assets/assets/cats/pexels-3772262.webp": "e080734f57f9cd512d4d1a6f9316a1cb",
"assets/assets/cats/pexels-104827.webp": "ffccec92afa864ca8d5c9b57733e51f0",
"assets/assets/GitHub-Mark-Light-32px.png": "d56df49a807a9fd06eb1667a84d3810e",
"assets/FontManifest.json": "690bd94bbfad2fd6d2e4b7ceb664a425",
"assets/AssetManifest.json": "8aa79c7c0e4448b83f8ebc8c5bd4fed1",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-Bold.ttf": "5159a5d89abe8bf68b09b569dbeccbc0",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-ExtraLight.ttf": "dc4c7cbc44c833f9a7540a6464a015fa",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-LightItalic.ttf": "453b2bbf7ad0bb52a93f64ac96641f24",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-Italic.ttf": "40bbef08ca6f6edea2a9a9e882541ce0",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-Light.ttf": "29047654270fd882ab9e9ec10e28f7c5",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-ThinItalic.ttf": "984c6ee79e119ff312f599e0e1b21932",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-Regular.ttf": "c02b4dc6554c116e4c40f254889d5871",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-BoldItalic.ttf": "ee425cc83f37323665790c89758cf359",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-ExtraLightItalic.ttf": "71efb00c2fc462eb4c4f778dac53e6dc",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-SemiBoldItalic.ttf": "25178032f9e824996f04622926833459",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-MediumItalic.ttf": "eb7dadea8e7c37ce1a1406045dda7c1e",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-Medium.ttf": "ee83103a4a777209b0f759a4ff598066",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-Thin.ttf": "969246a285e76a59329d5e003f1a28a0",
"assets/packages/desktop/fonts/Material_Icons_Sharp_Regular/MaterialIconsSharp-Regular.otf": "5257f80b95fdba0a233f61fef096b3f2",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-LightItalic.ttf": "4aa3ba0a6d390e30a75d4762dca7057e",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-Italic.ttf": "b38b47f1cb5acc36e0e232043be25f28",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-MediumItalic.ttf": "2a624013df90c5a04cf7a34e6b25919b",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-ExtraLight.ttf": "04ec9cb3d43a36d072456ca568b40214",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-BoldItalic.ttf": "159f2530bfd7c6fcd2e8c035c37c8789",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-Thin.ttf": "356f326e338e991f8c7eca31a6db41a7",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-Medium.ttf": "9ca7848f37491852b10287aca8bf390b",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-SemiBoldItalic.ttf": "6ca2b9b68fab48e40b6b8bf57acbf0a6",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-ExtraLightItalic.ttf": "3046cfbc0a34e7459330e0f1c41c0c63",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-Bold.ttf": "58e4633f72e3feca1e4fcf9f32d2217c",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-Light.ttf": "fabde431316f09ed8c275e20e817fbef",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-ThinItalic.ttf": "3abd420548d595a59789abaf56b1b96d",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-Regular.ttf": "bfc0c1efd48c7e6dcbd2504c849a3a51",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-ExtraLightItalic.ttf": "4f3e56ccdd10a413613fc1a2176a8291",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-SemiBoldItalic.ttf": "c58fa699a6cdc4b01066077fcc172a1f",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-ThinItalic.ttf": "0ee07c10aedebe8356053d4b966f4feb",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-MediumItalic.ttf": "bdeb32c4b391812ae6cc7d1cad64bd07",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-LightItalic.ttf": "fe20230f0cc36e530e86b666c1f43a50",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-Light.ttf": "e4d250a879ee12a7a240e9db101d272d",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-Italic.ttf": "0d808068d751810c39b3c92048c169f8",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-Bold.ttf": "36183581f89e93328498c9073e402f85",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-ExtraLight.ttf": "200536200b4ce3dc0c7b3cb1b7372b88",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-BoldItalic.ttf": "b03a7a2377df83ff85df47516874447c",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-Regular.ttf": "cb46f1f18358474393e7ccd02be3998a",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-Medium.ttf": "1f86f6c46bf066316c13a9cba815ccfd",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-Thin.ttf": "19dbee61fc3b65e55edc0ae9c2b554a8",
"assets/shaders/ink_sparkle.frag": "e17111c09074cef29210a8d86730724d",
"index.html": "94edbc6ec014f6ed9127241d56e88d7b",
"/": "94edbc6ec014f6ed9127241d56e88d7b",
"manifest.json": "b84436d4ff185318efa7890db21d84b2",
"icons/Icon-512.png": "f9606f95519ac4aac78099a8873f5116",
"icons/Icon-192.png": "f9606f95519ac4aac78099a8873f5116",
"docs.png": "f9606f95519ac4aac78099a8873f5116",
"version.json": "e7e473f26700fe94fe1b3f32eb51ef6f"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
