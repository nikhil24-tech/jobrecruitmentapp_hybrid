import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import '../../constants/style.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../controllers/login_signup_validators.dart';
import '../../models/jk_user.dart';
import '../../services/job_kart_db_service.dart';
import 'home_screen_jobseeker.dart';

class JSCreateProfileScreen extends StatefulWidget {
  String? docIdToUpdate;
  String? userEmail;

  JSCreateProfileScreen({this.docIdToUpdate, this.userEmail});

  @override
  State<JSCreateProfileScreen> createState() => _JSCreateProfileScreenState();
}

class _JSCreateProfileScreenState extends State<JSCreateProfileScreen> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _occupationController = TextEditingController();
  TextEditingController _eduLevelController = TextEditingController();
  TextEditingController _jobXpController = TextEditingController();
  TextEditingController _skillsController = TextEditingController();
  TextEditingController _aboutMeController = TextEditingController();

  //inis state called to update the form data if its an old user
  @override
  void initState() {
    super.initState();
    setTextFieldValuesFromDB();
  }

  bool isuploading = false;

//An empty file to store the image we get from the camera or gallery
// when user clicks on the image picker button
  File? image;

//An empty image file which is used to create an image from
//image url we get from the firestore if user has image url in the firestore
  Image? profileImage;

//variable to temporarily store Profile pic image url from firebase storage
//before it is updated  in firestore
  String? uploadedImageUrl;

//initialize the form fields with the values of the profile if it is being updated
  void setTextFieldValuesFromDB() async {
//Method called by init state .When docIdToUpdate is null it means the user is
//old account and we are NOT signing up for a new account and data
//exists in Firebase and need to load it
    if (widget.docIdToUpdate == null) {
      JKUser jobSeekerProfile =
      await UserDBService.getJobSeekerProfile(email: widget.userEmail!);
      setState(() {
        _addressController.text = jobSeekerProfile.jsAddress ?? "address";
        _locationController.text = jobSeekerProfile.jsLocation ?? "Location";
        _phoneController.text = jobSeekerProfile.jsPhone ?? "Phone";
        _occupationController.text =
            jobSeekerProfile.jsOccupation ?? "Occupation";
        _eduLevelController.text = jobSeekerProfile.jsEduLevel ?? "EduLevel";
        _jobXpController.text = jobSeekerProfile.jsJobXp ?? "Job Experience";
        _skillsController.text = jobSeekerProfile.jsSkills ?? "Skills";
        _aboutMeController.text = jobSeekerProfile.jsAboutMe ?? "About Me";

        profileImage = Image.network(
            jobSeekerProfile.jsImageUrl ?? kLogoImageUrl,
            height: 100,
            width: 100);
      });
    } else {
      print("New account. Data does not exist in Firebase");
    }
  }

  GlobalKey<FormState> _jsProfileFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Form(
              key: _jsProfileFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("JobKart", style: kBigLogoTextStyle),
                  SizedBox(height: 20),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Create Profile", style: kHeading1Style)),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          //Pick Image from gallery
                          await pickImage();
                        },
                        // child: imageSet(imageFile: profileImage),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Add Image",
                        style: kGreyoutHeading4Style,
                      ),
                    ],
                  ),

                  //Text Form Fields for JobSeeker Profile
                  SizedBox(height: 20),
                  TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _addressController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Address")),
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
                          labelText: "Phone")),
                  SizedBox(height: 12),
                  TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _occupationController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Occupation")),
                  SizedBox(height: 12),
                  TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _eduLevelController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Education Level")),
                  SizedBox(height: 12),
                  TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _jobXpController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Job Experience")),
                  SizedBox(height: 12),
                  TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _skillsController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Skills")),
                  SizedBox(height: 12),
                  TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _aboutMeController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "About Me")),

                  SizedBox(height: 12),

                  // Update profile Button
                  ElevatedButton(
                    style: kBigButtonStyle,
                    child: isuploading == true
                        ? Text("Updating Profile...",
                        style: kBigButtonTextStyle)
                        : Text("Update Profile", style: kBigButtonTextStyle),
                    onPressed: isuploading == true
                        ? null
                        : () async {
                      setState(() {
                        isuploading = true;
                      });
                      if (_jsProfileFormKey.currentState!.validate()) {
                        uploadedImageUrl =
                        await UserDBService.uploadUserDPToFirebase(
                            imageFile: image);
                        var jsProfileData = {
                          'userType': "jobseeker",
                          'jsAddress': _addressController.text.trim(),
                          'jsLocation': _locationController.text.trim(),
                          'jsPhone': _phoneController.text.trim(),
                          'jsOccupation':
                          _occupationController.text.trim(),
                          'jsEduLevel': _eduLevelController.text.trim(),
                          'jsJobXp': _jobXpController.text.trim(),
                          'jsSkills': _skillsController.text.trim(),
                          'jsAboutMe': _aboutMeController.text.trim(),
                          'jsImageUrl': uploadedImageUrl ?? kLogoImageUrl,
                        };
                        await UserDBService.updateUserDataByDocID(
                            updateDocId: widget.docIdToUpdate,
                            userData: jsProfileData);
                        setState(() {
                          isuploading = false;
                        });
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    JobSeekerHomeScreen()));
                      }
                    },
                  ),
                  SizedBox(height: 12)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    //Pick Image from gallery
    final ImagePicker _picker = ImagePicker();
    final XFile? _image = await _picker.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      File _imageFile = File(_image.path);
      //set this image inside the below cirlce avatar
      setState(() {
        image = _imageFile;
        profileImage =
            Image.file(image!, width: 100, height: 100, fit: BoxFit.cover);
      });
    } else {
      MotionToast.info(
          description: Text("Picture upload cancelled by user",
              style: kBigButtonTextStyle))
          .show(context);
    }
  }
}
