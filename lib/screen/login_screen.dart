import 'package:streamer/core/router.dart';
import 'package:streamer/firebaseDB/auth.dart';
import 'package:streamer/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streamer/utils/styles.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //final _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool passwordVisible = false;
  var submitted = false;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool boolEmail = false;
  bool boolPass = false;

  void _submit() async {
    setState(() {
      submitted = true;
    });
    final pass = _passController.text.toString().trim();
    final email = _emailController.text.toString().trim();
    var user = await loginFirebase(email, pass);
    switch (user) {
      case -1:
        invalidPass();
        setState(() {
          submitted = false;
        });
        break;
      case -2:
      case -3:
        invalidEmail();
        setState(() {
          submitted = false;
        });
        break;
      case 1:
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('login', true);
        Navigator.popUntil(context, ModalRoute.withName('/HomeScreen'));
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(setEmail);
    _passController.addListener(setPass);
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
    print(_passController.text.toString().trim());
    if (_passController.text.toString().trim() == '') {
      setState(() {
        boolPass = false;
      });
    } else
      setState(() {
        boolPass = true;
      });
  }

  void invalidEmail() {
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
                            'Incorrect Email',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 25, top: 15),
                          child: Text(
                            "The email you entered doesn't appear to belong to an account. Please check your email and try again",
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

  void invalidPass() {
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
              height: 170,
              child: Column(
                children: [
                  Container(
                    height: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Text(
                            'Incorrect Password',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 25, top: 15),
                          child: Text(
                            'The password you entered is incorrect. Please try again.',
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

  @override
  Widget build(BuildContext context) {
    var image = Image.asset('assets/images/logo.png');
    var imageLogo1 = Image.asset('assets/images/1.png');
    var imageLogo2 = Image.asset('assets/images/2.png');

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
                  /*Text(
                    'KTV Streamer',
                    style: TextStyle(
                      fontFamily: 'Billabong',
                      color: AppStyles.primaryColorTextField,
                      fontSize: 50.0,
                    ),
                  ),*/
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          width: double.maxFinite,
                          child: Center(
                            child: imageLogo2,
                          ),
                        ),
                      ],
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
                          horizontal: 30.0,
                          vertical: 5.0,
                        ),
                        child: TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style:
                              TextStyle(color: AppStyles.primaryColorTextField),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            fillColor: AppStyles.primaryColorWhite,
                            filled: true,
                            hintText: 'อีเมล',
                            hintStyle: TextStyle(
                                color: AppStyles.primaryColorTextField,
                                fontSize: 15),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 5.0,
                        ),
                        child: TextField(
                          onChanged: (text) {
                            if (text.length == 0) {
                              boolPass = false;
                            } else
                              boolPass = true;
                          },
                          controller: _passController,
                          obscureText: !passwordVisible,
                          style:
                              TextStyle(color: AppStyles.primaryColorTextField),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            fillColor: AppStyles.primaryColorWhite,
                            filled: true,
                            hintText: 'รหัสผ่าน',
                            hintStyle: TextStyle(
                                color: AppStyles.primaryColorTextField,
                                fontSize: 16),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: passwordVisible
                                    ? AppStyles.primaryColorTextField
                                    : Colors.grey,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                          ),
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
                          onPressed: (boolPass == true && boolEmail == true)
                              ? _submit
                              : null,
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
                                  'เข้าสู่ระบบ',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
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
                AppNavigator.toRegister();
                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegScreen(),
                    ));*/
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
                          "หากไม่มีบัญชี? ",
                          style: TextStyle(
                              color: AppStyles.primaryColorTextField,
                              fontSize: 14),
                        ),
                        Text(
                          'ลงทะเบียนใหม่',
                          style: TextStyle(
                              color: AppStyles.primaryColorTextField,
                              fontSize: 14,
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
}
