import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:propel_login/Api%20Connection/Api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CreateAccountSuccessfullScreen.dart';

class NewPasswordCreateScreen extends StatefulWidget {
  const NewPasswordCreateScreen({Key? key}) : super(key: key);

  @override
  State<NewPasswordCreateScreen> createState() => _NewPasswordCreateScreenState();
}

class _NewPasswordCreateScreenState extends State<NewPasswordCreateScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final StreamController<bool> _buttonController = StreamController<bool>();
  bool _isButtonEnabled = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  get password => _passwordController.text;
  get confirmPassword => _confirmPasswordController.text;
  Future<void> otpValidation(uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', uid);
    await newCreatePassword();
  }
  Future<void> newCreatePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("data") ?? '';
    await prefs.setString( 'password', password);
    await prefs.setString( 'passwordConfirmation', confirmPassword);
    var data = {
      'uid': uid,
      'password': password,
      'passwordConfirmation': confirmPassword,
    };
    print("<___________________Input CreatePassword Api __________________________>");
    // print(data);
    var res = await CallApi().postData('changePassword', data);
    var body = json.decode(res.body);
    print("<___________________Output CreatePassword Api __________________________>");
    print(body);
    if(body['success'] ==true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('password', password);
      await prefs.setString( 'passwordConfirmation', confirmPassword);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>  const SuccessScreen()),
      );
    }else{
      print("failed");
    }
  }

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_onPasswordChanged);
    _confirmPasswordController.addListener(_onConfirmPasswordChanged);
    _buttonController.add(_isButtonEnabled);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _buttonController.close();
    super.dispose();
  }

  void _onPasswordChanged() {
    setState(() {
      _isButtonEnabled = _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          _passwordController.text == _confirmPasswordController.text;
    });
    _buttonController.add(_isButtonEnabled);
  }

  void _onConfirmPasswordChanged() {
    setState(() {
      _isButtonEnabled = _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          _passwordController.text == _confirmPasswordController.text;
    });
    if (_isButtonEnabled) {
      _buttonController.add(true);
    } else {
      _buttonController.addError('Passwords do not match.');
    }
  }


  void _onSubmit() {
    newCreatePassword();
  }

  // void _togglePasswordVisibility() {
  //   setState(() {
  //     _isPasswordVisible = !_isPasswordVisible;
  //   });
  // }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          SizedBox(
            width: 350,
            height: 40,
            child: TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter new Password',
                labelStyle:  TextStyle(
                  fontFamily: 'Nunito',
                  // fontStyle: FontStyle.italic,
                  // fontWeight: FontWeight.bold,

                ),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          SizedBox(
            width: 350,
            height: 40,
            child: TextField(
              controller: _confirmPasswordController,
              obscureText: !_isConfirmPasswordVisible,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Confirm Password',
                labelStyle: const TextStyle(
                  fontFamily: 'Nunito',
                  // fontStyle: FontStyle.italic,
                  // fontWeight: FontWeight.bold,

                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: _toggleConfirmPasswordVisibility,
                ),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 50)),
          StreamBuilder<bool>(
            stream: _buttonController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(
                  snapshot.error.toString(),
                  style: const TextStyle(color: Colors.red),
                );
              }
              return ElevatedButton(
                onPressed: snapshot.data ?? false ? _onSubmit : null,
                child: const Text('Submit',style: TextStyle(fontFamily: 'Nunito'),),
              );
            },
          ),
        ],
      ),
    );
  }
}
