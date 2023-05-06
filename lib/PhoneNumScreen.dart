import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:propel_login/Api%20Connection/Api.dart';
import 'package:propel_login/EmailScreen.dart';
import 'package:propel_login/PasswordScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isButtonDisabled = true;
  final RegExp mobileRegex = RegExp(r'^(\+91|91)?[6-9]\d{9}$');
  final _focusNode = FocusNode();
  bool _showLabel = false;

  get phoneNumber => _phoneController.text;
  void _checkInput() {
    String phone = _phoneController.text;
    bool isValidPhone = RegExp(r'^\d{10}$').hasMatch(phone);
    setState(() {
      _isButtonDisabled = !isValidPhone;
    });}
  Future<void> PhoneNumber(phoneNumber) async {
    var data = {
      'mobileNumber':phoneNumber,
    };
    if (kDebugMode) {
      print("<___________________Input mobile No Api __________________________>");
    }
    // if (kDebugMode) {
    //   print(data);
    // }
    var response1 = await CallApi().postData("findMobileNumber",data);
    var body  = jsonDecode(response1.body);

    if (kDebugMode) {
      print("<___________________Output mobile No Api __________________________>");
    }
    if (kDebugMode) {
      print(body);
    }
    if (body['success'] == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('mobileNumber', phoneNumber);
      var type = body['data']['type'];
      if (type == 0) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => const EmailScreen()),
        );
        _clearTextField();
      } else if (type == 1) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => const PasswordScreen()),
        );
        _clearTextField();
      }
    }
    return;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }
  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _phoneController.dispose();
    super.dispose();
  }
  void _onFocusChange() {
    setState(() {
      _showLabel = _focusNode.hasFocus;
    });
  }
  void _clearTextField() {
    _phoneController.clear();
  }
  String msg = "";
  @override
  Widget build(BuildContext context) {
    // String phone = _phoneController.text;
    return Scaffold(
      body: SingleChildScrollView(
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
          const Padding(padding: EdgeInsets.only(top: 100)),
          Center(
            child: SizedBox(
              width: 300,
              child: TextField(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      Future.delayed(const Duration(seconds: 1), () {
                        Navigator.pop(context);
                      });

                      return AlertDialog(
                        content: GestureDetector(
                          child: const Text(
                            'Currently we are available only in India',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 14,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  );
                  _focusNode.requestFocus();
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    prefixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '+91',
                        ),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                    // enabled: false,
                    hintText: 'India',
                    hintStyle: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 14
                    ),
                    suffixIcon: Image.network(
                      'https://cdn.pixabay.com/photo/2016/08/24/17/07/india-1617463__340.png',
                      width: 15,
                      height: 10,
                    )),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 50)),
          Center(
            child: SizedBox(
              width: 300,
              height: 40,
              child: TextFormField(
                controller: _phoneController,
                focusNode: _focusNode,
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^[6-9]\d*')),
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: InputDecoration(
                  hintText: 'Enter your personal Mobile Number only',
                  labelText: _showLabel ? 'Mobile Number *' : null,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  labelStyle: const TextStyle(
                    fontFamily: 'Nunito',
                    // fontStyle: FontStyle.italic,
                    // fontWeight: FontWeight.bold,
                  ),
                  hintStyle: const TextStyle(
                    fontFamily: 'Nunito',
                    // fontWeight: FontWeight.bold,
                    // fontStyle: FontStyle.italic,
                    fontSize: 14,
                  ),
                ),
                onChanged: (_) => _checkInput(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mobile number is required';
                  }
                  return null;
                },
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 40)),
          Padding(
            padding: const EdgeInsets.only(left: 200.0),
            child: SizedBox(
              width: 100,
              height: 35,
              child: ElevatedButton(
                onPressed: _isButtonDisabled
                    ? null
                    : () => {
                  PhoneNumber(phoneNumber )
                        },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: const BorderSide(
                        color: Color(0xFF9900FF),
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
                      return const Color(0xFF9900FF);
                    },
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return const Color(0xFF9900FF);
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
          const Padding(
              padding: EdgeInsets.only(
            top: 40,
          )),
          const Text(
            "Don't have a login yet.....!",
            style: TextStyle(color: Colors.black54,fontFamily: 'Nunito', fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 300,
            child: Text(
              "Just enter your mobile number and follow us. We ensure your Signup for a New Account in few steps . ",
              style: TextStyle(color: Colors.black54,  fontFamily: 'Nunito', fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      ),
    );
  }
}
