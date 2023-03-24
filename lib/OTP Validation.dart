import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:propel_login/Api%20Connection/Api.dart';
import 'package:propel_login/CreatePasswordScreen.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class OtpValidationScreen extends StatefulWidget {
  const OtpValidationScreen({Key? key}) : super(key: key);

  @override
  _OtpValidationScreenState createState() => _OtpValidationScreenState();
}

class _OtpValidationScreenState extends State<OtpValidationScreen> {
  final TextEditingController _otpController = TextEditingController();
  final StreamController<bool> _buttonController = StreamController<bool>();
  bool _isButtonEnabled = false;
  get otp => _otpController.text;
  Future<void> stage1(tempId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('tempModel', tempId);
    await otpValidation();
  }
  Future<void> otpValidation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("tempModel") ?? 0;
    var data = {
      // 'stage': '4',
      'tempId': id,
      'otp': _otpController.text,
    };
    print("<___________________Input OTP Api __________________________>");
    // print(data);
    var res = await CallApi().postData('personOtpValidation', data);
    var body = json.decode(res.body);
    print("<___________________Output OTP Api __________________________>");
    print(body);
    if(body['success'] ==true) {
      print('success');
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>  PasswordCreationScreen()),
      );
    }else{
      print("don't get otp");
    }
  }
  @override
  void initState() {
    super.initState();
    _otpController.addListener(_onOtpChanged);
    _buttonController.add(_isButtonEnabled);
  }

  @override
  void dispose() {
    _otpController.dispose();
    _buttonController.close();
    super.dispose();
  }

  void _onOtpChanged() {
    setState(() {
      _isButtonEnabled = _otpController.text.length == 4;
    });
    _buttonController.add(_isButtonEnabled);
  }

  void _onSubmit() {
    otpValidation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
              children: [
          const Padding(padding: EdgeInsets.only(top: 50)),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // add this line
                    children: [
                      SvgPicture.asset(
                        'asset/logo.svg',
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Propel soft',
                            style: TextStyle(
                              fontSize: 30,
                              color: Color(0xFF9900FF),
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Accelerating Business Ahead',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 50)),
                Center(
                  child: SizedBox(
                  width: 300,
                  height: 30,
                  child: Column(
                    children: [
                      TextField(
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter OTP',
                        ),
                        maxLength: 4,
                      ),
                      StreamBuilder<bool>(
                        stream: _buttonController.stream,
                        builder: (context, snapshot) {
                          return ElevatedButton(
                            onPressed: snapshot.data ?? false ? _onSubmit : null,
                            child: const Text('Validate'),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                ),
      ])),
    );
  }
}

// class OTP_validationScreen extends StatefulWidget {
//   const OTP_validationScreen({Key? key}) : super(key: key);
//
//   @override
//   State<OTP_validationScreen> createState() => _OTP_validationScreenState();
// }
//
// class _OTP_validationScreenState extends State<OTP_validationScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: Column(
//               children: [
//           const Padding(padding: EdgeInsets.only(top: 50)),
//                 Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SvgPicture.asset(
//               'asset/logo.svg',
//               width: 50,
//               height: 50,
//             ),
//             const SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text(
//                   'Propel soft',
//                   style: TextStyle(
//                     fontSize: 30,
//                     color: Color(0xFF9900FF),
//                     // fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'Accelerating Business Ahead',
//                   style: TextStyle(
//                     fontSize: 10,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//
//                    ]
//                  )
//               )
//             );
//   }
// }
