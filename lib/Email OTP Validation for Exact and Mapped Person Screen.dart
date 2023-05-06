import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:propel_login/Api%20Connection/Api.dart';
import 'package:propel_login/Exact%20PersonData%20Screen1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailOtpValidationExactAndMappedPersonScreen extends StatefulWidget {
  const EmailOtpValidationExactAndMappedPersonScreen({Key? key}) : super(key: key);

  @override
  State<EmailOtpValidationExactAndMappedPersonScreen> createState() => _EmailOtpValidationExactAndMappedPersonScreenState();
}

class _EmailOtpValidationExactAndMappedPersonScreenState extends State<EmailOtpValidationExactAndMappedPersonScreen> {
  final TextEditingController _otpController = TextEditingController();
    final StreamController<bool> _buttonController = StreamController<bool>();
    bool _isButtonEnabled = false;
    get otp => _otpController.text;
    @override
    void initState() {
      super.initState();
      _otpController.addListener(_onOtpChanged);
      _buttonController.add(_isButtonEnabled);
    }
    Future<void> emailOtpValidation() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String uid = prefs.getString("data") ?? '';
      String? email = prefs.getString('email');
      await prefs.setString('otp', otp);
      var data = {
        'email': email,
        'uid': uid,
        'otp': otp,
      };
      print("<___________________Input OTP Api __________________________>");
      // print(data);
      var res = await CallApi().postData('emailOtpValidation', data);
      var body = json.decode(res.body);
      print("<___________________Output OTP Api __________________________>");
      print(body);
      var type = body['type'];
      if(type == 1){
        checkingPerson();
      }else if (type == 0){
        print('failed');
      }
    }
  Future<void> checkingPerson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString("data");
    // String? status = prefs.getString("status");
    if (uid == null) {
      return;
    }
    var data = {
      'uid': uid,
    };
    print("<___________________Input  checkingPerson Page Api __________________________>");
    var res = await CallApi().postData('personDatas', data);
    var body = json.decode(res.body);
    print("<___________________ Output checkingPerson Api __________________________>");
    // print(status);
    print(body);

    if (body["success"]) {
      var personData = body["data"]["personData"];
      var first_name = personData['first_name'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('personData', first_name);
      Navigator.push(context, MaterialPageRoute(builder: (context) => ExactPersonScreen1(personData: personData)));
    } else {
    }
  }

  Future<void> resendOtp() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int id = prefs.getInt("tempModel") ?? 0;
      var data = {
        // 'stage': '4',
        'tempId': id,
      };
      print("<___________________Resend OTP Api __________________________>");
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
    void _onOtpChanged() {
      setState(() {
        _isButtonEnabled = _otpController.text.length == 5;
      });
      _buttonController.add(_isButtonEnabled);
    }
    void _submit() {
      emailOtpValidation();
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
                                color: Color(0xFF8000FF),
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
                              width: 300,
                              height: 40,
                              child:  TextField(
                                controller: _otpController,
                                keyboardType: TextInputType.number,
                                decoration:  InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0)
                                  ),
                                    contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                  labelStyle:  const TextStyle(
                                    fontFamily: 'Nunito',
                                    // fontStyle: FontStyle.italic,
                                    // fontWeight: FontWeight.bold,

                                  ),
                                  labelText: 'Enter OTP',
                                    hintStyle:  const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 14,

                                      // fontStyle: FontStyle.italic,
                                      // fontWeight: FontWeight.bold,

                                    ),
                                  hintText: 'Enter OTP Received on your email xx@gxxl.com'
                                ),
                                // maxLength: 4,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 30)),
                            SizedBox(
                              width: 300,
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
                                  width: 300,
                                  height: 40,
                                  child: Row(
                                    children: [
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
                                                  color: Color(0xFF9900FF),
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
                                                return const Color(0xFF9900FF);
                                              },
                                            ),
                                            foregroundColor: MaterialStateProperty
                                                .resolveWith<Color>(
                                                  (Set<MaterialState> states) {
                                                if (states.contains(
                                                    MaterialState.disabled)) {
                                                  return const Color(0xFF9900FF);
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
                          ])),
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
                ])
        ),
      );
    }
  }
