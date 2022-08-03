import 'package:flutter/material.dart';
import '../../../constants/style.dart';
import '../../../controllers/login_signup_validators.dart';
import '../../../models/jk_user.dart';
import '../../../models/job_profile.dart';
import '../../../services/job_kart_db_service.dart';
import '../../../widgets/motion_toasts.dart';

class AddANewJobPage extends StatefulWidget {
  final JKUser empProfile;

  AddANewJobPage({required this.empProfile});

  @override
  State<AddANewJobPage> createState() => _AddANewJobPageState();
}

class _AddANewJobPageState extends State<AddANewJobPage> {
  //Textediting controllers for form fields
  TextEditingController _jobNameController = TextEditingController();
  TextEditingController _orgAddressController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _contactEmailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _orgTypeController = TextEditingController();
  TextEditingController _salaryController = TextEditingController();
  TextEditingController _jobDescriptionController = TextEditingController();
  TextEditingController _requirementsController = TextEditingController();
//Form key for form validation
  final _addJobFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 23),
            child: Form(
              key: _addJobFormKey,
              child: Column(
                children: [
                  SizedBox(height: 12),
                  Text("JobKart", style: kSmallLogoTextStyle),
                  SizedBox(height: 33),
                  Text("Add a New Job", style: kGreyoutHeading3Style),
                  SizedBox(height: 50),
                  TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _jobNameController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Job Name")),
                  SizedBox(height: 12),
                  TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _orgAddressController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Organisation Address")),
                  SizedBox(height: 12),
                  TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _locationController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Location")),
                  SizedBox(height: 12),
                  TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _phoneController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Contact Phone")),
                  SizedBox(height: 12),
                  TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _orgTypeController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Organisation Type")),
                  SizedBox(height: 12),
                  TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _salaryController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Salary per hour")),
                  SizedBox(height: 12),
                  TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _jobDescriptionController,
                      maxLines: 4,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Job Description")),
                  SizedBox(height: 12),
                  TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _requirementsController,
                      maxLines: 4,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Requirements")),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: kBigButtonStyle,
                    child: Text("Add A New Job"),
                    onPressed: () async {
                      if (_addJobFormKey.currentState!.validate()) {
                        var jobData = JobProfile(
                            jobName: _jobNameController.text.trim(),
                            jobAddress: _orgAddressController.text.trim(),
                            jobLocation: _locationController.text.trim(),
                            empEmail: widget.empProfile.email,
                            empPhone: _phoneController.text.trim(),
                            orgType: _orgTypeController.text.trim(),
                            orgName: widget.empProfile.orgName,
                            salaryPerHr: _salaryController.text.trim(),
                            jobDescription:
                            _jobDescriptionController.text.trim(),
                            jobRequirements:
                            _requirementsController.text.trim(),
                            orgImageUrl: widget.empProfile.orgImageUrl)
                            .toJson();

                        //saving job Data to the firestore database
                        await JobsDBService.saveJobData(jobData);

                        //reset text fields and show a toast message
                        clearControllers();
                        successToast(
                            context, "New Job Added", kBigButtonTextStyle);
                      }
                    },
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void clearControllers() {
    _jobNameController.clear();
    _orgAddressController.clear();
    _locationController.clear();
    _contactEmailController.clear();
    _phoneController.clear();
    _orgTypeController.clear();
    _salaryController.clear();
    _jobDescriptionController.clear();
    _requirementsController.clear();
  }
}
