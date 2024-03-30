import 'package:boting/db/models/message.dart';
import 'package:hive/hive.dart';
part 'room.g.dart'; // Generated file containing TypeAdapter

@HiveType(typeId: 2)
class Room extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? link;

  @HiveField(3)
  DateTime? createdAt;

  @HiveField(4)
  List<Message>? messages;

  Room({
    this.id,
    this.name,
    this.link,
    this.createdAt,
    this.messages,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      name: json['name'],
      link: json['link'],
      createdAt: json['createdAt'],
      messages: (json['messages'] as List<dynamic>)
          .map((messageJson) => Message.fromJson(messageJson))
          .toList(),
    );
  }

  // Add the toJson method for Room
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'link': link,
        'createdAt': createdAt,
        'messages': messages?.map((message) => message.toJson()).toList(),
      };
}
