import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
class AuthService{
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;

  Future<void> anonLogin() async{
    try{
      print("anon ");
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e){
      //Handle Error
      print(e);
    }
  }
  Future<void> googleLogin() async{
    try{
      final googleUser = await GoogleSignIn().signIn();

      if(googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );

      await FirebaseAuth.instance.signInWithCredential(authCredential);
    }on FirebaseAuthException catch(e){}
  }
  Future<void> signOut() async{
    print("Sign Out");
    await FirebaseAuth.instance.signOut();
    print("Sign Out fin");
  }
}