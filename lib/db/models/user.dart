import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String? userid;

  @HiveField(1)
  List<String>? usernames;

  @HiveField(2)
  List<String>? colors;

  @HiveField(3)
  List<String>? groups;

  User({this.userid, this.groups, this.colors, this.usernames});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userid: json['userid'],
      usernames: json['usernames'],
      colors: json['colors'],
      groups: json['groups'],
    );
  }

  Map<String, dynamic> toJson() => {
        'userid': userid,
        'usernames': usernames,
        'colors': colors,
        'groups': groups,
      };
}
