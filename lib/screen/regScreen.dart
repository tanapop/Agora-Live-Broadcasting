import 'dart:io';

import 'package:streamer/components/form_field.dart';
import 'package:streamer/firebaseDB/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streamer/utils/styles.dart';

class RegScreen extends StatefulWidget {
  static final String id = 'login_screen';

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _nameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  final _usernameController = TextEditingController();
  bool passwordVisible = false;
  File _image;
  bool submitted = false;
  bool boolEmail = false,
      boolPass = false,
      boolName = false,
      boolUser = false,
      invalidError = false,
      passwordError = false;

  void _submit() async {
    setState(() {
      submitted = true;
    });
    if (_image == null) {
      setState(() {
        submitted = false;
      });
      imageDialog();
      return;
    }
    passwordError = false;
    invalidError = false;
    //existsError=false;
    final pass = _passController.text.toString().trim();
    final email = _emailController.text.toString().trim();
    final firstName = _firstNameController.text.toString().trim();
    final lastName = _lastNameController.text.toString().trim();
    final fullName = firstName + " " + lastName;
    final username = _usernameController.text.toString().trim();

    var result = await registerUser(
        email: email,
        firstName: firstName,
        lastName: lastName,
        fullName: fullName,
        username: username,
        pass: pass,
        image: _image);
    switch (result) {
      case 1:
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('login', true);
        Navigator.popUntil(context, ModalRoute.withName('/HomeScreen'));
        break;
      case -1:
        usernameError();
        setState(() {
          submitted = false;
        });
        break;
      case -2:
        setState(() {
          invalidError = true;
          submitted = false;
        });
        break;
      case -3:
        setState(() {
          emailExists();
          submitted = false;
        });
        break;
      case -4:
        setState(() {
          passwordError = true;
          submitted = false;
        });
        break;
    }
  }

  void usernameError() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.grey[800],
              ),
              height: 190,
              child: Column(
                children: [
                  Container(
                    height: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Text(
                            'Username Not Available',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 25, top: 15),
                          child: Text(
                            "The username you entered is not available.",
                            style: TextStyle(color: Colors.white60),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0,
                    height: 0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Try Again',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void imageDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.grey[800],
              ),
              height: 190,
              child: Column(
                children: [
                  Container(
                    height: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Text(
                            'Select Image',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 25, top: 15),
                          child: Text(
                            "Image is not selected for avatar.",
                            style: TextStyle(color: Colors.white60),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0,
                    height: 0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Try Again',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void emailExists() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.grey[800],
              ),
              height: 190,
              child: Column(
                children: [
                  Container(
                    height: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Text(
                            'This Email is on Another Account',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 25, top: 15),
                          child: Text(
                            "You can log into the account associated with that email.",
                            style: TextStyle(color: Colors.white60),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0,
                    height: 0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.popUntil(
                            context, ModalRoute.withName('/HomeScreen'));
                      },
                      child: Text(
                        'Log in to Existing Account',
                        style: TextStyle(color: Colors.lightBlue[400]),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(setEmail);
    _passController.addListener(setPass);
    _nameController.addListener(setName);
    _usernameController.addListener(setUser);
  }

  void setEmail() {
    if (_emailController.text.toString().trim() == '') {
      setState(() {
        boolEmail = false;
      });
    } else
      setState(() {
        boolEmail = true;
      });
  }

  void setPass() {
    if (_passController.text.toString().trim() == '') {
      setState(() {
        boolPass = false;
      });
    } else
      setState(() {
        boolPass = true;
      });
  }

  void setName() {
    if (_nameController.text.toString().trim() == '') {
      setState(() {
        boolName = false;
      });
    } else
      setState(() {
        boolName = true;
      });
  }

  void setUser() {
    if (_usernameController.text.toString().trim() == '') {
      setState(() {
        boolUser = false;
      });
    } else
      setState(() {
        boolUser = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.primaryColorGray,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      chooseFile();
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      child: CircleAvatar(
                        backgroundColor: AppStyles.primaryColorLight,
                        backgroundImage: _image == null
                            ? AssetImage('assets/images/dummy.png')
                            : FileImage(_image),
                        //NetworkImage('https://firebasestorage.googleapis.com/v0/b/xperion-vxatbk.appspot.com/o/image_picker82875791.jpg?alt=media&token=09bf83c8-6d3b-4626-9058-85294f457b70'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 5.0,
                        ),
                        child: AppTextFormField(
                          label: 'อีเมล',
                          controller: _emailController,
                          maxLength: 30,
                          validator: (s) =>
                              s.isEmpty ? 'กรุณากรอกอีเมลให้ถูกต้อง' : null,
                          borderRadius: 50.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 5.0,
                        ),
                        child: AppTextFormField(
                          label: 'รหัสผ่าน',
                          controller: _passController,
                          isObscure: !passwordVisible,
                          maxLength: 20,
                          validator: (s) =>
                              s.isEmpty ? 'กรุณากรอกขั้นต่ำ 6 ตัวอักษร' : null,
                          borderRadius: 50.0,
                          trailing: IconButton(
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: passwordVisible
                                  ? AppStyles.primaryColorLight
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 4.0,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: AppTextFormField(
                                  label: 'ชื่อ',
                                  controller: _firstNameController,
                                  maxLength: 20,
                                  validator: (s) =>
                                      s.isEmpty ? 'กรุณากรอกชื่อ' : null,
                                  borderRadius: 50.0,
                                ),
                              ),
                              Expanded(
                                child: AppTextFormField(
                                  label: 'นามสกุล',
                                  controller: _lastNameController,
                                  maxLength: 20,
                                  validator: (s) =>
                                      s.isEmpty ? 'กรุณากรอกนามสกุล' : null,
                                  borderRadius: 50.0,
                                ),
                              ),
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 5.0,
                        ),
                        child: AppTextFormField(
                          label: 'Username',
                          controller: _usernameController,
                          maxLength: 10,
                          validator: (s) =>
                              s.isEmpty ? 'กรุณากรอก Username' : null,
                          borderRadius: 50.0,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          /*onPressed: (boolPass != false &&
                                  boolEmail != false &&
                                  boolName != false &&
                                  boolUser != false)
                              ? _submit
                              : null,*/
                          onPressed: _submit,
                          color: AppStyles.primaryColorLight,
                          disabledColor: AppStyles.primaryColorTextField,
                          disabledTextColor: Colors.white60,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(15.0),
                          child: submitted
                              ? SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : Text(
                                  'ลงทะเบียน',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Divider(
                      color: AppStyles.primaryColorWhite,
                      height: 2,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "มีบัญชีอยู่แล้ว? ",
                          style: TextStyle(
                              color: AppStyles.primaryColorTextField,
                              fontSize: 15),
                        ),
                        Text(
                          'ล็อกอิน',
                          style: TextStyle(
                              color: AppStyles.primaryColorTextField,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }
}
