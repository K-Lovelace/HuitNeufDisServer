if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/serviceworker.js')
    .then(function(registration) {
      console.log('Successfully registered!', ':^)', registration);
    }).catch(function(error) {
      console.log('Registration failed', ':^(', error);
    });

    navigator.serviceWorker.ready.then((serviceWorkerRegistration) => {
      serviceWorkerRegistration.pushManager
      .subscribe({
        userVisibleOnly: true,
        applicationServerKey: window.vapidPublicKey
      }).then(pushSubscription => {
        console.log(
          "Received PushSubscription:",
          JSON.stringify(pushSubscription)
        );

        $.post('/subscribe', {subscription: JSON.stringify(pushSubscription)})
        return pushSubscription;
      });
    });
}


// Let's check if the browser supports notifications
if (!("Notification" in window)) {
  console.error("This browser does not support desktop notification");
}

// Let's check whether notification permissions have already been granted
else if (Notification.permission === "granted") {
  console.log("Permission to receive notifications has been granted");
}

// Otherwise, we need to ask the user for permission
else if (Notification.permission !== 'denied') {
  Notification.requestPermission(function (permission) {
  // If the user accepts, let's create a notification
    if (permission === "granted") {
      console.log("Permission to receive notifications has been granted");
    }
  });
}