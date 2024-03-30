import 'package:boting/db/connect.dart';

void sendMessage(userid, roomid, author, message, color, time) {
  server.emit('send_message', {
    'userid': userid,
    'room': roomid,
    'author': author,
    'message': message,
    'color': color,
    'time': time.toString(),
  });
}
