import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/Admin/home_screen_admin.dart';
import '../screens/Employer/home_screen_employer.dart';
import '../screens/JobSeeker/home_screen_jobseeker.dart';
import '../services/job_kart_db_service.dart';

Future<void> navigateToHomeScreen(
    {required UserCredential userCred,
    required BuildContext context,
    }) async {
  if (userCred.user != null) {
    String? userType =
        await UserDBService.getUserTypeByEmail(email: userCred.user!.email!);

    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return userType == "employer"
            ? EmployerHomeScreen()
            : userType == "jobseeker"
                ? JobSeekerHomeScreen()
            : JobSeekerHomeScreen();
      },
    ));
  }
}
