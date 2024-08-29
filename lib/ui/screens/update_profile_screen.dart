import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmanager/data/models/user_model_data.dart';
import 'package:taskmanager/ui/controller/auth_controller.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';

import '../../data/models/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';
import '../widgets/background_widget.dart';
import '../widgets/photo_picker_widget.dart';
import '../widgets/profile_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? _selectedImage;
  bool _updateProfileInProgress = false;

  @override
  void initState() {
    super.initState();
    final userData = AuthController.userData!;
    _emailTEController.text = userData.email ?? '';
    _firstNameTEController.text = userData.firstName ?? '';
    _lastNameTEController.text = userData.lastName ?? '';
    _mobileTEController.text = userData.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context, true),
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 55,
                  ),
                  Text(
                    "Update Profile",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  buildPhotoPickerWidget(),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _emailTEController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      enabled: false,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _firstNameTEController,
                    decoration: InputDecoration(hintText: "First name"),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _lastNameTEController,
                    decoration: InputDecoration(hintText: "Last name"),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _mobileTEController,
                    decoration: InputDecoration(hintText: "Mobile"),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _passwordTEController,
                    decoration: InputDecoration(hintText: "Password"),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Visibility(
                    visible: _updateProfileInProgress==false,
                    replacement: Center(child: CircularProgressIndicator(),),
                    child: ElevatedButton(
                      onPressed: _updateProfile,
                      child: Text("Update"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPhotoPickerWidget() {
    return GestureDetector(
      onTap: () {
        _pickProfileImage();
      },
      child: Container(
        height: 48,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Container(
              width: 100,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "Photo",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                _selectedImage?.name ?? " No image is selected",
                // maxLines: 1,
                style: TextStyle(overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _emailTEController.dispose();
    _mobileTEController.dispose();

    super.dispose();
  }

  Future<void> _pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? result = await picker.pickImage(source: ImageSource.camera);

    if (result != null) {
      _selectedImage = result;
    }
  }

  //---for hit update profile api
  Future<void> _updateProfile() async {
    _updateProfileInProgress = true;
    String encodePhoto = AuthController.userData!.photo ?? "";
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text,
      "firstName": _firstNameTEController.text,
      "lastName": _lastNameTEController.text,
      "mobile": _mobileTEController.text,
      "password": _passwordTEController.text,
      "photo": _pickProfileImage.toString(),
    };
    if (_passwordTEController.text.isNotEmpty) {
      requestBody["password"] = _passwordTEController.text;
    }
    if (_selectedImage != null) {
      File file = File(_selectedImage!.path);
      encodePhoto = base64Encode(file.readAsBytesSync());
      requestBody["photo"] = encodePhoto;
    }
    NetworkResponse response =
        await NetworkCaller.postResponse(Urls.profileUpdate, body: requestBody);
    print(response.responseData);
    if (response.isSuccess && response.responseData['status'] == "success") {
      UserModel userModel = UserModel(
        email: _emailTEController.text,
        firstName: _firstNameTEController.text,
        lastName: _lastNameTEController.text,
        mobile: _mobileTEController.text,
      );
      await AuthController.saveUserData(userModel);
      showSnackBarMessage(context, "Profile update is successful");
      _updateProfileInProgress = false;
      setState(() {});
    } else {
      _updateProfileInProgress = false;
      setState(() {});
      showSnackBarMessage(context, "Profile update is failed");
    }
  }
}
