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
  get otp => _otpController.text;
  final StreamController<bool> _buttonController = StreamController<bool>();
  bool _isButtonEnabled = false;
  Future<void> stage1(tempId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('tempModel', tempId);
    await otpValidation();
  }
  String msg = 'Invalid otp';
  Future<void> otpValidation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("tempModel") ?? 0;
    await prefs.setString( 'otp', otp);
    var data = {
      // 'stage': '4',
      'tempId': id,
      'otp': otp,
    };
    print("<___________________Input OTP Api __________________________>");
    // print(data);
    var res = await CallApi().postData('personOtpValidation', data);
    var body = json.decode(res.body);
    print("<___________________Output OTP Api __________________________>");
    print(body);
    if(body['success'] ==true) {
      var responseData = body['data'];
      print(responseData);
      var uId = responseData['uid'];
      // print(uId);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('data', uId);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>  const PasswordCreationScreen()),
      );
    }else{
      msg;
    }
  }
  Future<void> resendOtp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("tempModel") ?? 0;
    String? mobileNumber = prefs.getString('mobileNumber');
    var data = {
      'tempId': id,
      'mobileNumber': mobileNumber,
    };
    print("<___________________Resend OTP Api __________________________>");
    // print(data);
    var res = await CallApi().postData('storeTempPerson', data);
    var body = json.decode(res.body);
    print("<___________________Output Resend OTP Api __________________________>");
    print(body);
    if (body['success'] == true) {
      print('Resent otp successfully ');
      // Reset the OTP field
      // _otpController.clear();
    } else {
      // Set an error message or do something else
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
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) =>  PasswordCreationScreen()),
    // );
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
                          labelText: 'Enter OTP',
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
                            onPressed: () {
                              resendOtp();
                            },
                            child: const Text('Resend OTP',style: TextStyle(color: Colors.blueAccent,fontFamily: 'Nunito'),),
                          ),
                        ),
                      ),

                      const Padding(padding: EdgeInsets.only(top: 50)),
                      StreamBuilder<bool>(
                        stream: _buttonController.stream,
                        builder: (context, snapshot) {
                          return ElevatedButton(
                            onPressed: snapshot.data ?? false ? _onSubmit : null,
                            child: const Text('Validate',style: TextStyle(fontFamily: 'Nunito'),),
                          );
                        },
                      ),

      ])),
    ])
    ),
    );
  }
}

