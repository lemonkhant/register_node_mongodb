import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:register_app/screen/dashboard.dart';
import 'package:register_app/screen/singin_page.dart';
import 'package:register_app/screen/singup_page.dart';
import 'package:register_app/screen/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(
    MyApp(
      token: prefs.getString('token'),
    ),
  );
}

class MyApp extends StatelessWidget {
  final token;

  MyApp({@required this.token, Key? key}) : super(key: key);

  final Map<String, WidgetBuilder> routes = {
    '/': (BuildContext context) => WelcomePage(),
    '/SingIn': (BuildContext context) => SingInPage(),
    '/SignUp': (BuildContext context) => SingUpPage(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:
                themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            // routes: {
            //   '/': (context) => HomePage(),
            //   '/welcome': (context) => WelcomePage(),
            //   '/SingIn': (context) => SingInPage(),
            //   '/SignUp': (context) => SingUpPage(),
            //   '/Dashboard': (context) => Dashboard(),
            //   // '/dashboard' : (context) => Dashboard(token: );
            // },
            home: (JwtDecoder.isExpired(token) == false)
                ? Dashboard(token: token)
                : SingInPage());
      }),
    );
  }
}

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
