import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:propel_login/PhoneNumScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.6), // only animate for first half of the animation
      ),
    );
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0), // only animate for second half of the animation
      ),
    );

    _controller.forward().whenComplete(() {
      // Navigate to LoginScreen after 2 seconds
      Future.delayed(const Duration(seconds: 5), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Center(
        child: Stack(
      children: [
      Positioned(
      top: 300,
        left: 180,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return ScaleTransition(
              scale: _scaleAnimation,
              child: SvgPicture.asset(
                'asset/logo.svg',
                width: 50,
                height: 50,
              ),
            );
          },
        ),
      ),
      // Positioned(
      //   top: 60,
      //   left: 70,
      //   child: AnimatedBuilder(
      //     animation: _opacityAnimation,
      //     builder: (context, child) {
      //       return Opacity(
      //         opacity: _opacityAnimation.value,
      //         child: const Text(
      //           "Propel Soft",
      //           style: TextStyle(
      //             fontSize: 24,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // ),
      Positioned(
        top: 310,
        left: 230,
        child: AnimatedBuilder(
          animation: _opacityAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Stack(
                children: [
                  Row(
                    children: [
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            "Propel Soft",
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'Nunito',
                              color: Color(0xFF9900FF),
                            ),
                            speed: const Duration(milliseconds: 100),
                          ),
                        ],
                        totalRepeatCount: 1,
                        pause: const Duration(milliseconds: 1000),
                        displayFullTextOnTap: true,
                        stopPauseOnTap: true,
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      Positioned(
        top: 330,
        left: 230,
        child: AnimatedBuilder(
          animation: _opacityAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Stack(
                children: [
                  Row(
                    children: [
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            "Accelerating Business Ahead",
                            textStyle: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                            speed: const Duration(milliseconds: 100),
                          ),
                        ],
                        totalRepeatCount: 1,
                        pause: const Duration(milliseconds: 1000),
                        displayFullTextOnTap: true,
                        stopPauseOnTap: true,
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      ],
    ),
      ),
    );
  }
}
