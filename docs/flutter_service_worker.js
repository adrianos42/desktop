'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "docs.png": "f9606f95519ac4aac78099a8873f5116",
"main.dart.js": "3c8e15444f234d31a90b5ce168be06dc",
"assets/fonts/mode.ttf": "7af27e3be7174ff453dd84b58017a7f1",
"assets/AssetManifest.json": "5ece75ec893aada032700a70f078b067",
"assets/NOTICES": "752e63063331c94f4feba9720a6e3c3a",
"assets/packages/desktop/fonts/sharp_material_icons.ttf": "7286a89ec4d461263d0cddb86fc16b61",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-Light.ttf": "fabde431316f09ed8c275e20e817fbef",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-ExtraLightItalic.ttf": "3046cfbc0a34e7459330e0f1c41c0c63",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-Italic.ttf": "b38b47f1cb5acc36e0e232043be25f28",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-ThinItalic.ttf": "3abd420548d595a59789abaf56b1b96d",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-LightItalic.ttf": "4aa3ba0a6d390e30a75d4762dca7057e",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-ExtraLight.ttf": "04ec9cb3d43a36d072456ca568b40214",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-SemiBoldItalic.ttf": "6ca2b9b68fab48e40b6b8bf57acbf0a6",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-Medium.ttf": "9ca7848f37491852b10287aca8bf390b",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-BoldItalic.ttf": "159f2530bfd7c6fcd2e8c035c37c8789",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-MediumItalic.ttf": "2a624013df90c5a04cf7a34e6b25919b",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-Thin.ttf": "356f326e338e991f8c7eca31a6db41a7",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-Bold.ttf": "58e4633f72e3feca1e4fcf9f32d2217c",
"assets/packages/desktop/fonts/IBM_Plex_Serif/IBMPlexSerif-Regular.ttf": "bfc0c1efd48c7e6dcbd2504c849a3a51",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-ThinItalic.ttf": "0ee07c10aedebe8356053d4b966f4feb",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-SemiBoldItalic.ttf": "c58fa699a6cdc4b01066077fcc172a1f",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-Italic.ttf": "0d808068d751810c39b3c92048c169f8",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-ExtraLightItalic.ttf": "4f3e56ccdd10a413613fc1a2176a8291",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-Medium.ttf": "1f86f6c46bf066316c13a9cba815ccfd",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-MediumItalic.ttf": "bdeb32c4b391812ae6cc7d1cad64bd07",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-Regular.ttf": "cb46f1f18358474393e7ccd02be3998a",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-Bold.ttf": "36183581f89e93328498c9073e402f85",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-Light.ttf": "e4d250a879ee12a7a240e9db101d272d",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-Thin.ttf": "19dbee61fc3b65e55edc0ae9c2b554a8",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-BoldItalic.ttf": "b03a7a2377df83ff85df47516874447c",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-LightItalic.ttf": "fe20230f0cc36e530e86b666c1f43a50",
"assets/packages/desktop/fonts/IBM_Plex_Mono/IBMPlexMono-ExtraLight.ttf": "200536200b4ce3dc0c7b3cb1b7372b88",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-ExtraLightItalic.ttf": "71efb00c2fc462eb4c4f778dac53e6dc",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-Regular.ttf": "c02b4dc6554c116e4c40f254889d5871",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-ThinItalic.ttf": "984c6ee79e119ff312f599e0e1b21932",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-Italic.ttf": "40bbef08ca6f6edea2a9a9e882541ce0",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-Medium.ttf": "ee83103a4a777209b0f759a4ff598066",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-ExtraLight.ttf": "dc4c7cbc44c833f9a7540a6464a015fa",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-Thin.ttf": "969246a285e76a59329d5e003f1a28a0",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-MediumItalic.ttf": "eb7dadea8e7c37ce1a1406045dda7c1e",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-BoldItalic.ttf": "ee425cc83f37323665790c89758cf359",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-SemiBoldItalic.ttf": "25178032f9e824996f04622926833459",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-Bold.ttf": "5159a5d89abe8bf68b09b569dbeccbc0",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-Light.ttf": "29047654270fd882ab9e9ec10e28f7c5",
"assets/packages/desktop/fonts/IBM_Plex_Sans/IBMPlexSans-LightItalic.ttf": "453b2bbf7ad0bb52a93f64ac96641f24",
"assets/assets/cats/pexels-d%25C6%25B0%25C6%25A1ng-nh%25C3%25A2n-2817405.jpg": "fc1a04eda5846b5f8100007d5d608eef",
"assets/assets/cats/pexels-pixabay-45170.jpg": "db3c37d77c978ca4a8d3431c31e0e956",
"assets/assets/cats/pexels-piers-olphin-5044690.jpg": "ef7cc00c55bc46fc7bb67be53329976f",
"assets/assets/cats/pexels-emily-geibel-3772262.jpg": "97f83a52659ac9e088f710f49356ae64",
"assets/assets/cats/pexels-xue-guangjian-1687831.jpg": "f285d920d6a300e2e5cb9689e50bc121",
"assets/assets/cats/pexels-zhang-kaiyv-4858815.jpg": "e10b973977e303ade2910a96e0d75f0d",
"assets/assets/cats/pexels-peng-louis-1643457.jpg": "dbf37983a0902c07633f33ce4824b609",
"assets/assets/cats/pexels-halil-i%25CC%2587brahim-%25C3%25A7eti%25CC%2587n-1754986.jpg": "6ea7658e5e555cca1f60292856330a52",
"assets/assets/cats/pexels-christopher-schruff-720684.jpg": "6ae0fe40c137c56aa9ecddc091cfa1d7",
"assets/assets/cats/pexels-faris-subriun-4391733.jpg": "be8bc2016300f7721f4ddbefc8280177",
"assets/assets/cats/pexels-jan-kop%25C5%2599iva-5800065.jpg": "3ea1cbce3c55e81eff5cc43aa56ec284",
"assets/assets/cats/pexels-engin-akyurt-1571724.jpg": "f79b7b85dc9aabd800c3982c1ec18efd",
"assets/assets/cats/pexels-utku-koylu-2611939.jpg": "d5b6f468aefcec0052896a31443e159e",
"assets/assets/cats/pexels-fotografierende-3127729.jpg": "bd3ab38f6336229ae90d4c4b73746709",
"assets/assets/cats/pexels-leonardo-de-oliveira-1770918.jpg": "2a7f44aab6de271a98289f8e42dee327",
"assets/assets/cats/pexels-peng-louis-1653357.jpg": "05ac9050755bac9751b1d2406a1d34fc",
"assets/assets/cats/pexels-mati-mango-4734723.jpg": "f12da17cdcc784f826f82b36bdabf839",
"assets/assets/cats/pexels-evg-culture-1416792.jpg": "ff09f07bb144a2ac74f3b25705095885",
"assets/assets/cats/pexels-luan-oosthuizen-1784289.jpg": "25112fb1a1e69ce49b2524929e42aedf",
"assets/assets/cats/pexels-tamba-budiarsana-979247.jpg": "2f7ad39bc30cb32a8ffb5edf7c9ca270",
"assets/assets/cats/pexels-anete-lusina-4790622.jpg": "e818f56a8ce61d0651a40767fa7ffdc1",
"assets/assets/cats/pexels-francesco-ungaro-96428.jpg": "ae0ac5f17b7832f1449ebabee357ce4d",
"assets/assets/cats/pexels-emir-kaan-okutan-2255565.jpg": "613b95800cd661262e82ef641b1617ed",
"assets/assets/cats/pexels-jos%25C3%25A9-andr%25C3%25A9s-pacheco-cortes-5456616.jpg": "edcdc55d07691a42a1721f0077d97cc4",
"assets/assets/cats/pexels-bianca-marolla-3030635.jpg": "b2f721fc21fce344f2cfab107fc46f90",
"assets/assets/cats/pexels-pixabay-271611.jpg": "8450f45d15d4c07a9e2d865dd3f23be4",
"assets/assets/cats/pexels-pixabay-160755.jpg": "c6a6bcbba0e4192f8893e2598ac3884d",
"assets/assets/cats/pexels-matteo-petralli-1828875.jpg": "dd08c2432be377c3891b7ea791dabcd3",
"assets/assets/cats/pexels-levent-simsek-4411430.jpg": "b9abdb793b63f131505b9be2a6e0924e",
"assets/assets/cats/pexels-hugo-zoccal-fernandes-laguna-1299518.jpg": "93a88e761abb64e5dedb3aac3085d186",
"assets/assets/cats/pexels-danielle-daniel-479009.jpg": "5b7f09c6a65b290f0e0f41f3c7d00fcc",
"assets/assets/cats/pexels-aleksandr-nadyojin-4492149.jpg": "9b9faae400808fe4e9e67be07c300108",
"assets/assets/cats/pexels-akbar-nemati-5622738.jpg": "cbe9ebe9b2a9cc25e603d58b04c92d28",
"assets/assets/cats/pexels-mark-burnett-731553.jpg": "d61b55de3f5fdcfeaf217668a37fedf4",
"assets/assets/cats/pexels-matthias-oben-5281143.jpg": "4d0bd77338115d19fd8cf71986224875",
"assets/assets/cats/pexels-mustafa-ezz-979503.jpg": "e7af81c3de48eef34928253ccd0fc22d",
"assets/assets/cats/pexels-pixabay-45201.jpg": "a7c853935ad3f6aa7ca3ec481baba300",
"assets/assets/cats/pexels-tomas-ryant-2693561.jpg": "e4e13c2c9f18baad1d883ad99ec814d7",
"assets/assets/cats/pexels-flickr-156321.jpg": "dcf82404de13b1f6a90ecc02269eeeac",
"assets/assets/cats/pexels-%25D0%25B0%25D0%25BB%25D0%25B5%25D0%25BA%25D1%2581%25D0%25B0%25D0%25BD%25D0%25B4%25D0%25B0%25D1%2580-%25D1%2586%25D0%25B2%25D0%25B5%25D1%2582%25D0%25B0%25D0%25BD%25D0%25BE%25D0%25B2%25D0%25B8%25D1%259B-1440406.jpg": "d49b8aedde8300f7b635b7b214a7d12b",
"assets/assets/cats/pexels-david-savochka-192384.jpg": "5a80fc5ad0733a9ee4f7b4969c7c9eba",
"assets/assets/cats/pexels-pixabay-104827.jpg": "06bbec07792b3f215df21e82da5fd41f",
"assets/assets/GitHub-Mark-32px.png": "f87561b8bb354ef83b09a66e54f70e08",
"assets/assets/GitHub-Mark-Light-32px.png": "d56df49a807a9fd06eb1667a84d3810e",
"assets/assets/cats_small/pexels-d%25C6%25B0%25C6%25A1ng-nh%25C3%25A2n-2817405.jpg": "9ff1b0b8da67b705e87e461bc2ac7c65",
"assets/assets/cats_small/pexels-pixabay-45170.jpg": "85803c958a598f98a67417d52ee30534",
"assets/assets/cats_small/pexels-piers-olphin-5044690.jpg": "b1c1770ce81ae5e9694c6ed6c9a6e70d",
"assets/assets/cats_small/pexels-emily-geibel-3772262.jpg": "92d459139de64a11b6ccf9ed8d9f6cdd",
"assets/assets/cats_small/pexels-xue-guangjian-1687831.jpg": "a64e128592263eed15f4e4fa6489bc52",
"assets/assets/cats_small/pexels-zhang-kaiyv-4858815.jpg": "25b31772138ea50e93ad40f5809d2625",
"assets/assets/cats_small/pexels-peng-louis-1643457.jpg": "50b2f9f51924d4c72c28e39e3abc548a",
"assets/assets/cats_small/pexels-halil-i%25CC%2587brahim-%25C3%25A7eti%25CC%2587n-1754986.jpg": "84af744c2974d5f5b0ce39cd9759faf8",
"assets/assets/cats_small/pexels-christopher-schruff-720684.jpg": "09761a919cd7574b0408630e85c4657a",
"assets/assets/cats_small/pexels-faris-subriun-4391733.jpg": "abe2fd728958d98316ba76c0174e6280",
"assets/assets/cats_small/pexels-jan-kop%25C5%2599iva-5800065.jpg": "a7584528d44c86929f45b3079698c626",
"assets/assets/cats_small/pexels-engin-akyurt-1571724.jpg": "c2129a5fc73007cc76c4a1a3b56b7ce7",
"assets/assets/cats_small/pexels-utku-koylu-2611939.jpg": "ae9a5ae1092816dc5670b662301a8725",
"assets/assets/cats_small/pexels-fotografierende-3127729.jpg": "b765a8bc2f39a715e237c85135ac95b4",
"assets/assets/cats_small/pexels-leonardo-de-oliveira-1770918.jpg": "3dcbf581dea92cfad8eaf7e3bddfe8ac",
"assets/assets/cats_small/pexels-peng-louis-1653357.jpg": "62b8efce8203b1a3e4ac926663a03b18",
"assets/assets/cats_small/pexels-mati-mango-4734723.jpg": "1067bc613988270fd3d35ef7c1edac6e",
"assets/assets/cats_small/pexels-evg-culture-1416792.jpg": "695876f349f3061ab968f6d13f8ac561",
"assets/assets/cats_small/pexels-luan-oosthuizen-1784289.jpg": "c00593cbbe69c034f81102fbcc00e731",
"assets/assets/cats_small/pexels-tamba-budiarsana-979247.jpg": "4c7d5f094009e311f6afc12dafa4755d",
"assets/assets/cats_small/pexels-anete-lusina-4790622.jpg": "9abd742cd503cde04c09c47ca2176042",
"assets/assets/cats_small/pexels-francesco-ungaro-96428.jpg": "34d88648c2424d210efd7d9e1cb3e8cd",
"assets/assets/cats_small/pexels-emir-kaan-okutan-2255565.jpg": "fff3e26fbd362092a1c5a58571008b59",
"assets/assets/cats_small/pexels-jos%25C3%25A9-andr%25C3%25A9s-pacheco-cortes-5456616.jpg": "c885db94765ffcb23a18178993b760ce",
"assets/assets/cats_small/pexels-bianca-marolla-3030635.jpg": "7a143fe8c8f7ac00e0ab256422e59bc0",
"assets/assets/cats_small/pexels-pixabay-271611.jpg": "8839fb1aa688899646fa874347c4d15c",
"assets/assets/cats_small/pexels-pixabay-160755.jpg": "599728d87776a241887fedc690eebf74",
"assets/assets/cats_small/pexels-matteo-petralli-1828875.jpg": "9ebaf260e9afed4064b2f27db951a119",
"assets/assets/cats_small/pexels-levent-simsek-4411430.jpg": "8aab8d4de786fad6b2afc79f0445ee2b",
"assets/assets/cats_small/pexels-hugo-zoccal-fernandes-laguna-1299518.jpg": "505215bea6dd2a222ae1a1107adee37b",
"assets/assets/cats_small/pexels-danielle-daniel-479009.jpg": "8d01d7ce4ee4835a2c5a7872496ad0a0",
"assets/assets/cats_small/pexels-aleksandr-nadyojin-4492149.jpg": "6fc3ee3182cf15aaa690c556c27fa8a5",
"assets/assets/cats_small/pexels-akbar-nemati-5622738.jpg": "2e70728a9b87687e58c1c3d3bc9f39d5",
"assets/assets/cats_small/pexels-mark-burnett-731553.jpg": "655da72061b5ca7666b452eb9fd904d8",
"assets/assets/cats_small/pexels-matthias-oben-5281143.jpg": "b4e8c61886b0bde388c7ede198b33270",
"assets/assets/cats_small/pexels-mustafa-ezz-979503.jpg": "e31d576449bb2592528a76c2e79b6ae8",
"assets/assets/cats_small/pexels-pixabay-45201.jpg": "14f8179606caeb8c563dc4205b161419",
"assets/assets/cats_small/pexels-tomas-ryant-2693561.jpg": "14b709041d0c0e739ca0c5a49c86f063",
"assets/assets/cats_small/pexels-flickr-156321.jpg": "ee422c536a26e3a26d8e4732b34c275a",
"assets/assets/cats_small/pexels-%25D0%25B0%25D0%25BB%25D0%25B5%25D0%25BA%25D1%2581%25D0%25B0%25D0%25BD%25D0%25B4%25D0%25B0%25D1%2580-%25D1%2586%25D0%25B2%25D0%25B5%25D1%2582%25D0%25B0%25D0%25BD%25D0%25BE%25D0%25B2%25D0%25B8%25D1%259B-1440406.jpg": "3400f2db63c70d75bb9019fe3f6bde00",
"assets/assets/cats_small/pexels-david-savochka-192384.jpg": "86ef015ed5353520a573bd6b67f77b3b",
"assets/assets/cats_small/pexels-pixabay-104827.jpg": "c652943766be78b2b6a9fe5334379f5d",
"assets/FontManifest.json": "4f2b8e88558decd743a589d02a5fdbee",
"manifest.json": "728a7628da12f2b36b2879a3f7fa9938",
"version.json": "341c101d4b678f29adc2e2fa68fd71f3",
"index.html": "ac142025250834f157fcfb0d572845e8",
"/": "ac142025250834f157fcfb0d572845e8",
"icons/Icon-512.png": "f9606f95519ac4aac78099a8873f5116",
"icons/Icon-192.png": "f9606f95519ac4aac78099a8873f5116"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
