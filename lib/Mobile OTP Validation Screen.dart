import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:propel_login/Api%20Connection/Api.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'Email OTP Validation for Exact and Mapped Person Screen.dart';

class MobileOtpValidation extends StatefulWidget {
  const MobileOtpValidation({Key? key}) : super(key: key);

  @override
  State<MobileOtpValidation> createState() => _MobileOtpValidationState();
}

class _MobileOtpValidationState extends State<MobileOtpValidation> {
  final TextEditingController _otpController = TextEditingController();
  final StreamController<bool> _buttonController = StreamController<bool>();
  bool _isButtonEnabled = false;
  // String fullName = '';



  @override
  void initState() {
    super.initState();
    // getNames();
    _otpController.addListener(_onOtpChanged);
    _buttonController.add(_isButtonEnabled);
  }
  Future<void> mobileOTPValidation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mobileNumber = prefs.getString('mobileNumber');
    String uid = prefs.getString("data") ?? '';
    var data = {
      'uid': uid,
      'mobileNumber': mobileNumber,
    };
    print("<___________________Input mobileOTPValidation Api __________________________>");
    print(data);
    var res = await CallApi().postData('personMobileOtp', data);
    var body = json.decode(res.body);
    print("<___________________output mobileOTPValidation Api __________________________>");
    print(body);
    if (body['message'] == 'ok' || body['message'] == 'success') {
      // Store OTP in SharedPreferences
    }
    generateEmailOTP();
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (ctx) => const EmailOtpValidationScreen()));
  }
  Future<void> resendOtp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("tempModel") ?? 0;
    var data = {
      // 'stage': '4',
      'tempId': id,
    };
    print("<___________________Input Resend OTP Api __________________________>");
    // print(data);
    var res = await CallApi().postData('personOtpValidation', data);
    var body = json.decode(res.body);
    print("<___________________Output Resend OTP Api __________________________>");
    print(body);
    if (body['success'] == true) {
      // Reset the OTP field
      _otpController.clear();
    } else {
      // Set an error message or do something else
    }
  }
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
    Navigator.push(context,
        MaterialPageRoute(builder: (ctx) => const EmailOtpValidationExactAndMappedPersonScreen()));
  }
  void _onOtpChanged() {
    setState(() {
      _isButtonEnabled = _otpController.text.length == 4;
    });
    _buttonController.add(_isButtonEnabled);
  }
  void _submit() {
    mobileOTPValidation();
    generateEmailOTP();
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const NewPasswordCreateScreen()),
    // );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                // const Padding(padding: EdgeInsets.symmetric(horizontal: 50,vertical: 30)),
                // Align(
                //   alignment: const Alignment(-0.7, 0.5),
                //   child: Text('Hi! $fullName',style: const TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Nunito'),),
                // ),
                const Padding(padding: EdgeInsets.only(top: 50)),
                Center(
                    child: Column(
                        children: [
                          SizedBox(
                            width: 350,
                            height: 40,
                            child:  TextField(
                              controller: _otpController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelStyle:  TextStyle(
                                  fontFamily: 'Nunito',
                                  // fontStyle: FontStyle.italic,
                                  // fontWeight: FontWeight.bold,

                                ),
                                hintStyle:  TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 14
                                  // fontStyle: FontStyle.italic,
                                  // fontWeight: FontWeight.bold,

                                ),
                                labelText: 'Enter OTP',
                                hintText: 'Enter OTP Received on your mobile  99xxx xx55x',
                              ),
                              // maxLength: 4,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 30)),
                          SizedBox(
                            width: 350,
                            height: 40,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child:   TextButton(
                                onPressed: resendOtp,
                                child: const Text('Resend OTP',style: TextStyle(color: Colors.blueAccent,fontFamily: 'Nunito'),),
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          StreamBuilder<bool>(
                            stream: _buttonController.stream,
                            builder: (context, snapshot) {
                              return SizedBox(
                                width: 350,
                                height: 40,
                                child: Row(
                                  children: [
                                    // SizedBox(
                                    //   // width: 130,
                                    //   // height: 30,
                                    //   child: ElevatedButton(
                                    //     onPressed: () {},
                                    //     style: ButtonStyle(
                                    //       backgroundColor: MaterialStateProperty
                                    //           .all<Color>(Colors.white),
                                    //       shape: MaterialStateProperty.all<
                                    //           RoundedRectangleBorder>(
                                    //         RoundedRectangleBorder(
                                    //           borderRadius: BorderRadius
                                    //               .circular(8.0),
                                    //           side: const BorderSide(
                                    //             color: Colors.purple,
                                    //             width: 2.0,
                                    //             style: BorderStyle.solid,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     child: Text("I'm not $fullName",
                                    //       style: const TextStyle(
                                    //           color: Colors.purple,
                                    //           fontFamily: 'Nunito'),),
                                    //   ),
                                    // ),
                                    const Spacer(),
                                    SizedBox(
                                      width: 100,
                                      height: 30,
                                      child: ElevatedButton(
                                        onPressed: _isButtonEnabled
                                            ? _submit
                                            : null,
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(8.0),
                                              side: const BorderSide(
                                                color: Colors.purple,
                                                width: 2.0,
                                                style: BorderStyle.solid,
                                              ),
                                            ),
                                          ),
                                          backgroundColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                              if (states.contains(
                                                  MaterialState.disabled)) {
                                                return Colors.white12;
                                              }
                                              return Colors.purple;
                                            },
                                          ),
                                          foregroundColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                              if (states.contains(
                                                  MaterialState.disabled)) {
                                                return Colors.purple;
                                              }
                                              return Colors.white;
                                            },
                                          ),
                                          elevation: MaterialStateProperty
                                              .resolveWith<double>(
                                                (Set<MaterialState> states) {
                                              if (states.contains(
                                                  MaterialState.disabled)) {
                                                return 0;
                                              }
                                              return 4;
                                            },
                                          ),
                                        ),
                                        child: const Text('Login',
                                          style: TextStyle(
                                              fontFamily: 'Nunito'),),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
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

                        ])),
              ])
      ),
    );
  }
}
