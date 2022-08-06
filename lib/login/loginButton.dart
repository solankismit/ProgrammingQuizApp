import 'package:fireshipapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class LoginButton extends StatelessWidget {

  final Color color;
  final IconData icon;
  final Function loginMethod ;
  final String text;
  LoginButton({Key? key, required this.color, required this.icon, required this.loginMethod, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(

        style: TextButton.styleFrom(
          padding: EdgeInsets.all(24),
          backgroundColor: color,
        ),
        icon: Icon(
            icon,
          size: 20,
        ),
          onPressed: ()=> loginMethod()
        , label: Text(text),
      ),
    );
  }
}
