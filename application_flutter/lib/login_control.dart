import 'package:google_sign_in/google_sign_in.dart';
import 'user_data.dart';

class LoginAPI {
  static final _googleSignIn = GoogleSignIn();
  static Future logOut = _googleSignIn.signOut();
}

Future<void> loginProcess() async {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser = _googleSignIn.currentUser;

  if (_currentUser == null){
    _currentUser = await _googleSignIn.signIn();
  }

  user_data().email = _currentUser?.email;
  user_data().profile_image_url = _currentUser?.photoUrl;
  user_data().user_name = _currentUser?.displayName;
  user_data().user_id = _currentUser?.id;
  // print(_currentUser?.displayName);
  // print(_currentUser?.email);
  // print(_currentUser?.id);
  // print(_currentUser?.photoUrl);
  return;
}