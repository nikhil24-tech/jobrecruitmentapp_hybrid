import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import '../../../constants/style.dart';
import '../../../controllers/login_signup_validators.dart';
import '../../../models/job_profile.dart';
import '../../../services/job_kart_db_service.dart';

class PostedJobEditPage extends StatefulWidget {
  String? jobID;
  String? jobName;
  String? orgType;
  String? orgAddress;
  String? location;
  String? contactEmail;
  String? phone;
  String? salary;
  String? jobDescription;
  String? requirements;

  PostedJobEditPage(
      {this.jobID,
        this.jobName,
        this.orgType,
        this.orgAddress,
        this.location,
        this.contactEmail,
        this.phone,
        this.salary,
        this.jobDescription,
        this.requirements});

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
    _jobNameController.text = widget.jobName ?? "Job Name";
    _orgTypeController.text = widget.orgType ?? "Organization Type";
    _orgAddressController.text = widget.orgAddress ?? "Organization Address";
    _locationController.text = widget.location ?? "Location";
    _contactEmailController.text = widget.contactEmail ?? "Email";
    _phoneController.text = widget.phone ?? "Phone";
    _salaryController.text = widget.salary ?? "Salary";
    _jobDescriptionController.text = widget.jobDescription ?? "Job Description";
    _requirementsController.text = widget.requirements ?? "Requirements";
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
                        var jobData = JobProfile(
                            jobName: _jobNameController.text,
                            orgAddress: _orgAddressController.text,
                            location: _locationController.text,
                            orgContactEmail: _contactEmailController.text,
                            phone: _phoneController.text,
                            orgType: _orgTypeController.text,
                            salary: _salaryController.text,
                            jobDescription: _jobDescriptionController.text,
                            requirements: _requirementsController.text)
                            .toJson();

                        //Update job Data to the firestore database
                        await JobsDBService.updateJobData(
                            jobData: jobData, docIdToUpdate: widget.jobID!);

                        //reset text fields and show a toast message

                        MotionToast.success(
                            description: Text(
                              "Job Edited Successfully",
                              style: kSmallButtonTextStyle.copyWith(
                                  color: Colors.white, fontSize: 16),
                            )).show(context);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
