import 'package:boting/db/connect.dart';
import 'package:boting/db/message_functions.dart';
import 'package:boting/db/models/message.dart';
import 'package:boting/db/room_functions.dart';
import 'package:boting/db/user_functions.dart';
import 'package:boting/widgets/functions.dart';
import 'package:flutter/material.dart';

class ChatLoader extends StatefulWidget {
  final String chatname;
  const ChatLoader({required this.chatname, super.key});

  @override
  State<ChatLoader> createState() => _ChatLoaderState(chatname);
}

class _ChatLoaderState extends State<ChatLoader> {
  final ScrollController _scrollController = ScrollController();
  late bool isMine = false;
  late Color color = hexToColor('#ffffff');
  final TextEditingController _messageController = TextEditingController();
  Map<String, String> userDetails = {};

  List<Message>? _messages = [];

  @override
  void initState() {
    super.initState();
    userDetails = getUserDetailsFromGroup(widget.chatname);
    _loadMessages();
  }

  _ChatLoaderState(String chatname) {
    server.emit('connectRoom', chatname.split('|')[1]);
    Future.delayed(const Duration(milliseconds: 500), () {
      _registerMessageListener();
    });
  }

  void scrollToBottom(){
    Future.delayed(const Duration(milliseconds: 500), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
      );
    });
  }

  void _registerMessageListener() {
    print('registering message listener');
    server.on('receive_message', (data) {
      String sender = data['author'];
      String message = data['message'];
      String color = data['color'];
      String time = data['time'];
      _receiveMessage(sender, message, color, time);
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMessages() {
    _messages = getMessages(widget.chatname);
  }

  void _sendMessage(String message) {
    setState(() {
      sendMessage(
          userDetails['userid']!,
          userDetails['roomid']!,
          userDetails['username']!,
          message,
          userDetails['color']!,
          DateTime.now());

      updateMessages(
          widget.chatname,
          Message(
            sender: userDetails['username']!,
            isMine: true,
            msg: message,
            color: userDetails['color']!,
            time: DateTime.now(),
          ));
      scrollToBottom();
    });
    _messageController.clear();
  }

  void _receiveMessage(
      String sender, String message, String color, String time) {
    setState(() {
      updateMessages(
          widget.chatname,
          Message(
            sender: sender,
            isMine: false,
            msg: message,
            color: color,
            time: DateTime.parse(time),
          ));
      scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/chatbg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages?.length,
              itemBuilder: (context, index) {
                final message = _messages![index];
                return ChatBubble(
                  sender: message.sender,
                  isMine: message.isMine,
                  msg: message.msg,
                  color: hexToColor(message.color),
                  time: message.time,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: 'Enter a message',
                      hintStyle: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _sendMessage(_messageController.text);
                  },
                  icon: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String sender;
  final bool isMine;
  final String msg;
  final Color color;
  final DateTime? time;

  const ChatBubble({
    required this.sender,
    required this.isMine,
    required this.msg,
    required this.color,
    this.time,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: isMine ? Alignment.topRight : Alignment.topLeft,
      widthFactor: 0.7,
      child: Align(
        alignment: isMine ? Alignment.topRight : Alignment.topLeft,
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isMine
                ? hexToColor("#222222")
                : const Color.fromARGB(255, 56, 56, 56),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment:
                isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Align(
                alignment: isMine ? Alignment.topRight : Alignment.topLeft,
                child: Text(
                  sender,
                  style: TextStyle(
                    fontSize: 18,
                    color: color,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: Text(
                  msg,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              if (time != null)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    time!.toString().split('.')[0],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white38,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
