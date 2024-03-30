import 'package:boting/db/connect.dart';
import 'package:boting/db/user_functions.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/message.dart';
import 'models/room.dart';
import 'models/user.dart';

Box<Room> roomBox = Hive.box<Room>('RoomBox');

bool hostRoom(String username, String hexcolor, String roomname) {
  bool status = true;
  String userid = getUserDetails()['userid'];

  server.emit('CreateRoom', {
    'id': userid,
    'username': username,
    'color': hexcolor,
    'roomname': roomname,
  });

  server.on('RoomDetail', (data) {
    if (data['success'] == false) {
      status = false;
    } else {
      Room room = Room(
        id: data['roomid'],
        name: roomname,
        link: data['link'],
        createdAt: DateTime.parse(data['createat']),
        messages: [],
      );
      String roomid = data['roomid'];
      roomBox.put('$roomname|$roomid', room);
      updateUser(username, hexcolor, roomname, data['roomid']);
    }
  });
  return status;
}

bool groupExists(String groupname, String groupid) {
  User? currentUser = userBox.get('currentUser');
  String group = '$groupname|$groupid';
  if (currentUser?.groups?.contains(group) == true) {
    return true;
  }
  return false;
}

void joinRoom(
    String username, String hexcolor, String link, Function(bool) onStatus) {
  String userid = getUserDetails()['userid'];

  server.emit('joinRoom', {
    'id': userid,
    'username': username,
    'color': hexcolor,
    'link': link,
  });

  server.on('RoomDetail', (data) {
    bool status = true;

    if (data['success'] == false) {
      status = false;
    } else if (groupExists(data['roomname'], data['roomid'])) {
      status = false;
    } else {
      Room room = Room(
        id: data['roomid'],
        name: data['roomname'],
        link: data['link'],
        createdAt: DateTime.parse(data['createat']),
        messages: [],
      );
      String roomid = data['roomid'];
      roomBox.put('${data['roomname']}|$roomid', room);
      updateUser(username, hexcolor, data['roomname'], data['roomid']);
    }

    onStatus(status);
  });
}

List<String>? getGroupsfromUserBox() {
  // get groups list from the UserBox
  User? currentUser = userBox.get('currentUser');
  // return the groups list
  return currentUser?.groups;
}

List<Message>? getMessages(chat) {
  // get messages list from the RoomBox
  List? messages = roomBox.get(chat)?.messages;
  return messages as List<Message>?;
}

String? getRoomLink(chat) {
  // get room link from the RoomBox
  String? link = roomBox.get(chat)?.link;
  return link;
}

void updateMessages(String chat, Message message) {
  // Get the messages list from the RoomBox for the given chat
  final room = roomBox.get(chat);
  if (room != null) {
    final List<Message> messages = room.messages ??
        []; // If messages list is null, initialize an empty list
    messages.add(message);

    // Update the room's messages list
    room.messages = messages;
    room.save(); // Save the changes to the RoomBox

  } else {
    // Handle the case when the chat or RoomBox is null
    print('Error: RoomBox not found for chat $chat.');
  }
}

void removeRoom(String chat) {
  // remove the room from the RoomBox
  roomBox.delete(chat);
  // remove the room from the UserBox
  User? currentUser = userBox.get('currentUser');
  // find index of the room in the groups list
  int index = currentUser?.groups?.indexOf(chat) ?? -1;
  if (index != -1) {
    // remove the room from the groups list
    currentUser?.groups?.removeAt(index);
    // remove the username from the usernames list
    currentUser?.usernames?.removeAt(index);
    // remove the color from the colors list
    currentUser?.colors?.removeAt(index);
    // update and save the changes to the UserBox
    userBox.put('currentUser', currentUser!);
  }
}
