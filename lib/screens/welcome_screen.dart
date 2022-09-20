import 'package:chatroom/constants.dart';
import 'package:chatroom/rounded_button.dart';
import 'package:chatroom/screens/login_screen.dart';
import 'package:chatroom/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class WelcomeScreen extends StatefulWidget {
  static String id='welcomescreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  @override
  // @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration:BoxDecoration(
          color: Colors.red.shade500,
        ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  // for upper part of body
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: [
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Hero(
                                tag: 'logo',
                                child: Container(
                                  child: Image.asset('images/logo.png'),
                                  height: 50.0,
                                ),
                              ),
                              DefaultTextStyle(
                                style: kDisplayLabel,
                                child: AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    TypewriterAnimatedText('ChatRoom',speed: Duration(milliseconds: 150)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ]
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration:kDisplayBelowSectionWelcome,
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // button   for login
                                  RoundButton(color: Colors.red.shade500,title:"Login",ontap: (){
                                    Navigator.of(context).push(SwipeablePageRoute(
                                      builder: (BuildContext context) => LoginScreen(),
                                    ));
                                  }),
                              SizedBox(
                                height: 30,
                              ),
                                  RoundButton(color: Colors.red.shade500,title:"Register",ontap: (){
                                    Navigator.of(context).push(SwipeablePageRoute(
                                      builder: (BuildContext context) => RegistrationScreen(),
                                    ));
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
