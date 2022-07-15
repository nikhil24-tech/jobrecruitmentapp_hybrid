import 'package:flutter/material.dart';
import 'screens/get_started.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(jobrecruitmentapp_hybrid());
}

class jobrecruitmentapp_hybrid extends StatelessWidget {
  jobrecruitmentapp_hybrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: GetStartedScreen(),
    );
  }
}
