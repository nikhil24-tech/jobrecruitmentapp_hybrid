import 'package:flutter/material.dart';
import '../../../constants/style.dart';
import '../../../controllers/login_signup_validators.dart';
import '../../../models/job_profile.dart';
import '../../../services/job_kart_db_service.dart';
import '../../../widgets/motion_toasts.dart';

class PostedJobEditPage extends StatefulWidget {


  JobProfile jobProfile;
  PostedJobEditPage({required this.jobProfile});


  @override
  State<PostedJobEditPage> createState() => _PostedJobEditPageState();
}

class _PostedJobEditPageState extends State<PostedJobEditPage> {
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
  final _editJobFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    // call load function to get the job profile details from firestore
    loadJobProfileDetails();
  }

  loadJobProfileDetails() {
    _jobNameController.text = widget.jobProfile.jobName ?? "Job Name";
    _orgTypeController.text = widget.jobProfile.orgType ?? "Organization Type";
    _orgAddressController.text = widget.jobProfile.jobAddress ?? "Organization Address";
    _locationController.text = widget.jobProfile.jobLocation ?? "Location";
    _contactEmailController.text = widget.jobProfile.empEmail ?? "Email";
    _phoneController.text = widget.jobProfile.empPhone ?? "Phone";
    _salaryController.text = widget.jobProfile.salaryPerHr ?? "Salary";
    _jobDescriptionController.text = widget.jobProfile.jobDescription ?? "Job Description";
    _requirementsController.text = widget.jobProfile.jobRequirements ?? "Requirements";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 23),
            child: Form(
              key: _editJobFormKey,
              child: Column(
                children: [
                  SizedBox(height: 12),
                  Text("JobKart", style: kSmallLogoTextStyle),
                  SizedBox(height: 33),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text("Edit Job", style: kGreyoutHeading3Style)),
                  SizedBox(height: 30),
                  TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _jobNameController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Job Name")),
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
                      enabled: false,
                      style: kHeading2RegularStyle,
                      controller: _contactEmailController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Contact Email")),
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
                      controller: _salaryController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Salary")),
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
                      validator: notNullValidator,
                      maxLines: 4,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Requirements")),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: kBigButtonStyle,
                    child: Text("Save Edit Job"),
                    onPressed: () async {
                      //Update Job details in firestore
                      if (_editJobFormKey.currentState!.validate()) {
                        var jobData = {
                          'jobName': _jobNameController.text.trim(),
                          'jobAddress': _orgAddressController.text.trim(),
                          'jobLocation': _locationController.text.trim(),
                          'empEmail': _contactEmailController.text.trim(),
                          'empPhone': _phoneController.text.trim(),
                          'orgType': _orgTypeController.text.trim(),
                          'salaryPerHr': _salaryController.text.trim(),
                          'jobDescription':
                          _jobDescriptionController.text.trim(),
                          'jobRequirements':
                          _requirementsController.text.trim(),
                        };

                        //Update job Data to the firestore database
                        await JobsDBService.updateJobData(
                            jobData: jobData, docIdToUpdate: widget.jobProfile.jobID!);

                        //show a toast message

                        successToast(
                            context, "Job Updated", kBigButtonTextStyle);
                      }
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
