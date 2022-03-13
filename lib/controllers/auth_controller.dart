import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instastores/controllers/dialog_loadingbox.dart';
import 'package:instastores/views/decider_screen.dart';
import 'package:instastores/views/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInAuth extends GetxController {
  Map? userData;
  final googleSignIn = GoogleSignIn();

  final _auth = FirebaseAuth.instance;
  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;

//=======GOOGLE AUTH=======//

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleuserAuth = await googleUser.authentication;

    final userCredentials = await GoogleAuthProvider.credential(
        accessToken: googleuserAuth.accessToken,
        idToken: googleuserAuth.idToken);

    CommonDialog.showLoading();
    await FirebaseAuth.instance.signInWithCredential(userCredentials);
    CommonDialog.hideLoading();

    update();
  }

  Future googleSignOut() async {
    CommonDialog.showLoading();
    await googleSignIn.disconnect().whenComplete(() async {
      await _auth.signOut();
    });
    print("google");
    Get.off(() => DeciderScreen());
    CommonDialog.hideLoading();
  }

//   //=======FACEBOOK AUTH=======//
//   Future facebookLogin() async {
//     try {
//       final facebookLoginResult = await FacebookAuth.instance.login();
//       final userDataRequested = await FacebookAuth.instance.getUserData(
//         fields: 'email,name,picture',
//       );
//       userData = userDataRequested;
//       final userCredentials = await FacebookAuthProvider.credential(
//           facebookLoginResult.accessToken!.token);
//       CommonDialog.showLoading();
//       await _auth.signInWithCredential(userCredentials);
//       CommonDialog.hideLoading();

//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.setString("bool", userData!['email']);
//       print(userData);
//       update();
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future facebookSignOut() async {
//     CommonDialog.showLoading();
//     await FacebookAuth.instance.logOut().whenComplete(() async {
//       await _auth.signOut();
//     });
//     userData = null;
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.clear();
//     print("facebook");
//     CommonDialog.hideLoading();
//   }
}
