import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: Container(
                    child: const CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage('assets/image/butterfly.png'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Column(
                  children: [
                    Neumorphic(
                      style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(30)),
                        depth: 1,
                        lightSource: LightSource.bottom,
                      ),
                      child: NeumorphicSwitch(
                        value: themeProvider.isDarkMode,
                        onChanged: (value) {
                          themeProvider.toggleTheme();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "dark Mode",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Center(
                child: Text(
              "Welcom to my buttery fly app",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            )),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: NeumorphicButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/SingIn');
                },
                style: NeumorphicStyle(
                  color: Color.fromARGB(255, 21, 255, 13),
                  lightSource: LightSource.bottom,
                  depth: 20,
                  // boxShape: NeumorphicBoxShape.rect(),
                ),
                child: Text(
                  'SingIn',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            NeumorphicButton(
              onPressed: () {
                Navigator.pushNamed(context, '/SignUp');
              },
              style: NeumorphicStyle(
                color: Color.fromARGB(255, 21, 255, 13),
                lightSource: LightSource.bottom,
              ),
              child: Text(
                'SingUp',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
