import 'package:hive/hive.dart';
part 'message.g.dart'; // run 'flutter packages pub run build_runner build' in terminal to generate this file

@HiveType(typeId: 1)
class Message extends HiveObject {
  @HiveField(0)
  String sender;

  @HiveField(1)
  bool isMine;

  @HiveField(2)
  String msg;

  @HiveField(3)
  String color;

  @HiveField(4)
  DateTime time;

  Message({
    required this.sender,
    required this.isMine,
    required this.msg,
    required this.color,
    required this.time,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      sender: json['sender'],
      isMine: json['isMine'],
      msg: json['msg'],
      color: json['color'],
      time: json['time'],
    );
  }

  // Add the toJson method for Message
  Map<String, dynamic> toJson() => {
        'sender': sender,
        'isMine': isMine,
        'msg': msg,
        'color': color,
        'time': time,
      };
}
