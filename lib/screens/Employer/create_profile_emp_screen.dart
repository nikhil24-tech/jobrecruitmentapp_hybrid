import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/style.dart';
import '../../controllers/login_signup_validators.dart';
import '../../models/jk_user.dart';
import '../../services/job_kart_db_service.dart';
import '../../widgets/motion_toasts.dart';
import 'home_screen_employer.dart';

bool isUploading = false;

class EmployerCreateProfileScreen extends StatefulWidget {
  final String? docIdToUpdate;
  String? userEmail;
  bool? isNavigatingFromSettingsPage;

  EmployerCreateProfileScreen(
      {this.docIdToUpdate, this.userEmail, this.isNavigatingFromSettingsPage});

  @override
  State<EmployerCreateProfileScreen> createState() =>
      _EmployerCreateProfileScreenState();
}

class _EmployerCreateProfileScreenState
    extends State<EmployerCreateProfileScreen> {
//inis state called to update the form data if its an old user
  @override
  void initState() {
    super.initState();
    setTextFieldValuesFromDB();
  }

//Textediting controllers for form fields

  TextEditingController _orgNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _orgTypeController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

//Form key for form validation
  final _empProfileFormKey = GlobalKey<FormState>();

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
//If user navigates to this page from settings page then read email
//from cache
    if (widget.isNavigatingFromSettingsPage != null &&
        widget.isNavigatingFromSettingsPage == true) {
      final userDataCache = await SharedPreferences.getInstance();
      widget.userEmail = await userDataCache.getString("loggedInUserEmail")!;
    }

//Method called by init state .When docIdToUpdate is null it means the user is
//old account and we are NOT signing up for a new account and data
//exists in Firebase and need to load it
    if (widget.docIdToUpdate == null) {
      JKUser empProfile =
      await UserDBService.getEmployerProfile(email: widget.userEmail!);
      setState(() {
        _emailController.text = empProfile.email ?? "email";
        _orgNameController.text = empProfile.orgName ?? "orgName";
        _phoneController.text = empProfile.empPhone ?? "phone";
        _orgTypeController.text = empProfile.orgType ?? "orgType";
        _addressController.text = empProfile.orgAddress ?? "address";
        _locationController.text = empProfile.orgLocation ?? "location";
        profileImage =
            Image.network(empProfile.orgImageUrl!, height: 100, width: 100);
      });
    } else {
      print("New account. Data does not exist in Firebase");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _empProfileFormKey,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("JobKart", style: kBigLogoTextStyle),
                  SizedBox(height: 20),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Profile", style: kHeading1Style)),
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
                        "Add Logo",
                        style: kGreyoutHeading4Style,
                      ),
                    ],
                  ),

                  //Text Form Fields for Employer Profile
                  SizedBox(height: 20),
                  TextFormField(
                      style: kHeading2RegularStyle,
                      controller: _orgNameController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Organisation Name")),
                  SizedBox(height: 12),
                  TextFormField(
                    // enabled: false,
                      style: kHeading2RegularStyle,
                      controller: _emailController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "email")),

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
                      controller: _orgTypeController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Organisation Type")),
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
                      controller: _locationController,
                      validator: notNullValidator,
                      decoration: kTextFieldInputDecoration.copyWith(
                          labelText: "Location")),

                  SizedBox(height: 12),

                  //Update profile button
                  ElevatedButton(
                    style: kBigButtonStyle,
                    child: isUploading == true
                        ? Text("Uploading...", style: kBigButtonTextStyle)
                        : Text("Update Profile", style: kBigButtonTextStyle),
                    onPressed: isUploading == true
                        ? null
                        : () async {
                      if (_empProfileFormKey.currentState!.validate()) {
                        //set isUploading to true
                        setState(() {
                          isUploading = true;
                        });

                        //uploading profile pic to firebase storage
                        uploadedImageUrl =
                        await UserDBService.uploadUserDPToFirebase(
                            imageFile: image);

                        setState(() {});

                        // setEmpImageUrlInCache()
                        final userDataCache =
                        await SharedPreferences.getInstance();
                        // saving the image url in shared prefs
                        await userDataCache.setString(
                            'loggedInUserImageUrl',
                            uploadedImageUrl ?? kLogoImageUrl);

                        //updating form data in firestore

                        await updateUserDataInFirebase();

                        //set isUploading to false
                        setState(() {
                          isUploading = false;
                        });
                        infoToast(context, "Profile Updated",
                            kBigButtonTextStyle);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmployerHomeScreen(),
                          ),
                        );
                        successToast(context, "Profile Updated",
                            kBigButtonTextStyle);
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

  Future<void> updateUserDataInFirebase() async {
    //Update the image url in firestore if it is not null
    var jsProfileData = uploadedImageUrl == null
        ? {
      'userType': "employer",
      'orgName': _orgNameController.text.trim(),
      'empPhone': _phoneController.text.trim(),
      'orgType': _orgTypeController.text.trim(),
      'orgLocation': _locationController.text.trim(),
      'orgAddress': _addressController.text.trim(),
    }
        : {
      'userType': "employer",
      'orgName': _orgNameController.text.trim().trim(),
      'empPhone': _phoneController.text.trim(),
      'orgType': _orgTypeController.text.trim(),
      'orgLocation': _locationController.text.trim(),
      'orgAddress': _addressController.text.trim(),
      'orgImageUrl': uploadedImageUrl
    };
    //New user updated via DocID and old user udated by email
    widget.docIdToUpdate != null
        ? await UserDBService.updateUserDataByDocID(
        updateDocId: widget.docIdToUpdate, userData: jsProfileData)
        : await UserDBService.updateUserDataByEmail(
        email: widget.userEmail, userData: jsProfileData);
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
