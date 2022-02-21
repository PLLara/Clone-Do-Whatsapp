importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts(
  "https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js"
);

firebase.initializeApp({
  apiKey: "AIzaSyBGk-UQzUi87TkW-EPv75PXmXiZ_2n2ONU",
  appId: "1:1005267707114:web:991ad2d96cbe856a6d2393",
  messagingSenderId: "1005267707114",
  projectId: "whatsappi-2",
  authDomain: "whatsappi-2.firebaseapp.com",
  databaseURL: "https://whatsappi-2-default-rtdb.firebaseio.com",
  storageBucket: "whatsappi-2.appspot.com",
  measurementId: "G-9VR129Y8JL",
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});
