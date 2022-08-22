import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/jk_user.dart';
import '../services/job_kart_db_service.dart';

class JKUserDataController extends ChangeNotifier {
  JKUser? _jkUserProfile;

  Future<JKUser?> getJKUserData() async {
    final userDataCache = await SharedPreferences.getInstance();
    String userEmail = await userDataCache.getString("loggedInUserEmail")!;
    _jkUserProfile = await UserDBService.getJKProfile(email: userEmail);
    return _jkUserProfile;

    //notifyListeners();
  }
}
