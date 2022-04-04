'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/NOTICES": "0679d7a087090e6da074f94d79ee6455",
"assets/assets/icon.png": "1fc784623c7400939b69f406614c3172",
"assets/assets/padlocks/caesar-2.svg": "cfdcf49832edf02bdd1ab5ea25cf9726",
"assets/assets/padlocks/caesar-1.svg": "f6a399845406fbe5174616524f9e6a65",
"assets/assets/logo.png": "366f9215a835867149d5882b708f3ec4",
"assets/assets/interactables/desk-key.svg": "5038c9d9ae8873f2b512f254f3a32ab6",
"assets/assets/interactables/bed-key.svg": "d8373517439ba3d1bb294d759bced434",
"assets/assets/interactables/arrow.svg": "780ea91ce174feab7cd8581223f811db",
"assets/assets/interactables/bookshelf-key.svg": "07c4fb7f8448471f70b9855c15973fd4",
"assets/assets/backgrounds/title.png": "8dff6fbd3eba4bfcca79e6ccd5c05d32",
"assets/assets/backgrounds/living-room.png": "dee5607425252c6aa4e7ebfe9573e049",
"assets/assets/backgrounds/bedroom.png": "48f4575f75cb2291ea6bdec709fb8b12",
"assets/assets/backgrounds/desk.png": "82475b19f120dab61222d6e0e56139d3",
"assets/assets/backgrounds/bedroom-present.png": "f47ed761772bdb02be2978dd5e4e4f28",
"assets/assets/glitch/image.webp": "415179c244a05860e26dfe2d6d16067c",
"assets/assets/glitch/noise.mp3": "c57fa09005c1d90beb12aec4f3bdb6fd",
"assets/assets/fonts/SourceCodePro-Regular.ttf": "466c16539d649374e96c7f1f2f478330",
"assets/FontManifest.json": "cd5c717b0a975944e3c1a919b6656da9",
"assets/AssetManifest.json": "fe7b77893cd03412abb5ec99e105cb11",
"assets/packages/window_manager/images/ic_chrome_maximize.png": "af7499d7657c8b69d23b85156b60298c",
"assets/packages/window_manager/images/ic_chrome_minimize.png": "4282cd84cb36edf2efb950ad9269ca62",
"assets/packages/window_manager/images/ic_chrome_close.png": "75f4b8ab3608a05461a31fc18d6b47c2",
"assets/packages/window_manager/images/ic_chrome_unmaximize.png": "4a90c1909cb74e8f0d35794e2f61d8bf",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"manifest.json": "13af899f550d1e4388dc93ae36c43053",
"index.html": "6583e4ad9293ed5a7b3d4cb4025ec3f0",
"/": "6583e4ad9293ed5a7b3d4cb4025ec3f0",
"icons/icons.json": "3877111e7542901178e58b30f8e9f53c",
"icons/android/android-launchericon-48-48.png": "e3a89118628a2a7350faea5108b846f3",
"icons/android/android-launchericon-512-512.png": "62fec5c1279812d76cfa1bf40999c61f",
"icons/android/android-launchericon-192-192.png": "d90fa08a3cdc3fca982ec4897723d3c8",
"icons/android/android-launchericon-144-144.png": "9f1d48c11153f26b182bf30a770661ff",
"icons/android/android-launchericon-72-72.png": "df83003721851e2a54a0a4a5b62e6eb3",
"icons/android/android-launchericon-96-96.png": "aa3f78816410387ccd3e05e11202b38b",
"icons/windows11/Square44x44Logo.altform-lightunplated_targetsize-80.png": "d7a2c026469068c7b4c11982d70845ae",
"icons/windows11/Square44x44Logo.altform-lightunplated_targetsize-64.png": "fb506c2d063c4318256538226b649a66",
"icons/windows11/Square44x44Logo.targetsize-30.png": "ac7d97a62c05520138b4378ca0eb5f06",
"icons/windows11/Square44x44Logo.altform-lightunplated_targetsize-32.png": "eda1060b22eb423ffebe2f076124e048",
"icons/windows11/LargeTile.scale-200.png": "5454d37bcc4ecb65d597e005e9d1649b",
"icons/windows11/Square44x44Logo.scale-150.png": "5fa142653ea0976edaea30b444908686",
"icons/windows11/StoreLogo.scale-150.png": "0c133a3b9a3e0fada582a12c5514d548",
"icons/windows11/Square44x44Logo.altform-lightunplated_targetsize-60.png": "737bacffb171fc610c9e65e58693780c",
"icons/windows11/StoreLogo.scale-400.png": "9b042a8962367a9e825443e62a8fa43c",
"icons/windows11/Square150x150Logo.scale-400.png": "02895b7c749c1b3ae1f585edb9831990",
"icons/windows11/Square44x44Logo.altform-unplated_targetsize-30.png": "ac7d97a62c05520138b4378ca0eb5f06",
"icons/windows11/Square44x44Logo.targetsize-48.png": "78fe7e596e5ae9eee62cabd152cfc772",
"icons/windows11/Square44x44Logo.altform-unplated_targetsize-24.png": "7747ab000af8f92e75e0768ff4d2fd5e",
"icons/windows11/Square44x44Logo.altform-lightunplated_targetsize-16.png": "907f851735558f2eecb6da9a150a5290",
"icons/windows11/Wide310x150Logo.scale-400.png": "da87f27e3cc833d00f6551aaec67af81",
"icons/windows11/SplashScreen.scale-400.png": "32213b62a03f83ed0614276685a9b9af",
"icons/windows11/Square44x44Logo.targetsize-80.png": "d7a2c026469068c7b4c11982d70845ae",
"icons/windows11/Square44x44Logo.altform-lightunplated_targetsize-96.png": "ec9a032544d771e5c1bef12c6c04f4d7",
"icons/windows11/SmallTile.scale-150.png": "94382d7f20712bb9a07b6e9ab9611881",
"icons/windows11/Wide310x150Logo.scale-150.png": "82f651ac5f7f82a83ced14bbf67faed5",
"icons/windows11/Square44x44Logo.altform-unplated_targetsize-48.png": "78fe7e596e5ae9eee62cabd152cfc772",
"icons/windows11/Square44x44Logo.altform-unplated_targetsize-40.png": "cc6abb082afc5f93a1af61a11a7e3957",
"icons/windows11/Square44x44Logo.targetsize-44.png": "fdde79ce993a22bae8bcd776da8219bd",
"icons/windows11/Square44x44Logo.altform-unplated_targetsize-16.png": "907f851735558f2eecb6da9a150a5290",
"icons/windows11/Square44x44Logo.targetsize-16.png": "907f851735558f2eecb6da9a150a5290",
"icons/windows11/Square44x44Logo.scale-100.png": "fdde79ce993a22bae8bcd776da8219bd",
"icons/windows11/SplashScreen.scale-100.png": "df84f66aa62ac67b2c36f0325bef9d10",
"icons/windows11/Square44x44Logo.altform-unplated_targetsize-256.png": "cf7f0eb8c9b3706c482411008d2dcc85",
"icons/windows11/Wide310x150Logo.scale-200.png": "df84f66aa62ac67b2c36f0325bef9d10",
"icons/windows11/Square44x44Logo.targetsize-72.png": "42c3b0315dc0e138b67ff0947c177b8d",
"icons/windows11/Square44x44Logo.scale-125.png": "8da94a4a31975026fa8e5351d24be0ad",
"icons/windows11/Square44x44Logo.targetsize-20.png": "3172ea4a93f5a6bd8908579d734cef6d",
"icons/windows11/StoreLogo.scale-100.png": "41f7a57e2646f7414b1e7e08fb2030f9",
"icons/windows11/Square44x44Logo.targetsize-24.png": "7747ab000af8f92e75e0768ff4d2fd5e",
"icons/windows11/Square44x44Logo.altform-lightunplated_targetsize-256.png": "cf7f0eb8c9b3706c482411008d2dcc85",
"icons/windows11/Square44x44Logo.altform-unplated_targetsize-96.png": "ec9a032544d771e5c1bef12c6c04f4d7",
"icons/windows11/SmallTile.scale-400.png": "b0c94aa963f9025cbdc483089e4cf6cd",
"icons/windows11/StoreLogo.scale-125.png": "d1d528152a5a7076690450f4ef074faf",
"icons/windows11/LargeTile.scale-150.png": "5a8d74ba69c92d3dee2af7d924f91cee",
"icons/windows11/Square44x44Logo.scale-400.png": "972ef7f522a772e1215a7f12347377d4",
"icons/windows11/Square44x44Logo.altform-unplated_targetsize-36.png": "f22ad6c2114e6b1074e3a423be528e33",
"icons/windows11/Square44x44Logo.targetsize-256.png": "cf7f0eb8c9b3706c482411008d2dcc85",
"icons/windows11/Square44x44Logo.altform-lightunplated_targetsize-20.png": "3172ea4a93f5a6bd8908579d734cef6d",
"icons/windows11/Square44x44Logo.targetsize-32.png": "eda1060b22eb423ffebe2f076124e048",
"icons/windows11/Wide310x150Logo.scale-125.png": "ed5b1ef6b6847cd51cf5b229503259c5",
"icons/windows11/Square44x44Logo.altform-unplated_targetsize-20.png": "3172ea4a93f5a6bd8908579d734cef6d",
"icons/windows11/Square44x44Logo.altform-lightunplated_targetsize-44.png": "fdde79ce993a22bae8bcd776da8219bd",
"icons/windows11/Square44x44Logo.altform-lightunplated_targetsize-36.png": "f22ad6c2114e6b1074e3a423be528e33",
"icons/windows11/Square150x150Logo.scale-125.png": "8045495a003e7f728352eb9ab1c85b8b",
"icons/windows11/Square44x44Logo.altform-lightunplated_targetsize-30.png": "ac7d97a62c05520138b4378ca0eb5f06",
"icons/windows11/SmallTile.scale-125.png": "c6b188ada8443bc6d688171a71155644",
"icons/windows11/Square44x44Logo.targetsize-64.png": "fb506c2d063c4318256538226b649a66",
"icons/windows11/Square150x150Logo.scale-150.png": "efccd78ab2a8a189e967f6dd012fe1f2",
"icons/windows11/Square150x150Logo.scale-200.png": "450c105339ccd5a925cad5eaa73d62ed",
"icons/windows11/Square44x44Logo.altform-unplated_targetsize-64.png": "fb506c2d063c4318256538226b649a66",
"icons/windows11/SmallTile.scale-100.png": "5a732dc368fb04ca17bdfd4f53dcf396",
"icons/windows11/Square44x44Logo.targetsize-40.png": "cc6abb082afc5f93a1af61a11a7e3957",
"icons/windows11/Square44x44Logo.altform-unplated_targetsize-60.png": "737bacffb171fc610c9e65e58693780c",
"icons/windows11/Square150x150Logo.scale-100.png": "ff8027a92918964a83665a48a7baefa0",
"icons/windows11/Square44x44Logo.altform-lightunplated_targetsize-40.png": "cc6abb082afc5f93a1af61a11a7e3957",
"icons/windows11/Square44x44Logo.altform-unplated_targetsize-72.png": "42c3b0315dc0e138b67ff0947c177b8d",
"icons/windows11/Square44x44Logo.altform-lightunplated_targetsize-24.png": "7747ab000af8f92e75e0768ff4d2fd5e",
"icons/windows11/Square44x44Logo.altform-lightunplated_targetsize-48.png": "78fe7e596e5ae9eee62cabd152cfc772",
"icons/windows11/SplashScreen.scale-150.png": "8b86c2829488e27ff08856acd90d0308",
"icons/windows11/Square44x44Logo.targetsize-36.png": "f22ad6c2114e6b1074e3a423be528e33",
"icons/windows11/SplashScreen.scale-125.png": "3d338756f02917396c4b27d39999c3d0",
"icons/windows11/Square44x44Logo.altform-lightunplated_targetsize-72.png": "42c3b0315dc0e138b67ff0947c177b8d",
"icons/windows11/LargeTile.scale-125.png": "daf8cf9c10d2fcada1fa2a6a78deef36",
"icons/windows11/Square44x44Logo.targetsize-96.png": "ec9a032544d771e5c1bef12c6c04f4d7",
"icons/windows11/Square44x44Logo.scale-200.png": "9185f5541ec5ed5c1f4abdf30a9fc5ec",
"icons/windows11/Square44x44Logo.altform-unplated_targetsize-44.png": "fdde79ce993a22bae8bcd776da8219bd",
"icons/windows11/SmallTile.scale-200.png": "9a731d345a528793cc5bddc2c98b6686",
"icons/windows11/Wide310x150Logo.scale-100.png": "d27e3f356028c86b35a49d0166679fb0",
"icons/windows11/SplashScreen.scale-200.png": "da87f27e3cc833d00f6551aaec67af81",
"icons/windows11/LargeTile.scale-100.png": "650fe55a88a056575471b8c14c8fa642",
"icons/windows11/LargeTile.scale-400.png": "d4c44e756749c2d530da6101e496dd31",
"icons/windows11/Square44x44Logo.altform-unplated_targetsize-80.png": "d7a2c026469068c7b4c11982d70845ae",
"icons/windows11/StoreLogo.scale-200.png": "53c6d2b8b9f578f11cf8870eea61a725",
"icons/windows11/Square44x44Logo.targetsize-60.png": "737bacffb171fc610c9e65e58693780c",
"icons/windows11/Square44x44Logo.altform-unplated_targetsize-32.png": "eda1060b22eb423ffebe2f076124e048",
"icons/ios/144.png": "9f1d48c11153f26b182bf30a770661ff",
"icons/ios/192.png": "d90fa08a3cdc3fca982ec4897723d3c8",
"icons/ios/50.png": "41f7a57e2646f7414b1e7e08fb2030f9",
"icons/ios/40.png": "a3b366076280582088eea59b2cd05b13",
"icons/ios/76.png": "dcdc41cf04b5739152cc5549cba0f5a8",
"icons/ios/58.png": "5fb8437d79c5e9de0fa59dafdcd09be9",
"icons/ios/60.png": "1a99c30b20395de6b1733694e5e6f1e7",
"icons/ios/80.png": "b15b87b207c5d69530b188e185f85fda",
"icons/ios/87.png": "b9bae2a9105bfc3fd19674327d99e3ed",
"icons/ios/114.png": "8439f7e13e5e826235bdbd7ae703bf06",
"icons/ios/512.png": "62fec5c1279812d76cfa1bf40999c61f",
"icons/ios/152.png": "5e8ac97460438c991f3024497c81fd91",
"icons/ios/1024.png": "16844898f7256fa4a7059017b2ed0234",
"icons/ios/100.png": "53c6d2b8b9f578f11cf8870eea61a725",
"icons/ios/16.png": "844886d7c5aff145461df0b0233e056f",
"icons/ios/29.png": "e9663d8ad4a7ed3a3386ac0364edcfd6",
"icons/ios/32.png": "6992f592a0082e1daa4be6b0be64ca2b",
"icons/ios/20.png": "241e443858451494b1d7da13e0b4ea23",
"icons/ios/128.png": "0427d81c48f8c10b61710d6b170131ec",
"icons/ios/256.png": "77b4221c576b7b29ff313c31b7241b5d",
"icons/ios/57.png": "28a2ec8c73860da77361c6485e973f5e",
"icons/ios/120.png": "979166e3cc06eb01a078a3f654b2883f",
"icons/ios/180.png": "95f5bbba47ed8984fcb1a236c62e18bf",
"icons/ios/167.png": "c20c69b044532835f78c037db0a5b45e",
"icons/ios/72.png": "df83003721851e2a54a0a4a5b62e6eb3",
"icons/ios/64.png": "4627a6ddbf0b29127456734db6cc13eb",
"favicon.ico": "add32ebb3a78e5bed3d5f11ff4c944e8",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"main.dart.js": "4674c338513fda9c42a8eedea71c20ee",
"version.json": "0fde7eb6022326bfe8262a51a6cc35f6"
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
