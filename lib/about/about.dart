import 'package:fireshipapp/main.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body:
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(child: Text('No details Needed,\n'
                'You know about me very well....')),
          )
    );
  }
}
