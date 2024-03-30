import 'package:boting/db/room_functions.dart';
import 'package:flutter/material.dart';
import 'package:boting/pages/chatloader.dart';
import 'package:flutter/services.dart';
import 'package:boting/pages/base.dart';

class Chat extends StatefulWidget {
  final String? chat;
  const Chat({this.chat, super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    String? link = getRoomLink(widget.chat!);
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Row(
            children: [
              Text(widget.chat!.split('|')[0]),
              const Spacer(),
              IconButton(
                onPressed: () {
                  String copydata =
                      'Room Name: ${widget.chat?.split('|')[0]} \nRoom Link: $link';
                  Clipboard.setData(ClipboardData(text: copydata));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(milliseconds: 1500),
                      showCloseIcon: true,
                      closeIconColor: Colors.white,
                      content: Text('Room Link copied to clipboard'),
                    ),
                  );
                },
                icon: const Icon(Icons.copy),
              ),
              IconButton(
                  onPressed: () {
                    // disconnectRoom(widget.chat!.split('|')[1]);
                    removeRoom(widget.chat!);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScreenManager(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.exit_to_app)),
              IconButton(
                  onPressed: () {
                    // open a dialog box with room details
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Room Details'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Room Name: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: SelectableText(
                                      widget.chat!.split('|')[0],
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Room Link: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: SelectableText(
                                      link!,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Room ID: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: SelectableText(
                                      widget.chat!.split('|')[1],
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.info)),
            ],
          ),
        ),
        body: ChatLoader(chatname: widget.chat!),
      ),
    );
  }
}
