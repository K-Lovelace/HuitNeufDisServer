if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/serviceworker.js', { scope: './' })
    .then(function(registration) {
      console.log('Successfully registered!', ':^)', registration);
      registration.pushManager.subscribe({
        userVisibleOnly: true,
        applicationServerKey: window.vapidPublicKey
      })
      .then(function(subscription) {
          console.log('endpoint:', subscription.endpoint);
          $.post("/subscribe", { subscription: subscription.toJSON() })
      });
    }).catch(function(error) {
      console.log('Registration failed', ':^(', error);
    });
}
