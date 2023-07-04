// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc_cart_app/commons/shared_prefs/my_shared_prefs.dart';
import 'package:bloc_cart_app/models/user_model.dart';
import 'package:flutter/foundation.dart';

class AuthenticationRepository {
  SharedPrefs sharedPrefs = SharedPrefs();
  bool isSignedIn = false;
  Future<bool> login({required String email, required String pass}) async {
    final userString = sharedPrefs.getString(email);
    if (kDebugMode) {
      print(userString);
    }

    if (userString != null && userString.isNotEmpty) {
      print("------------------------------22");
      UserModel userModel = UserModel.fromString(userString);
      print("------------------------------22222222");
      if (userModel.email == email && userModel.password == pass) {
        return true;
      }
    }
    print("false");
    return false;
  }

  Future<bool> register({required UserModel userModel}) async {
    bool value = await sharedPrefs.setString(userModel.email, userModel.toString());
    if (value) {
      print("------------------------------333333333333");
      print(sharedPrefs.getString(userModel.email));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signOut({required String email}) async {
    await sharedPrefs.setBool("${email}isSignedIn", false);
    return true;
  }
}
