import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:propel_login/Api%20Connection/Api.dart';
import 'package:propel_login/OTP%20Validation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewAccount2Screen extends StatefulWidget {
  const NewAccount2Screen({Key? key}) : super(key: key);

  @override
  State<NewAccount2Screen> createState() => _NewAccount2ScreenState();
}

class _NewAccount2ScreenState extends State<NewAccount2Screen> {
  String? bloodGroupController = 'Blood Group';
  Map<String, String> bloodGroupMap = {
    'Blood Group': 'Blood Group',
    'A+': '1',
    'A-.': '2',
    'B+': '3',
    'B-': '4',
    'O+': '5',
    'O-': '6',
    'AB+': '7',
    'AB-': '8',
  };

  String? genderValueController = 'Gender';
  Map<String, String> genderMap = {
    'Gender': 'Gender',
    'Male': '1',
    'Female': '2',
    'Others': '3',
  };
  DateTime? _selectedDate;
  get bloodGroup => bloodGroupController;
  get gender => genderValueController;
  get dob => _controller;
  final _controller = TextEditingController();
  Future<void> stage1(tempId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('tempModel', tempId);
    await stage3();
  }
  Future<void> stage3() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int id = prefs.getInt("tempModel") ?? 0;
    await prefs.setString( 'bloodGroup', bloodGroupController!);
    await prefs.setString( 'gender', genderValueController!);
    await prefs.setString( 'dob', _controller.text);
    var data = {
      'stage': '3',
      'tempId': id,
      'bloodGroup': bloodGroupController,
      'gender' : genderValueController,
      'dob': _controller.text
    };
    print("<___________________Input Create New Account Page2 Api __________________________>");
    var res = await CallApi().postData('storeTempPerson', data);
    var body = json.decode(res.body);
    print("<___________________output Create New Account 2 Api __________________________>");
    print(body);
    if(body['success'] ==true) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>  OtpValidationScreen()),
      );
    }else{
      print('no loaded');
    }
  }



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: Center(
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
              const Padding(padding: EdgeInsets.only(top: 70)),
              Center(
                  child: Container(
                    width: 350,
                    height: 40,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: DropdownButton<String>(
                      value: genderValueController,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down, size: 22),
                      underline: const SizedBox(),
                      items: genderMap.keys.map((String key) {
                        return DropdownMenuItem<String>(
                          value: genderMap[key],
                          child: Text(key),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          genderValueController = value;
                        });
                      },
                    ),
                  )
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              Center(
                  child: Container(
                    width: 350,
                    height: 40,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: DropdownButton<String>(
                      value: bloodGroupController,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down, size: 22),
                      underline: const SizedBox(),
                      items: bloodGroupMap.keys.map((String key) {
                        return DropdownMenuItem<String>(
                          value: bloodGroupMap[key],
                          child: Text(key),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          bloodGroupController = value;
                        });
                      },
                    ),
                  )
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              Center(
                  child: SizedBox(
                    width: 350,
                    height: 40,
                   child:  TextField(
                     controller: _controller,
                     readOnly: true,
                     decoration:  InputDecoration(
                       labelText: 'DOB',
                       border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(8.0)
                       ),
                     ),
                     onTap: () async {
                       FocusScope.of(context).requestFocus(FocusNode());
                       final DateTime? picked = await showDatePicker(
                         context: context,
                         initialDate: _selectedDate ?? DateTime.now(),
                         firstDate: DateTime(1900),
                         lastDate: DateTime.now(),
                       );
                       if (picked != null && picked != _selectedDate) {
                         setState(() {
                           _selectedDate = picked;
                           _controller.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
                         });
                       }
                     },
                   )
                  ),
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              Padding(
                padding: const EdgeInsets.only(left: 250.0),
                child: SizedBox(
                  width: 100,
                  height: 35,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: ElevatedButton(
                      onPressed: () {
                        stage3();
                      //   Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const WelcomScreen()),
                      // );
                        },
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
                        overlayColor: MaterialStateProperty.all<Color>(Colors.purple.withOpacity(0.1)),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
                  ),
                ),
                ),
            ]
        ),
      ),
    );
  }
}
