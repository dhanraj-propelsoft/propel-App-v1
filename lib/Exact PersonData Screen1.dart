import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:propel_login/Api%20Connection/Api.dart';
import 'package:propel_login/Exact%20PersonData%20Screen2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExactPersonScreen1 extends StatefulWidget {
  const ExactPersonScreen1({Key? key, required this.personData}) : super(key: key);

  final Map<String, dynamic> personData;
  @override
  _ExactPersonScreen1State createState() => _ExactPersonScreen1State();
}

class _ExactPersonScreen1State extends State<ExactPersonScreen1> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();
  Map<String, String> salutationMap = {
    'Mr.': 'Mr.',
    'Mrs.': 'Mrs.',
    'Ms.': 'Ms.',
    'Dr.': 'Dr.',
  };
  // String? salutationValueController = 'Salutation';
  late String salutationValueController;
  late String _salutation;

  String get salutation => _salutation;
  String get firstName => firstNameController.text;
  String get middleName => middleNameController.text;
  String get lastName => lastNameController.text;
  String get nickName => nickNameController.text;

  @override
  void initState() {
    super.initState();
    if (widget.personData['salutation_id'] == 1) {
      _salutation = 'Mr.';
    } else if (widget.personData['salutation_id'] == 2) {
      _salutation = 'Mrs.';
    } else if (widget.personData['salutation_id'] == 3) {
      _salutation = 'Ms.';
    } else if (widget.personData['salutation_id'] == 4) {
      _salutation = 'Dr.';
    } else {
      _salutation = 'Salutation';
    }
    salutationValueController = _salutation;
  }
  // Future<void> personUpdate1() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? uid = prefs.getString("data");
  //   await prefs.setString( 'salutation', salutationValueController);
  //   await prefs.setString( 'firstName', firstName);
  //   await prefs.setString( 'middleName', middleName);
  //   await prefs.setString( 'lastName', lastName);
  //   await prefs.setString( 'nickName', nickName);
  //   var data = {
  //      'uid': uid,
  //     'salutation': salutationValueController,
  //     'firstName' : firstNameController.text,
  //     'middleName' : middleNameController.text,
  //     'lastName': lastNameController.text,
  //     'nickName': nickNameController.text,
  //   };
  //   print("<___________________Input personUpdate1 Api __________________________>");
  //   var res = await CallApi().postData('personUpdate', data);
  //   var body = json.decode(res.body);
  //   print("<___________________Output personUpdate1 Api __________________________>");
  //   print(body);
  //   if(body['success'] ==true) {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setString( 'salutation', salutationValueController);
  //     await prefs.setString( 'firstName', firstNameController.text);
  //     await prefs.setString( 'middleName', middleNameController.text);
  //     await prefs.setString( 'lastName', lastNameController.text);
  //     await prefs.setString( 'nickName', nickNameController.text);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => ExactPersonScreen2(personData: widget.personData),
  //       ),
  //     );
  //   }else{
  //     print('failed');
  //   }
  //   print(body['success']);
  // }
  Future<void> personUpdate1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString("data");
    String? firstName = prefs.getString("personData");
    // await prefs.getString('personData', first_name);
    int salutationId = 0;
    if (salutationValueController == 'Mr.') {
      salutationId = 1;
    } else if (salutationValueController == 'Mrs.') {
      salutationId = 2;
    } else if (salutationValueController == 'Ms.') {
      salutationId = 3;
    } else if (salutationValueController == 'Dr.') {
      salutationId = 4;
    }
    firstNameController.text = widget.personData['first_name'];
    if (firstNameController.text.isEmpty) {
      print('First name is required.');
      // You can display an error message or perform any other action here
      return;

    }

    await prefs.setInt('salutation_id', salutationId);
    await prefs.setString('firstName', firstNameController.text);
    await prefs.setString('middleName', middleNameController.text);
    await prefs.setString('lastName', lastNameController.text);
    await prefs.setString('nickName', nickNameController.text);

    var data = {
      'uid': uid,
      'salutation_id': salutationId,
      'firstName' : firstName,
      'middleName' : middleName,
      'lastName': lastName,
      'nickName': nickName,
    };

    print("<___________________Input personUpdate1 Api __________________________>");
    var res = await CallApi().postData('personUpdate', data);
    var body = json.decode(res.body);
    print("<___________________Output personUpdate1 Api __________________________>");
    print(body);

    if (body.containsKey('salutation')) {
      var salutationValue = body['salutation'];
      // Use the salutationValue as needed
    } else {
      // Handle the case when the property doesn't exist
    }

    if (body['success'] == true) {
      // Update personData
      widget.personData['salutation'] = salutationValueController;
      widget.personData['firstName'] = firstNameController.text;
      widget.personData['middleName'] = middleNameController.text;
      widget.personData['lastName'] = lastNameController.text;
      widget.personData['nickName'] = nickNameController.text;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('salutation', salutationValueController);
      await prefs.setString('firstName', firstNameController.text);
      await prefs.setString('middleName', middleNameController.text);
      await prefs.setString('lastName', lastNameController.text);
      await prefs.setString('nickName', nickNameController.text);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExactPersonScreen2(personData: widget.personData),
        ),
      );
    } else {
      print('failed');
    }
    print(body['success']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
        child: Column(children: [
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
                        color: Color(0xFF8000FF),
                        fontFamily: 'Nunito',
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
          const Padding(
              padding: EdgeInsets.only(
                top: 40,
              )),
          Container(
            alignment: const Alignment(-0.7, 0.5),
            child: const Text(
              'Create New Account',
              style: TextStyle(fontSize: 14, fontFamily: 'Nunito'),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 40)),
          Center(
            child: Container(
              width: 300,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              padding: const EdgeInsets.only(left: 10),
              child:  DropdownButton<String>(
                value: salutationValueController,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down, size: 22),
                underline:  Container(),
                onChanged: (String? newValue) {
                  setState(() {
                    salutationValueController = newValue!;
                  });
                },
                items: salutationMap.entries.map((MapEntry<String, String> entry) {
                  return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(entry.value),
                  );
                }).toList(),
              ),
            ),
          ),
          const Padding(
              padding: EdgeInsets.only(
                top: 30,
              )),
          Center(
            child: SizedBox(
              width: 300,
              height: 40,
              child: TextFormField(
                controller: TextEditingController(text: '${widget.personData['first_name']}'),
                // initialValue: '${widget.personData['first_name']}',
                style: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  labelStyle: const TextStyle(
                    fontFamily: 'Nunito',
                    color: Color(0xFF9900FF),
                    // fontStyle: FontStyle.italic,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          Center(
            child: SizedBox(
              width: 300,
              height: 40,
              child: TextFormField(
                controller: TextEditingController(text: '${widget.personData['middle_name']}'),
                // initialValue: '${widget.personData['middle_name']}',
                style: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Middle Name',
                  border: OutlineInputBorder( borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.black87)
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  labelStyle: const TextStyle(
                    fontFamily: 'Nunito',
                    color: Color(0xFF9900FF),
                    // fontStyle: FontStyle.italic,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          Center(
            child: SizedBox(
              width: 300,
              height: 40,
              child: TextFormField(
                controller: TextEditingController(text: '${widget.personData['last_name']}'),
                // initialValue: '${widget.personData['last_name']}',
                style: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder( borderRadius: BorderRadius.circular(8.0)
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  labelStyle: const TextStyle(
                    fontFamily: 'Nunito',
                    color: Color(0xFF9900FF),
                    // fontStyle: FontStyle.italic,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const Padding(
              padding: EdgeInsets.only(
                top: 30,
              )),
          Center(
            child: SizedBox(
              width: 300,
              height: 40,
              child: TextFormField(
                controller: TextEditingController(text: '${widget.personData['nick_name']}'),
                // initialValue: '${widget.personData['nick_name']}',
                style: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Nick Name or Alias',
                  border: OutlineInputBorder( borderRadius: BorderRadius.circular(8.0)
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  labelStyle: const TextStyle(
                      fontFamily: 'Nunito',
                    color: Color(0xFF9900FF),
                    // fontStyle: FontStyle.italic,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
                    personUpdate1();
                    },
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
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
                    overlayColor: MaterialStateProperty.all<Color>(
                        Colors.purple.withOpacity(0.1)),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: Color(0xFF9900FF),
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
      ),
    );
  }
}


