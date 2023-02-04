import 'dart:io';

Future<void> main() async {
  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 4040);
  print('Listening on localhost:${server.port}');

  await for (HttpRequest request in server) {
    if (request.uri.path == '/ws') {
      // Upgrade an HttpRequest to a WebSocket connection
      var socket = await WebSocketTransformer.upgrade(request);
      print('Client connected!');

      // Listen for incoming messages from the client
      socket.listen((message) {
        print('Received message: $message');
        socket.add('You sent: $message');
      });
    } else {
      request.response.statusCode = HttpStatus.forbidden;
      request.response.close();
    }
  }
}
