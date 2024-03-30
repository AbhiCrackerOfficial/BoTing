import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:boting/widgets/functions.dart';
import 'package:boting/widgets/widgets.dart';

class Bg extends StatelessWidget {
  const Bg({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/mainbg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 148,
            top: MediaQuery.of(context).size.height / 2 - 206,
            child: Container(
              width: 296,
              height: 412,
              decoration: BoxDecoration(
                border: Border.all(width: 0.50, color: Colors.white),
                borderRadius: BorderRadius.circular(55),
              ),
              child: BlurryContainer(
                width: 296,
                height: 412,
                blur: 2,
                borderRadius: BorderRadius.circular(55),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                const HostDialog(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: hexToColor("#858585"),
                          minimumSize: const Size(180, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Host',
                          style: GoogleFonts.orbitron(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                const JoinDialog(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: hexToColor("#858585"),
                          minimumSize: const Size(180, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                  
                        ),
                        child: Text(
                          'Join',
                          style: GoogleFonts.orbitron(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Bg();
  }
}
