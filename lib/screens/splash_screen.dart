import 'package:dog_picture_app/components/color_manager.dart';
import 'package:dog_picture_app/components/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushReplacementNamed(context, Routes.homeScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Lottie.asset('assets/dog-walking.json'),
            const Padding(
              padding: EdgeInsets.only(top: 300),
              child: Text(
                "Dog Picture App",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 430),
              child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    color: ColorManager.primary,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
