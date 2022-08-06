import 'package:firebase_core/firebase_core.dart';
import 'package:fireshipapp/routes.dart';
import 'package:fireshipapp/services/firestore.dart';
import 'package:fireshipapp/services/models.dart';
import 'package:fireshipapp/shared/loading.dart';
import 'package:fireshipapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MediaQuery(
    data : MediaQueryData(),
      child: Material(child: App())));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Scaffold(body:Text("Error Occured"));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamProvider(
              create: (_)=>FirestoreService().streamReport(),
              initialData: Report(),
              child: MaterialApp(
                routes: appRoutes,
                theme: appTheme
              ),
            );
          }
          return const LoadingScreen();
        });
  }
}
