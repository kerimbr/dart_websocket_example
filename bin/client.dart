
import 'dart:io';

Future main() async{

  final socket = await WebSocket.connect('ws://localhost:4040/ws');
  print('Connected to server!');

  // Read a line from the console
  print('Enter your username: ');
  final username = stdin.readLineSync();

  // Send a message to the server
  socket.add('Hello, server! My name is $username');

  // Listen for incoming messages from the server
  socket.listen((message) {
    print('Received message: $message');
  });

}