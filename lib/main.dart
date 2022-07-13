import 'package:flutter/material.dart';
import 'screens/get_started.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(JobKartApp());
}

class JobKartApp extends StatelessWidget {
  JobKartApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: GetStartedScreen(),
    );
  }
}
