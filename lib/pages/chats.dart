import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:boting/db/connect.dart';
import 'package:boting/db/room_functions.dart';
import 'package:boting/pages/chat.dart';
import 'package:flutter/material.dart';

class Bg extends StatelessWidget {
  const Bg({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/mainbg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: const Chats());
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Bg();
  }
}

class ChatBar extends StatelessWidget {
  final String name;
  const ChatBar(this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    // return scrollable list of chats
    return BlurryContainer(
      height: 60,
      blur: 5,
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Chat(chat: name),
            ),
          );
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white, width: 1),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        child: Row(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  name.split('|')[0],
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.left,
                )),
          ],
        ),
      ),
    );
  }
}

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  List<String>? groups = getGroupsfromUserBox();
  void totalUsers(chatname){
    String roomid = chatname.split('|')[1];
    print(roomid);
    server.emit('getMembers', roomid);
    server.on('getMembers', (data) {
      print(data);
      // return data;
    });
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groups?.length ?? 0,
      itemBuilder: (context, index) {
        // Access the group name at the current index
        String? group = groups?[index];
        return ChatBar(group!);
      },
    );
  }
}
