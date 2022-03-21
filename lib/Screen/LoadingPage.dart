
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LoadingPage extends StatefulWidget {


  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async=>false,
      child: Scaffold(
          body: Container(
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      RotateAnimatedText('Please Wait',textStyle: TextStyle(color: Colors.black,fontSize: 32)),
                      RotateAnimatedText('Generating Report',textStyle: TextStyle(color: Colors.black,fontSize: 32)),
                      // RotateAnimatedText('DIFFERENT'),
                    ]
                ),
                Center(
                child: LoadingAnimationWidget.dotsTriangle(
                color: Colors.white,
                size: 200,
      ),
      ),
              ],
            ),
          )
      ),
    );
  }
}
