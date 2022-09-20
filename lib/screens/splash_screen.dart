import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatroom/constants.dart';
import 'package:flutter/material.dart';
import 'welcome_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String id='splashscreen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToWelcomeScrn();
  }
  navigateToWelcomeScrn()async{
    await Future.delayed(Duration(milliseconds:1500 ),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Colors.red.shade500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Center(
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: 100.0,
                    ),
                  ),
                  DefaultTextStyle(
                    style: kDisplayLabel,
                    child:
                    Text('ChatRoom'),
                  ),
                  SizedBox(width: 40,)
                ],
              ),

            ),
            SizedBox(height: 30,),
            Column(
              children: [
                Text('Developed by ',style: TextStyle(color: Colors.white,fontSize: 20.0,)),
                Text('c.l_ali',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0,)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
