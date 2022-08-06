import 'package:fireshipapp/login/loginButton.dart';
import 'package:fireshipapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const FlutterLogo(
              size: 150,
            ),
            Flexible(
                child: LoginButton(
                    color: Colors.deepPurpleAccent,
                    icon: FontAwesomeIcons.userNinja,
                    loginMethod: AuthService().anonLogin,
                    text: "Anonymous")
            ),
            Flexible(
                child: LoginButton(
                    color: Colors.blue,
                    icon: FontAwesomeIcons.google,
                    loginMethod: AuthService().googleLogin,
                    text: "Login With Google")
            ),
          ],
        ),
      ),
    );
  }
}
