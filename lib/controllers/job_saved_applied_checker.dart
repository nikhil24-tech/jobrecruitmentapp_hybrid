
import '../models/job_profile.dart';

bool isJobSaved({required JobProfile jobPosting, required String userEmail}) {
  if (jobPosting.jsSavedAndApplied == []) {
    return false;
  } else {
    var savedJobStatus = jobPosting.jsSavedAndApplied!
        .where((element) => element["jsEmail"] == userEmail)
        .toList();
    if (savedJobStatus.isNotEmpty) {
      return savedJobStatus[0]["isSaved"];
    } else {
      return false;
    }
  }
}

bool isJobApplied({required JobProfile jobPosting, required String userEmail}) {
  if (jobPosting.jsSavedAndApplied == []) {
    return false;
  } else {
    var appliedJobStatus = jobPosting.jsSavedAndApplied!
        .where((element) => element["jsEmail"] == userEmail)
        .toList();
    if (appliedJobStatus.isNotEmpty) {
      return appliedJobStatus[0]["isApplied"];
    } else {
      return false;
    }
  }
}
