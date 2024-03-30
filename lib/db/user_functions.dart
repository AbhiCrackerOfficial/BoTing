import 'package:boting/db/connect.dart';
import 'package:hive/hive.dart';
import 'models/user.dart';

Box<User> userBox = Hive.box<User>('UserBox');

void initUser() {
  User? currentUser = userBox.get('currentUser');
  String? userid;

  if (currentUser == null) {
    server.on('USERID', (data) {
      userid = data;
    });

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (userid == null) {
        initUser(); // Call itself recursively until the userid is obtained
      } else {
        userBox.put('currentUser',
            User(userid: userid, groups: [], usernames: [], colors: []));
        server.emit('ID', userid);
      }
    });
  } else {}
}

Map<String, dynamic> getUserDetails() {
  Map<String, dynamic> json = userBox.get('currentUser')?.toJson() ?? {};
  return json;
}

void updateUsernames(String? name) {
  User? currentUser = userBox.get('currentUser');
  if (name != null) {
    currentUser?.usernames?.add(name);
    userBox.put('currentUser', currentUser!);
  }
}

void updateColors(String? hexcode) {
  User? currentUser = userBox.get('currentUser');
  if (hexcode != null) {
    currentUser?.colors?.add(hexcode);
    userBox.put('currentUser', currentUser!);
  }
}

void updateGroups(String? groupname, String? groupid) {
  User? currentUser = userBox.get('currentUser');
  String? group = '$groupname|$groupid';
  if (groupname != null && groupid != null) {
    if (currentUser?.groups?.contains(group) == true) {
      return;
    }
    currentUser?.groups?.add(group);
    userBox.put('currentUser', currentUser!);
  }
}

void updateUser(
    String username, String color, String groupname, String groupid) {
  User? currentUser = userBox.get('currentUser');
  String? group = '$groupname|$groupid';
  if (currentUser?.groups?.contains(group) == true) {
    return;
  }
  currentUser?.groups?.add(group);
  userBox.put('currentUser', currentUser!);
  updateUsernames(username);
  updateColors(color);
}

Map<String, String> getUserDetailsFromGroup(String chat){
  User? currentUser = userBox.get('currentUser');
  int index = currentUser!.groups!.indexOf(chat);
  String username = currentUser.usernames![index];
  String color = currentUser.colors![index];
  String userid = currentUser.userid!;
  String roomid = chat.split('|')[1];
  return {
    'userid': userid,
    'roomid': roomid,
    'username': username,
    'color': color,
  };

}
