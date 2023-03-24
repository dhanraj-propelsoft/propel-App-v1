import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class WelcomScreen extends StatefulWidget {
  const WelcomScreen({Key? key}) : super(key: key);

  @override
  State<WelcomScreen> createState() => _WelcomScreenState();
}

class _WelcomScreenState extends State<WelcomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: const [
        //  const Padding(padding: EdgeInsets.only(top: 50)),
        // Center(
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           SvgPicture.asset(
        //             'asset/logo.svg',
        //             width: 50,
        //             height: 50,
        //           ),
        //           const SizedBox(width: 10),
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: const [
        //               Text(
        //                 'Propel soft',
        //                 style: TextStyle(
        //                   fontSize: 30,
        //                   color: Color(0xFF9900FF),
        //                   fontWeight: FontWeight.bold,
        //                 ),
        //               ),
        //               Text(
        //                 'Accelerating Business Ahead',
        //                 style: TextStyle(
        //                   fontSize: 10,
        //                   color: Colors.grey,
        //                 ),
        //               ),
        //             ],
        //           )
        //         ],
        //       ),
        // ),
        // const Padding(padding: EdgeInsets.only(top: 100)),
        SizedBox(
          height: 300,
        ),
        Center(
          child: Text("Propel soft Welcomes You",style: TextStyle(color: Color(0xFF9900FF)),
        ),
        ),
        Padding(padding: EdgeInsets.only(top: 30)),
        Center(
          child: Text("Mr.Selvaraj !",style: TextStyle(color: Color(0xFF9900FF)),
        ),
        ),
      ]),
    );
  }
}
