// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc_cart_app/commons/shared_prefs/my_shared_prefs.dart';
import 'package:bloc_cart_app/models/user_model.dart';

class AuthenticationRepository {
  SharedPrefs sharedPrefs = SharedPrefs();
  bool isSignedIn = false;
  Future<bool> login({required String email, required String pass}) async {
     try {
      final userString = sharedPrefs.getString(email);
      UserModel userModel = UserModel.fromString(userString);
      if (userModel.email == email && userModel.password == pass) {
        return true;
      }
      return false;
    } catch (error) {
      print("[ERROR] -------- $error");
      return false;
    }
  }
   Future<bool> register({required UserModel userModel}) async {
   try {
      bool value = await sharedPrefs.setString(userModel.email, userModel.toString());
      if (value) {
        return true;
      }
      else {
        return false;
      }
    } catch (error) {
      print("[ERROR] -------- $error");
      return false;
    }
  }
  Future<bool> signOut({required String email}) async {
    await sharedPrefs.setBool("${email}isSignedIn", false);
    return true;
  }
}
