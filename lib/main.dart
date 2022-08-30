import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/get_started.dart';

late var userDataCache;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  userDataCache = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(jobrecruitmentapp_hybrid());
}

class jobrecruitmentapp_hybrid extends StatelessWidget {
  jobrecruitmentapp_hybrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'JOB KART',
      debugShowCheckedModeBanner: false,
      home: GetStartedScreen(),
    );
  }
}
