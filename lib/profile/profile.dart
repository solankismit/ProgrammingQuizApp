
import 'package:fireshipapp/login/loginButton.dart';
import 'package:fireshipapp/services/auth.dart';
import 'package:fireshipapp/services/models.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../shared/loading.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var report = Provider.of<Report>(context);
    var user = AuthService().user;
    if(user!=null){
      return Scaffold(
          appBar: AppBar(
            title: Text(user.displayName ?? 'Guest'),
          ),
          body: Center(
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  margin: const EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image:DecorationImage( image: NetworkImage(user.photoURL ??'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'))
                  ),
                ),
                Text(user.email ?? '', style: Theme.of(context).textTheme.headline6,),
                const Spacer(),
                Text('${report.total}', style: Theme.of(context).textTheme.headline2,),
                Text('Quizzes Completed', style: Theme.of(context).textTheme.subtitle2,),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    await AuthService().signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  },
                  child: Text("Sign Out"),
                ),
                Spacer()
              ],
            ),
          ));
    }
    else{
      return Loader();
    }
  }
}
