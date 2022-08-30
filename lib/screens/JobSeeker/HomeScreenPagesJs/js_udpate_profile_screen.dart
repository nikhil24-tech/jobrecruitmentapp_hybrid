import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:motion_toast/motion_toast.dart';
import '../../../constants/style.dart';
import '../../../controllers/login_signup_validators.dart';
import '../../../models/jk_user.dart';
import '../../../services/job_kart_db_service.dart';
import 'js_view_profile_page.dart';


class JSUpdateProfilePage extends StatefulWidget {
  JKUser jsDetails;
  JSUpdateProfilePage({required this.jsDetails});
  @override
  State<JSUpdateProfilePage> createState() => _JSUpdateProfilePageState();
}

bool isUploading = false;

//An empty file to store the image we get from the camera or gallery
// when user clicks on the image picker button
File? image;

//An empty image file which is used to create an image from
//image url we get from the firestore if user has image url in the firestore
Image? profileImage;

//variable to temporarily store Profile pic image url from firebase storage
//before it is updated  in firestore
String? uploadedImageUrl;

class _JSUpdateProfilePageState extends State<JSUpdateProfilePage> {
//Creating text editing controllers for the text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _aboutMeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _eduLevelController = TextEditingController();
  final TextEditingController _jobXPController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();

  final _updateProfileFormKey = GlobalKey<FormState>();

//Loading the user details from JKUser object passed from the previous screen (JSProfileDetailsPage)
  @override
  void initState() {
    fillFormFromExistingData();
    super.initState();
  }

  void fillFormFromExistingData() {
    _nameController.text = widget.jsDetails.jsName!;
    _addressController.text = widget.jsDetails.jsAddress!;
    _emailController.text = widget.jsDetails.email!;
    _aboutMeController.text = widget.jsDetails.jsAboutMe!;
    _phoneController.text = widget.jsDetails.jsPhone!;
    _eduLevelController.text = widget.jsDetails.jsEduLevel!;
    _jobXPController.text = widget.jsDetails.jsJobXp!;
    _skillsController.text = widget.jsDetails.jsSkills!;
    profileImage = Image.network(widget.jsDetails.jsImageUrl!);
  }

  @override
  void dispose() {
    profileImage = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            width: double.maxFinite,
            child: Form(
              key: _updateProfileFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(child: Text("JobKart", style: kSmallLogoTextStyle)),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () async {
                      //Pick Image from gallery
                      await pickImage();
                    },
                    child: imageSet(imageFile: profileImage),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _nameController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Name")),
                  SizedBox(height: 12),
                  TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _addressController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Address")),
                  SizedBox(height: 12),
                  TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _jobXPController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Job Experience")),
                  SizedBox(height: 12),
                  TextField(
                    enabled: false,
                    style: kGreyoutHeading4Style,
                    controller: _emailController,
                    decoration:
                        kTextFieldInputDecoration.copyWith(labelText: "Email"),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _aboutMeController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "About Me")),
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
                      controller: _eduLevelController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Education Level")),
                  SizedBox(height: 12),
                  TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _skillsController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Skills")),
                  SizedBox(height: 12),
                  ElevatedButton(
                    style: kBigButtonStyle,
                    child: isUploading == true
                        ? Text("Updating...", style: kBigButtonTextStyle)
                        : Text("Update Profile", style: kBigButtonTextStyle),
                    onPressed: isUploading == true
                        ? null
                        : () async {
                            if (_updateProfileFormKey.currentState!
                                .validate()) {
                              //set the isUploading to true to show the loading indicator
                              setState(() {
                                isUploading = true;
                              });

                              uploadedImageUrl =
                                  await UserDBService.uploadUserDPToFirebase(
                                      imageFile: image);
                              await UserDBService.updateUserDataByEmail(
                                  email: widget.jsDetails.email,
                                  userData: {
                                    "jsName": _nameController.text.trim(),
                                    "jsAddress": _addressController.text.trim(),
                                    "jsJobXp":
                                        _jobXPController.text.trim(),
                                    "jsAboutMe": _aboutMeController.text.trim(),
                                    "jsPhone": _phoneController.text.trim(),
                                    "jsEduLevel":
                                        _eduLevelController.text.trim(),
                                    "jsSkills": _skillsController.text.trim(),
                                    "jsImageUrl": uploadedImageUrl ??
                                        widget.jsDetails.jsImageUrl,
                                  });

                              //set the isUploading to false to hide the loading indicator
                              setState(() {
                                isUploading = false;
                              });

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          JSProfileDetailsPage(
                                            userEmail: widget.jsDetails.email,
                                          )));

                              MotionToast.success(
                                      description: Text(
                                          "Data Updated Successfully",
                                          style: kBigButtonTextStyle))
                                  .show(context);
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
