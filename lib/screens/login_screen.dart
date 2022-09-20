import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatroom/TextInputField.dart';
import 'package:chatroom/constants.dart';
import 'package:chatroom/dialog_box.dart';
import 'package:chatroom/rounded_button.dart';
import 'package:chatroom/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'chat_screen.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class LoginScreen extends StatefulWidget {
  static String id='loginscreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailTxtController = TextEditingController();
  final passwdTxtController = TextEditingController();
  bool showSpinner =false;
  late String email,password;
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlurryModalProgressHUD(
        inAsyncCall: showSpinner,
        blurEffectIntensity: 4,
        progressIndicator: SpinKitFadingCircle(
          color: Colors.red.shade500,
          size: 90.0,
        ),
        child: Container(
          width: double.infinity,
          decoration:kDisplayUpperSection,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
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
                                TypewriterAnimatedText('Login',speed: Duration(milliseconds: 150)),
                              ],
                            ),
                            style: kDisplayLabel,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                flex: 2,
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      decoration:kDisplayLowerSection,
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 60,
                            ),
                            Container(
                              child:
                              Column(
                                children: <Widget>[
                                  TextInputField(textInput:
                                  TextField(
                                    controller: emailTxtController,
                                    style:textFieldInput,
                                    keyboardType: TextInputType.emailAddress,
                                    textAlign: TextAlign.center,
                                    decoration:kMessageTextFieldDecoration.copyWith(hintText:'Email'),
                                    onChanged: (value){
                                      email=value;
                                    },
                                  ),
                                  ),
                                  TextInputField(textInput:
                                  TextField(
                                    controller: passwdTxtController,
                                    style:textFieldInput,
                                    obscureText: true,
                                    textAlign: TextAlign.center,
                                    decoration:
                                    kMessageTextFieldDecoration.copyWith(hintText:'Password'),
                                    onChanged: (value){
                                      password=value;
                                    },
                                  ),
                                  ),
                                ],
                              ),
                            ),
                        SizedBox(height: 40,),

                          RoundButton(color: Colors.red.shade500,title:"Login",ontap: ()async{
                            setState(() {
                              showSpinner=true;
                            });
                            try {
                              final User=     await  auth.signInWithEmailAndPassword(email: email, password: password);



                                if(User!=null){
                                  // if(User){
                                  emailTxtController.clear();
                                  passwdTxtController.clear();
                                  Navigator.pushNamed(context, ChatScreen.id);

                                  // }
                              }
                              setState(() {
                                showSpinner=false;
                              });
                            } on FirebaseAuthException catch (e ) {
                              emailTxtController.clear();
                              passwdTxtController.clear();
                              if (e.code == 'user-not-found') {
                                showAlertDialog(context,'No user found for that email.');

                              } else if (e.code == 'wrong-password') {
                                showAlertDialog(context,'Wrong password provided for that user.' );
                              }
                              else if(e.code == 'invalid-email'){
                                showAlertDialog(context,'Enter valid Email');
                                print(e);
                              }
                            }

                          }),

                      SizedBox(height: 30,),
                      TextButton(onPressed: (){
                        emailTxtController.clear();
                        passwdTxtController.clear();
                        Navigator.pushNamed(context,RegistrationScreen.id);
                      }, child: Text(
                              'Make a new account',style: TextStyle(color: Colors.grey),
                            )),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
