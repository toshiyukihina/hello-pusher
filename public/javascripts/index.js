// Enable pusher logging - don't include this in production
Pusher.log = function(message) {
  if (window.console && window.console.log) {
    window.console.log(message);
  }
};

var pusher = new Pusher('129722192f2fe7e62c8a');
var channel = pusher.subscribe('test_channel');
channel.bind('my_event', function(data) {
  alert(data.message);
});
