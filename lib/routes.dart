
import 'package:fireshipapp/about/about.dart';
import 'package:fireshipapp/home/home.dart';
import 'package:fireshipapp/login/login.dart';
import 'package:fireshipapp/profile/profile.dart';
import 'package:fireshipapp/shared/loading.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/about': (context) => const AboutScreen(),
  '/topics': (context) => const HomeScreen(),

};