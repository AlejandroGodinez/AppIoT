import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuthProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>["email"]);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isAlreadyLogged() {
    var user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  bool isGoogleLogin() {
    var user = FirebaseAuth.instance.currentUser;
    if(user.providerData[0].providerId == 'google.com')
      return true;
    else
      return false;
  }

  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
  }

  Future<void> signOutFirebase() async {
    await _auth.signOut();
  }

  //anonimo
  Future<void> anonymousSignIn() async {
    final anonymousUser = (await _auth.signInAnonymously()).user;
    await anonymousUser.updateProfile(
      displayName: "${anonymousUser.uid.substring(0, 5)}_Invitado",
    );
    await anonymousUser.reload();
  }

  Future<void> signInWithGoogle() async {
    // Google sign in
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;

    //credenciales para firebase
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //firebase sign in
    final authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    final firebaseAuthToken = await user.getIdToken();
    assert(!user.isAnonymous);
    assert(firebaseAuthToken != null);
    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);
  }

  //Email and Password
  Future<void> registerNewUser(
    String email,
    String password,
    String name,
  ) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await FirebaseAuth.instance.currentUser.updateProfile(displayName: name);
  }

  Future<void> loginEmailUser(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
}
