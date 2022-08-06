import 'package:fireshipapp/login/login.dart';
import 'package:fireshipapp/services/auth.dart';
import 'package:fireshipapp/shared/bottom_nav.dart';
import 'package:fireshipapp/shared/loading.dart';
import 'package:fireshipapp/topics/topics.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
        builder: (context,snapshot){

        if(snapshot.connectionState == ConnectionState.waiting){
          print("Waiting");
          return const LoadingScreen();
        }
        else if(snapshot.hasError){
          return Center(
            child: Container(child: Text('error'))
          );
        }
        else if(snapshot.hasData){
          print("Has Data");
          return const TopicsScreen();
        }else{
          print("No Data Avail.");
          return const LoginScreen();
        }

    });
  }
}
