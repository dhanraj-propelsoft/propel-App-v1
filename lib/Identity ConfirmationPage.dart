import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:propel_login/Api%20Connection/Api.dart';
import 'package:propel_login/NewAccount1.dart';
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

  Future<void> PhoneNumber(phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('mobileNumber', phoneNumber);
    await stage1(stage);
  }
  Future<void> checkEmail(email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString( 'email', email);

    await stage1(stage);
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
     // print(responseData);
     var tempModel = responseData['tempModel'];
     // print(tempModel);
     var tempId = tempModel['id'];
     // print(tempId);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('tempModel', tempId);
     Navigator.push(
       context,
       MaterialPageRoute(
           builder: (context) => const NewAccount1Screen()),
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
              const Padding(padding: EdgeInsets.only(top: 60)),
              Center(
                child: Container(
                  width: 350,
                  height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, //color of border
                          width: 1, //width of border
                        ),
                        borderRadius: BorderRadius.circular(5)
                    ),
                   child:Align(
                      alignment: Alignment.centerLeft,
                      child: Text(mobileNumbers,style: TextStyle(fontSize: 16),),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              Center(
                child: Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, //color of border
                        width: 1, //width of border
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child:Align(
                    alignment: Alignment.centerLeft,
                    child: Text(email,style: TextStyle(fontSize: 16),),
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
                            width: 350,
                            child: Text('The above details are my personal mobile number and email'),
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
                              isButtonEnabled = false;
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => const NewAccount1Screen()),
                              // );
                              // _clearTextField();
                            });
                          },
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Center(
                          child:  SizedBox(
                            width: 350,
                            child: Text('The above detail are not mine, I use or share information of '
                                'my family member. Else I use my official, which I may hand over on my exit'),
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 50)),
                    ElevatedButton(
                      onPressed: isButtonEnabled ? () {

                            stage1(stage);

                          _clearTextField();
                        }
                      : null,
                    child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
        ]),
      ),
    );
  }
}
