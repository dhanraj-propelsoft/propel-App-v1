import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:propel_login/WelcomScreen.dart';


class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
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

  void _login() {
    // Navigate to the next screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WelcomScreen()),
    );
    _clearTextField();
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

  void _clearTextField() {
    _passwordController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
            const Padding(padding: EdgeInsets.symmetric(horizontal: 50,vertical: 30)),
            const Align(
              alignment: Alignment(-0.7, 0.5),
              child: Text('Hi! Selvaraj',style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            const Padding(padding: EdgeInsets.only(top: 70)),
         Center(
            child: SizedBox(
                width: 300,
                // height: 40,
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
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      border: OutlineInputBorder( borderRadius: BorderRadius.circular(8.0))),
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
                    width: 130,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {},
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
                      child: const Text("I'm not Selvaraj",style: TextStyle(color: Colors.purple),),
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
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 50)),
            const SizedBox(
              width: 250,
              child: Text.rich(
                TextSpan(
                  text: "If you don't hold the above email/mobile , also if you are not holding any previous account Kindly contact ",
                  style: TextStyle(fontSize: 12,color: Colors.black54),
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
    );
  }
}