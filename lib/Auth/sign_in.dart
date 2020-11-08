import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Instance creation
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

// Variables to keep account data
String name;
String email;
String imageUrl;

//Future to sign in with Google
Future<String> signInWithGoogle() async {
  await Firebase.initializeApp(); // Initializes firebase

  final GoogleSignInAccount googleSignInAccount =
      await googleSignIn.signIn(); //Awaits for sign in
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication; //Authentication

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  ); //Credentials

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    // Checking if email and/or name are null
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);

    name = user.displayName;
    email = user.email;
    imageUrl = user.photoURL;

    // Only taking the first part of the name, i.e., First Name
    /*if (name.contains(" ")) {
      name = name.substring(0, name.indexOf(" "));
    }*/

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');

    return '$user';
  }

  return null;
}

// Future to sign out from Google
Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}
