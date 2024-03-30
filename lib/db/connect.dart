import 'package:hive_flutter/hive_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'models/message.dart';
import 'models/room.dart';
import 'models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> registerAdapters() async {
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(RoomAdapter());
  Hive.registerAdapter(MessageAdapter());
}

class Socket { 
  IO.Socket socket = IO
      .io(dotenv.env['Server_Link'], <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': true,
    'retry': true,
  });

  void connect() {
    socket.connect();
  }

  void disconnect() {
    socket.disconnect();
  }

  void emit(String event, dynamic data) {
    socket.emit(event, data);
  }

  void on(String event, Function callback) {
    socket.on(event, (dynamic data) {
      callback(data);
    });
  }
}

Socket server = Socket();
