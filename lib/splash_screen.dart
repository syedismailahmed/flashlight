import 'package:flashlight_app/torch_screen.dart';
import 'package:flutter/material.dart';
import 'image_assets/images.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3),()async{
      Navigator.push(context,MaterialPageRoute(builder: (context)=>const TorchScreen()));
    }
    );
    return Center(
        child:Image.asset(splashImage),
    );
  }
}

