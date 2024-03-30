import 'package:boting/db/room_functions.dart';
import 'package:flutter/material.dart';
import 'package:boting/widgets/functions.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class HostDialog extends StatefulWidget {
  const HostDialog({super.key});

  @override
  State<HostDialog> createState() => _HostDialogState();
}

class _HostDialogState extends State<HostDialog> {
  String name = '';
  String roomName = '';
  String color = '';
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _roomNameFocus = FocusNode();

  Color pickerColor = hexToColor("#ffffff");

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  // Validation for the Name TextField
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

  // Validation for the Room Name TextField
  String? validateRoomName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Room name cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Host a room'),
      // backgroundColor: hexToColor("#CFC8C8"),
      backgroundColor: const Color.fromARGB(238, 163, 163, 163),
      // border radius
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              focusNode: _nameFocus,
              onChanged: (value) => name = value,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
                hintText: 'Enter your name',
                labelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              onChanged: (value) => roomName = value,
              focusNode: _roomNameFocus,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Room Name',
                hintText: 'Enter room name',
                labelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
            // add color picker
            ColorPicker(
                pickerColor: pickerColor,
                onColorChanged: changeColor,
                hexInputBar: true,
                // set height of dialog
                pickerAreaHeightPercent: 0.8,
                colorPickerWidth: 200.0,
                pickerAreaBorderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                )),
          ],
        ),
      ),
      actions: [
        Row(
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(120, 50),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
              ),
              child: const Text('Back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(120, 50),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
              child: const Text('Host'),
              onPressed: () {
                if (validateName(name) != null) {
                  // Set Focus to the TextField
                  FocusScope.of(context).requestFocus(_nameFocus);
                  return;
                } else if (validateRoomName(roomName) != null) {
                  // Set Focus to the TextField
                  FocusScope.of(context).requestFocus(_roomNameFocus);
                  return;
                }
                Navigator.of(context).pop();
                bool status =
                    hostRoom(name, colorToHexColor(pickerColor), roomName);
                if (status) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Room hosted successfully'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Room hosting failed'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

class JoinDialog extends StatefulWidget {
  const JoinDialog({super.key});

  @override
  State<JoinDialog> createState() => _JoinDialogState();
}

class _JoinDialogState extends State<JoinDialog> {
  Color pickerColor = hexToColor("#ffffff");
  String name = '';
  String roomLink = '';
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _roomLinkFocus = FocusNode();

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  // Validation for the Name TextField
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

  // Validation for the Room Link TextField
  String? validateRoomLink(String? value) {
    if (value == null || value.isEmpty) {
      return 'Room link cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Join a room'),
      backgroundColor: hexToColor("#CFC8C8"),
      // border radius
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              focusNode: _nameFocus,
              onChanged: (value) => name = value,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
                hintText: 'Enter your name',
                labelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              focusNode: _roomLinkFocus,
              onChanged: (value) => roomLink = value,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Room Link',
                hintText: 'Enter room link',
                labelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
            // add color picker
            ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
              hexInputBar: true,
              pickerAreaHeightPercent: 0.8,
              colorPickerWidth: 200.0,
              pickerAreaBorderRadius: const BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(120, 50),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Back'),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(120, 50),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
              onPressed: () {
                if (validateName(name) != null) {
                  // Set Focus to the TextField
                  FocusScope.of(context).requestFocus(_nameFocus);
                  return;
                } else if (validateRoomLink(roomLink) != null) {
                  // Set Focus to the TextField
                  FocusScope.of(context).requestFocus(_roomLinkFocus);
                  return;
                } else {
                  joinRoom(name, colorToHexColor(pickerColor), roomLink,
                      (status) {
                    if (status) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Room joined successfully'),
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    } else {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Room joining failed'),
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    }
                  });
                }
              },
              child: const Text('Join'),
            ),
          ],
        ),
      ],
    );
  }
}
