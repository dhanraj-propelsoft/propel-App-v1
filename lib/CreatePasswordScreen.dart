import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:propel_login/Api%20Connection/Api.dart';
import 'package:propel_login/CreateAccountSuccessfullScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordCreationScreen extends StatefulWidget {
  const PasswordCreationScreen({Key? key}) : super(key: key);

  @override
  _PasswordCreationScreenState createState() => _PasswordCreationScreenState();
}

class _PasswordCreationScreenState extends State<PasswordCreationScreen> {
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
    await createPassword(password);
  }
  Future<void> createPassword(password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("data") ?? '';
    await prefs.setString( 'password', password);
    await prefs.setString( 'passwordConfirmation', confirmPassword);
    var data = {
      'uId': uid,
      'password': password,
      'passwordConfirmation': confirmPassword,
    };
    print("<___________________Input CreatePassword Api __________________________>");
    // print(data);
    var res = await CallApi().postData('storeUser', data);
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
    createPassword(password);
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
          const Padding(padding: EdgeInsets.only(top: 50)),
            SizedBox(
              width: 300,
              height: 40,
            child: TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration:  InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                labelText: 'Enter new Password',
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                labelStyle:  const TextStyle(
                  fontFamily: 'Nunito',
                  // fontStyle: FontStyle.italic,
                  // fontWeight: FontWeight.bold,

                ),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          SizedBox(
            width: 300,
            height: 40,
            child: TextField(
              controller: _confirmPasswordController,
              obscureText: !_isConfirmPasswordVisible,
              decoration: InputDecoration(
                border:  OutlineInputBorder(  borderRadius: BorderRadius.circular(8.0)),
                labelText: 'Retype Password for Confirmation',
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
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
                // style: ButtonStyle(
                //   backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF9900FF)),
                // ),
                onPressed: snapshot.data ?? false ? _onSubmit : null,
                child: const Text('Sign up',style: TextStyle(fontFamily: 'Nunito',color: Color(0xFF8000FF)),),
              );
            },
          ),
          const Padding(padding: EdgeInsets.only(top: 50)),
          SizedBox(
             width: 300,
            child: RichText(
            text: const TextSpan(
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Nunito',
                fontSize: 14,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'By clicking sign up, you agree to our ',style: TextStyle(fontFamily: 'Nunito'),
                ),
                TextSpan(
                  text: 'Term , Data Policy',
                  style: TextStyle(
                    color: Colors.blue,
                    fontFamily: 'Nunito',
                  ),
                ),
                TextSpan(
                  text: ' and ',style: TextStyle(fontFamily: 'Nunito'),
                ),
                TextSpan(
                  text: 'Cookie Policy',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Colors.blue,
                  ),
                ),
                TextSpan(
                  text: '. Also, you agree to receive SMS and email notifications from us.',style: TextStyle(fontFamily: 'Nunito'),
                ),
              ],
            ),
          ),
          ),
        ],
      ),
      ),
    );
  }
}
