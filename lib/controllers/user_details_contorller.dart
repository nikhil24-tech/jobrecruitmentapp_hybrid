import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailsController extends ChangeNotifier {
  String? userEmail;
  String? userImageUrl;

  get userEmailvalue => userEmail;
  get userImageUrlvalue => userImageUrl;



  //get user details from cache
  Future<void> getUserDetails() async {
    final userDataCache = await SharedPreferences.getInstance();
    userEmail = await userDataCache.getString("loggedInUserEmail")!;
    userImageUrl = await userDataCache.getString("loggedInUserImageUrl")!;
    notifyListeners();
  }
}
