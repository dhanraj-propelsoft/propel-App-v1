import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:propel_login/Api%20Connection/Api.dart';
import 'package:propel_login/Email%20OTP%20Validation%20%20for%20Forgot%20Password%20Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'PasswordScreen.dart';
class WrongPasswordScreen extends StatefulWidget {
  const WrongPasswordScreen({Key? key}) : super(key: key);

  @override
  State<WrongPasswordScreen> createState() => _WrongPasswordScreenState();
}

class _WrongPasswordScreenState extends State<WrongPasswordScreen> {

  Future<void> otpValidation(uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', uid);
    await  generateEmailOTP();
  }
  // Future<void> emailOTPValidation() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String uid = prefs.getString("data") ?? '';
  //   var data = {
  //     'uid': uid,
  //   };
  //   print(data);
  //   var res = await CallApi().postData('generateEmailOtp', data);
  //   var body = json.decode(res.body);
  //   if (body['uid'] == true) {
  //    // Store OTP in SharedPreferences
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => const EmailOtpValidationScreen()),
  //     );
  //   } else {
  //     print("Failed to generate OTP.");
  //   }
  // }
  Future<void> generateEmailOTP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("data") ?? '';
    var data = {
      'uid': uid,
    };
    print("<___________________Input generateEmailOTP Api __________________________>");
    print(data);

    var res = await CallApi().postData('generateEmailOtp', data);
    var body = json.decode(res.body);
    print("<___________________output generateEmailOTP Api __________________________>");
    print(body);

    if (body['message'] == 'ok' || body['message'] == 'success') {
      // Store OTP in SharedPreferences
    }

    Navigator.push(context, MaterialPageRoute(builder: (ctx) => const EmailOtpValidationScreen()));
  }

  String fullName = '';

  String firstName = '';
  String middleName = '';
  // String lastName = '';

  void getNames() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? first = prefs.getString('firstName');
    String? middle = prefs.getString('middleName');
    // String? last = prefs.getString('lastName');

    setState(() {
      firstName = first ?? '';
      middleName = middle ?? '';
      // lastName = last ?? '';
      fullName =
      '$firstName${middleName.isNotEmpty ? '$middleName ' : ''}';
      // '$lastName';
    });
  }
  @override
  void initState() {
    super.initState();
    getNames();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Center(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 30)),
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                children: [
                  const SizedBox(
                    width: 150,
                    height: 50,
                  ),
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
                          fontFamily: 'Nunito',
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
            const Padding(padding: EdgeInsets.symmetric(horizontal: 50,vertical: 30)),
            Align(
              alignment: const Alignment(-0.7, 0.5),
              child: Text('Hi! $fullName',style: const TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Nunito'),),
            ),
           const Padding(padding: EdgeInsets.only(top: 50)),
             const Center(
               child:
             SizedBox(
               width: 350,
               child: Text('Hope you bad entered wrong Password you can try again or else Reset through Forgot '
                   'Password',  style: TextStyle(fontSize: 16,color: Colors.black54,  fontFamily: 'Nunito', fontWeight: FontWeight.bold), ),
              ),
             ),
            const Padding(padding: EdgeInsets.only(top: 50)),
            SizedBox(
              width: 350,
              height: 40,
              child: Row(
                children: [
                  SizedBox(
                    width: 150,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        generateEmailOTP();
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const EmailOtpValidationScreen()),
                        // );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(
                              color: Colors.purple,
                              width: 2.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                      ),
                      child: const Text("Forgot Password",style: TextStyle(color: Colors.purple,fontFamily: 'Nunito'),),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PasswordScreen()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(
                              color: Colors.purple,
                              width: 2.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                      ),
                      child: const Text('Try Again',style: TextStyle(color: Colors.purple,fontFamily: 'Nunito')),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 50)),
            const SizedBox(
              width: 300,
              child: Text.rich(
                TextSpan(
                  text: "If you don't hold the above email/mobile , also if you are not holding any previous account Kindly contact ",
                  style: TextStyle(fontSize: 14,color: Colors.black54,fontFamily: 'Nunito',fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Propelsoft',
                      style: TextStyle(
                          color: Color(0xFF9900FF),
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
