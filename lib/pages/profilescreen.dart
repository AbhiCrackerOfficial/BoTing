import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:boting/db/user_functions.dart';
import 'package:boting/main.dart';
import 'package:boting/widgets/functions.dart';
import 'package:flutter/material.dart';
// import 'package:boting/main.dart';

class Bg extends StatelessWidget {
  const Bg({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> userDetails = getUserDetails();
    // print(getrom)
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/mainbg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Profile(userDetails: userDetails),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Bg();
  }
}

class Profile extends StatelessWidget {
  final Map<String, dynamic> userDetails;
  const Profile({required this.userDetails, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
        ),
        TextField(
          controller: TextEditingController(text: userDetails['userid']),
          readOnly: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            labelText: 'Your ID',
            labelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            hintStyle: TextStyle(color: Colors.white),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white, // Outline border color when focused
              ),
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  const SplashScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
            ),
            child: const Text('Restart')),
        Expanded(
          child: ListView.builder(
              itemCount: userDetails['groups'].length,
              itemBuilder: (context, index) {
                // access the group name
                String groupname = userDetails['groups'][index];
                String username = userDetails['usernames'][index];
                Color color = hexToColor(userDetails['colors'][index]);
                return BlurryContainer(
                  height: 60,
                  blur: 5,
                  child: OutlinedButton(
                    onPressed: () {},
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
                              groupname.split('|')[0],
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                              textAlign: TextAlign.left,
                            )),
                        const Spacer(),
                        const Align(
                            alignment: Alignment.centerRight,
                            child: Row(children: [
                              Icon(Icons.person_pin, color: Colors.white),
                              SizedBox(width: 3),
                            ])),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              username,
                              style: TextStyle(fontSize: 20, color: color),
                              textAlign: TextAlign.right,
                            )),
                      ],
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
