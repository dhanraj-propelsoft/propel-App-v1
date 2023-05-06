import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:propel_login/Api%20Connection/Api.dart';
import 'package:propel_login/WrongPasswordScreen.dart';

import 'package:propel_login/WelcomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}
class _PasswordScreenState extends State<PasswordScreen> {
  Future<void> checkingPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mobileNumber = prefs.getString('mobileNumber');
    String? savedPassword = prefs.getString('password');
    String enteredPassword = _passwordController.text;
    if (savedPassword != null && enteredPassword == savedPassword) {
      var data = {
        'userName': mobileNumber,
        'password': enteredPassword,
      };
      print("<___________________Input Checking Password Api __________________________>");
      print(data);
      var response1 = await CallApi().postData("userLogin", data);
      var body = jsonDecode(response1.body);
      print("<___________________Output Checking Password Api __________________________>");
      if (body['success'] == true) {
        print(body);
        Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => const WelcomeScreen()));
      }
      // else {
      //   Navigator.push(context,
      //       MaterialPageRoute(builder: (ctx) => const  WrongPasswordScreen()));
      // }
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (ctx) => const  WrongPasswordScreen()));
    }
  }

  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;
  bool _obscureText = true;
  void _validateButton() {
    final password = _passwordController.text;
    setState(() {
      _isButtonEnabled = password.isNotEmpty;
    });
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
  void _login() {
    checkingPassword();
  }
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  // void _clearTextField() {
  //   _passwordController.clear();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Column(
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
            const Padding(padding: EdgeInsets.symmetric(horizontal: 50,vertical: 30)),
            Align(
              alignment: const Alignment(-0.7, 0.5),
              child: Text('Hi! $fullName',style: const TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Nunito'),),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
         Center(
            child: SizedBox(
                width: 300,
                height: 40,
                child: TextFormField(
                  controller: _passwordController,
                  obscuringCharacter: '*',
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                      labelText: 'Enter Password',
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                      border: OutlineInputBorder( borderRadius: BorderRadius.circular(8.0)
                      ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    labelStyle: const TextStyle(
                      fontFamily: 'Nunito',
                      // fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,

                    ),
                    hintStyle: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        // fontStyle: FontStyle.italic,
                        fontSize: 14
                    ),
                  ),
                  validator: _validatePassword,
                  onChanged: (text) {
                    _validateButton();
                  },
                ),
            ),
         ),
            const Padding(padding: EdgeInsets.only(top: 50)),
            SizedBox(
              width: 300,
              height: 40,
              child: Row(
                children: [
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
                      ),
                      child: Text("I'm not $fullName",style: const TextStyle(color: Color(0xFF8000FF),fontFamily: 'Nunito'),),
                    ),
                  ),
                const Spacer(),
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: _isButtonEnabled ? _login : null,
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
                      child: const Text('Login',style: TextStyle(fontFamily: 'Nunito'),),
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
                  style: TextStyle(fontSize: 14,color: Colors.black54,  fontFamily: 'Nunito', fontWeight: FontWeight.bold),
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
      ]
    ),
      ),
    );
  }
}