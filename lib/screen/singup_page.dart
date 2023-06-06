import 'dart:convert';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'package:register_app/config/config.dart';
import 'package:register_app/screen/dashboard.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;

  void registerUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var regBody = {
        "email": emailController.text,
        "password": passwordController.text
      };
      var response = await http.post(Uri.parse(register),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Dashboard(token: myToken)));
      } else {
        print("SomeThing Went Wrong");
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: Text(
            'SingUp',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                  ),
                  child: Center(
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage('assets/image/butterfly.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Welcome to SingUp",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Neumorphic(
                  style: NeumorphicStyle(
                    color: Color.fromARGB(255, 255, 197, 5),
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
                  ),
                  child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        icon: Icon(Icons.email_rounded),
                        hintText: 'email',
                        hintStyle: TextStyle(color: Colors.black),
                        errorStyle: TextStyle(color: Colors.white),
                        errorText: _isNotValidate ? "Enter Proper  Info" : null,
                        // labelText: 'email',
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                Neumorphic(
                  style: NeumorphicStyle(
                    color: Color.fromARGB(255, 255, 197, 5),
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
                  ),
                  child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        icon: Icon(Icons.password_sharp),
                        hintText: 'password',
                        hintStyle: TextStyle(color: Colors.black),
                        errorText: _isNotValidate ? "Enter Proper Info" : null,

                        // labelText: 'password',
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                NeumorphicButton(
                  onPressed: () {
                    registerUser(); // Navigator.pushNamed(context, "/");
                  },
                  style: NeumorphicStyle(
                    color: Color.fromARGB(255, 36, 243, 0),
                    boxShape: NeumorphicBoxShape.stadium(),
                  ),
                  child: Text(
                    "SingUp",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
