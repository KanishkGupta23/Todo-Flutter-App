
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

  //Google SignIn
  Future<User?> signInWithGoogle()async{
    try{
    //begin SignIn process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    //Obtain with details from request
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      //Create new credential for User
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      //Sign-In
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      //check
      assert(!user!.isAnonymous);
      assert(await user!.getIdToken() != null);

      final User? currentUser = await FirebaseAuth.instance.currentUser;
      assert(currentUser!.uid == user!.uid);
      print(user);
      return user;
    }
    catch(e){
      print(e);
    }
  }

  void signOut()async{
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }