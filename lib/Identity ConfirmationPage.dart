import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:propel_login/Api%20Connection/Api.dart';
import 'package:propel_login/CreateNewAccount1.dart';
import 'package:propel_login/Mobile%20OTP%20Validation%20Screen.dart';
import 'package:propel_login/PersonData%20ConfirmationScreen.dart';
import 'package:propel_login/PhoneNumScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PDCScreen extends StatefulWidget {
  const PDCScreen({Key? key}) : super(key: key);

  @override
  State<PDCScreen> createState() => _PDCScreenState();
}
class _PDCScreenState extends State<PDCScreen> {
  final _phoneController = TextEditingController();
  final _phoneFocusNode = FocusNode();

  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  get stage => 1;

  String mobileNumbers = '';
  void phoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phoneNumber = prefs.getString('mobileNumber');
    setState(() {
      mobileNumbers = phoneNumber ?? '';
    });
  }
  String email = '';
  void Email() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Email = prefs.getString('email');
    setState(() {
      email = Email ?? '';
    });
  }
  Future<void> stage1(stage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mobileNumber = prefs.getString('mobileNumber');
    String? email = prefs.getString('email');
    await prefs.setString( 'stage', '1');
    var data = {
      'email': email,
      'mobileNumber': mobileNumber,
      'stage': '1',
    };
    print("<___________________Input Identity Confirmation Page Api __________________________>");
    print(data);

    var res = await CallApi().postData('storeTempPerson', data);
    var body = json.decode(res.body);

    print("<___________________ Output Identity Confirmation Api __________________________>");
    print(body);
    if(body['success'] ==true) {
     var responseData = body['data'];
     var tempModel = responseData['tempModel'];
     var tempId = tempModel['id'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('tempModel', tempId);
     checkingPerson();
    }
  }
  Future<void> checkingPerson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString("data");
    String? status = prefs.getString("status");
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
    print(status);
    print(body);
    if (status == "fUser") {
      // FreshUser
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NewAccount1Screen(personData: null,)),
      );
    } else if (status=="puid") {
        // MappedPerson
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PersonDataConfirmationScreen()),
        );
      } else{
        // ExactPerson
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MobileOtpValidation()),
        );
      }
    }

  @override
  void initState() {
    super.initState();
    phoneNumber();
    Email();
    _phoneFocusNode.addListener(_onFocusChange);
    _emailFocusNode.addListener(_onFocusChange);
  }
  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }
  void _onFocusChange() {
    setState(() {
      // _showLabel1 = _phoneFocusNode.hasFocus;


      // _showLabel2 = _emailFocusNode.hasFocus;
    });
  }
  String? selectedOption;
  bool isButtonEnabled = false;
  void _clearTextField() {
    _phoneController.clear();
    _emailController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            key: _formKey,
            children: [
          const Padding(padding: EdgeInsets.only(top: 50)),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
              const Padding(padding: EdgeInsets.only(top: 60)),
              SizedBox(
                width: 300,
                height: 40,
                child:Center(
                  child: TextField(
                    readOnly: true,
                    controller: TextEditingController(text: mobileNumbers),
                    decoration:  InputDecoration(
                      border: OutlineInputBorder( borderRadius: BorderRadius.circular(8.0)),
                      labelText: 'Mobile Number',
                    ),
                    // Define an input formatter to enforce the desired condition
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[6-9]\d{0,9}$')),
                    ],
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
      SizedBox(
          width: 300,
          height: 40,
          child: Center(
                child: TextField(
                  // readOnly: true,
                  controller: TextEditingController(text: email),
                  decoration:  InputDecoration(
                    border: OutlineInputBorder( borderRadius: BorderRadius.circular(8.0)),
                    labelText: 'Email',
                  ),
                ),
              ),
      ),
              const Padding(padding: EdgeInsets.only(top: 50)),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<String>(
                          value: '1',
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value;
                              isButtonEnabled = true;
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => const NewAccount1Screen()),
                              // );
                              _clearTextField();
                            });
                          },
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Center(
                          child:  SizedBox(
                            width: 250,
                            child: Text('The above details are my personal mobile number and email',style: TextStyle(fontFamily: 'Nunito'),),
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<String>(
                          value: '2',
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value;
                              isButtonEnabled = true;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Center(
                          child:  SizedBox(
                            width: 250,
                            child: Text('The above detail are not mine, I use or share information of '
                                'my family member. Else I use my official, which I may hand over on my exit',style: TextStyle(fontFamily: 'Nunito')),
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 50)),
                    ElevatedButton(
                      onPressed: isButtonEnabled ? () {
                        if (selectedOption == '1') {
                          stage1(stage);
                        } else if (selectedOption == '2') {
                          showConfirmationDialog();
                        }
                        _clearTextField();
                      } : null,
                    child: const Text('Submit',style: TextStyle(fontFamily: 'Nunito')),
                    ),
                  ],
                ),
              ),
        ]),
      ),
    );
  }
  Future<void> showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            title: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF9900FF),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10.0),
              child:  Center(
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                      Text(
                        'INFORMATION',
                        style: TextStyle(
                          color: Color(0xFF9900FF),
                          fontSize: 18.0,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.info,
                        color: Color(0xFF9900FF),
                      ),
                    ],
                  ),
                )),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  SizedBox(
                    width: 280,
                    child: Column(
                      children: const [
                        Text(
                          'Sorry for the inconvenience caused, we need a unique mobile number and email owned by you to signup into the system.',
                          style: TextStyle(fontFamily: 'Nunito'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text(
                    'Continue', style: TextStyle(fontFamily: 'Nunito',color: Color(0xFF8000FF))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  const LoginScreen()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
// Define a new class to hold the data
class Person {
  final int personId;
  final String personUid;
  final String personName;
  final String emailId;
  final String mobileId;

  Person({
    required this.personId,
    required this.personUid,
    required this.personName,
    required this.emailId,
    required this.mobileId,
  });
}


