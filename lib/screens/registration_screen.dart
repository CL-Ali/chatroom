import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:chatroom/TextInputField.dart';
import 'package:chatroom/rounded_button.dart';
import 'package:chatroom/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatroom/constants.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class RegistrationScreen extends StatefulWidget {
  static String id = 'registrationscreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner=false;
  late String  Email, Password;
  final auth=FirebaseAuth.instance;
  final emailTxtController = TextEditingController();
  final passwdTxtController = TextEditingController();
  late bool isActiveButton=false;
  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
      inAsyncCall: showSpinner,
      blurEffectIntensity: 4,
      progressIndicator: SpinKitFadingCircle(
      color: Colors.red.shade500,
      size: 90.0,),
      child: Scaffold(
          body: Container(
        width: double.infinity,
        decoration: kDisplayUpperSection,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                    child:    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Hero(
                                tag: 'logo',
                                child: Container(
                                  child: Image.asset('images/logo.png'),
                                  height: 60.0,
                                ),
                              ),
                              DefaultTextStyle(
                                child: AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    TypewriterAnimatedText('Registration',
                                        speed: Duration(milliseconds: 150)),
                                  ],
                                ),
                                style: kDisplayLabel,
                              ),
                            ],
                          ),
                    ),
              ),
              // SizedBox(height: 30),
              Expanded(
                flex: 2,
                child: Container(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      decoration: kDisplayLowerSection,
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 60,
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  TextInputField(
                                    textInput: TextField(
                                      controller: emailTxtController,
                                      style: textFieldInput,
                                      keyboardType: TextInputType.emailAddress,
                                      textAlign: TextAlign.center,
                                      decoration: kMessageTextFieldDecoration
                                          .copyWith(hintText: 'Email'),
                                      onChanged: (value) {
                                        Email = value;
                                      },
                                    ),
                                  ),
                                  TextInputField(
                                    textInput: TextField(
                                      controller: passwdTxtController,
                                      style: textFieldInput,
                                      textAlign: TextAlign.center,
                                      obscureText: true,
                                      decoration: kMessageTextFieldDecoration
                                          .copyWith(hintText: 'Password'),
                                      onChanged: (value) {
                                        Password = value;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            RoundButton(

                                ontap:
                                    ()async {
                                  if(emailTxtController!=null && passwdTxtController !=null) {
                                    setState(() {
                                      showSpinner = true;
                                    });
                                    try {
                                      final newUser = await auth
                                          .createUserWithEmailAndPassword(
                                          email: Email, password: Password);
                                      if (newUser != null) {
                                        Navigator.pushNamed(
                                            context, ChatScreen.id);
                                        emailTxtController.clear();
                                        passwdTxtController.clear();
                                      }
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    } catch (e) {
                                      print(e);
                                    }
                                  }else{null;}
                                  },
                                title: "Register",
                                color: Colors.red.shade500),
                            SizedBox(
                              height: 30,
                            ),
                            TextButton(
                                onPressed: () {
                                  emailTxtController.clear();
                                  passwdTxtController.clear();
                                  Navigator.pushNamed(context, LoginScreen.id);

                                },
                                child: Text(
                                  'already account?',
                                  style: TextStyle(color: Colors.grey),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          )),
    );

  }
}
