// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:propel_login/PhoneNumScreen.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _opacityAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.3, 0.6), // only animate for first half of the animation
//       ),
//     );
//     _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.6, 1.0), // only animate for second half of the animation
//       ),
//     );
//
//     _controller.forward().whenComplete(() {
//       // Navigate to LoginScreen after 2 seconds
//       Future.delayed(const Duration(seconds: 5), () {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const LoginScreen()),
//         );
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body:  Center(
//         child: Stack(
//       children: [
//       Positioned(
//       top: 300,
//         left: 180,
//         child: AnimatedBuilder(
//           animation: _scaleAnimation,
//           builder: (context, child) {
//             return ScaleTransition(
//               scale: _scaleAnimation,
//               child: SvgPicture.asset(
//                 'asset/logo.svg',
//                 width: 50,
//                 height: 50,
//               ),
//             );
//           },
//         ),
//       ),
//       // Positioned(
//       //   top: 60,
//       //   left: 70,
//       //   child: AnimatedBuilder(
//       //     animation: _opacityAnimation,
//       //     builder: (context, child) {
//       //       return Opacity(
//       //         opacity: _opacityAnimation.value,
//       //         child: const Text(
//       //           "Propel Soft",
//       //           style: TextStyle(
//       //             fontSize: 24,
//       //             fontWeight: FontWeight.bold,
//       //           ),
//       //         ),
//       //       );
//       //     },
//       //   ),
//       // ),
//       Positioned(
//         top: 310,
//         left: 230,
//         child: AnimatedBuilder(
//           animation: _opacityAnimation,
//           builder: (context, child) {
//             return Opacity(
//               opacity: _opacityAnimation.value,
//               child: Stack(
//                 children: [
//                   Row(
//                     children: [
//                       AnimatedTextKit(
//                         animatedTexts: [
//                           TypewriterAnimatedText(
//                             "Propel Soft",
//                             textStyle: const TextStyle(
//                               fontSize: 18,
//                               fontFamily: 'Nunito',
//                               color: Color(0xFF9900FF),
//                             ),
//                             speed: const Duration(milliseconds: 100),
//                           ),
//                         ],
//                         totalRepeatCount: 1,
//                         pause: const Duration(milliseconds: 1000),
//                         displayFullTextOnTap: true,
//                         stopPauseOnTap: true,
//                       ),
//                       const SizedBox(width: 10),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//       Positioned(
//         top: 330,
//         left: 230,
//         child: AnimatedBuilder(
//           animation: _opacityAnimation,
//           builder: (context, child) {
//             return Opacity(
//               opacity: _opacityAnimation.value,
//               child: Stack(
//                 children: [
//                   Row(
//                     children: [
//                       AnimatedTextKit(
//                         animatedTexts: [
//                           TypewriterAnimatedText(
//                             "Accelerating Business Ahead",
//                             textStyle: const TextStyle(
//                               fontSize: 10,
//                               color: Colors.grey,
//                             ),
//                             speed: const Duration(milliseconds: 100),
//                           ),
//                         ],
//                         totalRepeatCount: 1,
//                         pause: const Duration(milliseconds: 1000),
//                         displayFullTextOnTap: true,
//                         stopPauseOnTap: true,
//                       ),
//                       const SizedBox(width: 10),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//       ],
//     ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:propel_login/PhoneNumScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _showFirstText = false;
  bool _showSecondText = false;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with a duration of 2 seconds
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ).drive(Tween<double>(begin: 0.1, end: 1.0));

    _animationController.forward();

    Timer(const Duration(seconds: 3), () {
      setState(() {
        _showFirstText = true;
        _animationController.reverse();
      });
    });

    Timer(const Duration(seconds: 4), () {
      setState(() {
        _showSecondText = true;
      });
    });

    Timer(const Duration(seconds: 5), () {
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
             children: [
            AnimatedContainer(
              duration: const Duration(seconds: 2),
              curve: Curves.easeOut,
              height: _animation.value * 80,
              width: _animation.value * 80,
              child: Transform.scale(
                scale: _animation.value,
                child:SvgPicture.asset(
                  'asset/logo.svg',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  duration: const Duration(seconds: 2),
                  opacity: _showFirstText ? 1.0 : 0.0,
                  child: const Text(
                    'Propel Soft',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 26,
                      // fontWeight: FontWeight.bold,
                      color: Color(0xFF9900FF),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                AnimatedOpacity(
                  duration: const Duration(seconds: 1),
                  opacity: _showSecondText ? 1.0 : 0.0,
                  child: const Text(
                    'Accelerate Business Ahead',
                    style: TextStyle(
                      fontSize: 10,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ]
        ),
    )
    );
  }


  @override
  void dispose() {
    // Dispose the animation controller to avoid memory leaks
    _animationController.dispose();
    super.dispose();
  }
}
