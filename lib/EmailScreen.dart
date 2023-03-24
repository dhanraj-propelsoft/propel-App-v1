import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:propel_login/Api%20Connection/Api.dart';
import 'package:propel_login/InformationScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  bool _isButtonDisabled = true;
  final _focusNode = FocusNode();
  bool _showLabel = false;
  final _formKey = GlobalKey<FormState>();
  get email => _emailcontroller.text;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  Future<void> PhoneNumber(phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('mobileNumber', phoneNumber);

    await checkEmail(phoneNumber);
  }

  Future<void> checkEmail(email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mobileNumber = prefs.getString('mobileNumber');

    var data = {
      'email': email,
      'mobileNumber': mobileNumber,
    };
    print("<___________________Input Email Api __________________________>");
    print(data);
    var res = await CallApi().postData('findCredential', data);
    var body = json.decode(res.body);

    print("<___________________Output Email Api __________________________>");
    print(body);
    if(body['success'] ==true){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString( 'email', email);
      Navigator.push(context,
          MaterialPageRoute(builder: (ctx) => const InformationScreen()));
      _clearTextField();
    }
    else {
      // Show alert message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Alert'),
          content: Text('phone number and email is already exits.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
    // print(type);
  }


  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _emailcontroller.dispose();
    super.dispose();
  }
  void _onFocusChange() {
    setState(() {
      _showLabel = _focusNode.hasFocus;
    });
  }
  void _checkInput() {
    String value = _emailcontroller.text;
    bool isValidemail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);

    setState(() {
      _isButtonDisabled = !isValidemail;
    });
  }
  void _clearTextField() {
    _emailcontroller.clear();
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
                      Padding(padding: EdgeInsets.only(top: 3,left: 4)),
                      Text(
                        'Accelerating Business Ahead',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 50)),
            const Center(
              child: SizedBox(
                width: 350,
              child: Text('No credentials are fount , with your mobile number 78**5****56, Kindly provide email for cross verification'),
            ),
            ),
            const Padding(padding: EdgeInsets.only(top: 50)),
            Center(
              child: SizedBox(
                width: 350,
                height: 40,
                child: TextFormField(
                  controller: _emailcontroller,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: 'Enter your personal Email only',
                      labelText: _showLabel ? 'Email *' : null,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  onChanged: (_) => _checkInput(),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 40)),
            Padding(
              padding: const EdgeInsets.only(left: 250.0),
              child: SizedBox(
                width: 100,
                height: 35,
                child: ElevatedButton(
                  onPressed: _isButtonDisabled
                      ? null
                      : () => {
                    checkEmail(email)

                  },
                  style: ButtonStyle(
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
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.white12;
                        }
                        return Colors.purple;
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.purple;
                        }
                        return Colors.white;
                      },
                    ),
                    elevation: MaterialStateProperty.resolveWith<double>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return 0;
                        }
                        return 4;
                      },
                    ),
                  ),
                  child: const Text('Submit'),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 50)),
            const Center(
              child: SizedBox(
                width: 350,
                child: Text(
                  "Kindly provide you personal and permeant email only never enter any official email which may be invalid on time.. "
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
