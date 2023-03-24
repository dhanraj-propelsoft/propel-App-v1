import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:propel_login/Api%20Connection/Api.dart';
import 'package:propel_login/EmailScreen.dart';
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
    });
  }
  Future<void> PhoneNumber(phoneNumber) async {
    var data = {
      'mobileNumber':phoneNumber,
    };

    print("<___________________Input mobile No Api __________________________>");
    print(data);
    var response1 = await CallApi().postData("findMobileNumber",data);
    var body  = jsonDecode(response1.body);

    print("<___________________Output mobile No Api __________________________>");
    print(body);
    if(body['success'] ==true){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('mobileNumber', phoneNumber);
      Navigator.push(context,
          MaterialPageRoute(builder: (ctx) => const EmailScreen()));
      _clearTextField();
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
          const Padding(padding: EdgeInsets.only(top: 100)),
          Center(
            child: SizedBox(
              width: 350,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    enabled: false,
                    prefix: const Text(
                      '+91',
                    ),
                    prefixIcon: const Icon(Icons.arrow_drop_down),
                    hintText: 'India',
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
              width: 350,
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
                        borderRadius: BorderRadius.circular(10.0))),
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
            padding: const EdgeInsets.only(left: 250.0),
            child: SizedBox(
              width: 100,
              height: 35,
              child: ElevatedButton(
                onPressed: _isButtonDisabled
                    ? null
                    : () => {
                  PhoneNumber(phoneNumber )
                          // _clearTextField(),
                          // setState(() {
                          //   _isButtonDisabled = true;
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context) => const EmailScreen()),
                          //   );
                          // }),
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
          const Padding(
              padding: EdgeInsets.only(
            top: 40,
          )),
          const Text(
            "Don't have a login yet.....!",
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(
            width: 400,
            child: Text(
              "Just enter your mobile number and follow us. We ensure your Signup for a New Account in few steps . ",
              style: TextStyle(color: Colors.black54),
            ),
          )
        ],
      ),
    );
  }
}
