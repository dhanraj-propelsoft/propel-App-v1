import 'dart:convert';
// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:propel_login/Api%20Connection/Api.dart';
import 'package:propel_login/NewAccount2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewAccount1Screen extends StatefulWidget {
  const NewAccount1Screen({Key? key}) : super(key: key);

  @override
  State<NewAccount1Screen> createState() => _NewAccount1ScreenState();
}

class _NewAccount1ScreenState extends State<NewAccount1Screen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();
// String? salutationController;
  String? salutationController = 'Salutation';
  Map<String, String> salutationMap = {
    'Salutation': 'Salutation',
    'Mr.': '1',
    'Mrs.': '2',
    'Ms.': '3',
    'Dr.': '4',
  };
get salutation => salutationController;
get firstName => firstNameController.text;
get middleName => middleNameController.text;
get lastName => lastNameController.text;
get nickName => nickNameController.text;
Future<void> stage1(tempId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('tempModel', tempId);
  await stage2();
}
var msg='load data failed';
Future<void> stage2() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int id = prefs.getInt("tempModel") ?? 0;
  String? mobile_no = prefs.getString('mobileNumber');
  await prefs.setString( 'salutation', salutationController!);
  await prefs.setString( 'firstName', firstName);
  await prefs.setString( 'middleName', middleName);
  await prefs.setString( 'lastName', lastName);
  await prefs.setString( 'nickName', nickName);
  var data = {
    'stage': '2',
    'tempModel': id,
    'salutation': salutationController,
    'firstName' : firstName,
    'middleName' : middleName,
    'lastName': lastName,
    'nickName': nickName,
    'mobileNumber': mobile_no,
  };
  print("<___________________Input Create New Account Page1 Api __________________________>");
  var res = await CallApi().postData('storeTempPerson', data);
  var body = json.decode(res.body);
  print("<___________________Output Create New Account 1 Api __________________________>");
  print(body);
  if(body['success'] ==true) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const NewAccount2Screen()),
    );
  }else{
    print(msg);
  }
  print(body['success']);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
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
                      fontFamily: '',
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
                const Padding(padding: EdgeInsets.only(top: 40,)),
                Container(
                  alignment: const Alignment(-0.7, 0.5),
                  child:  const Text('Create New Account',style: TextStyle(fontSize: 14),),
                ),
                const Padding(padding: EdgeInsets.only(top: 40)),
                Center(
                    child: Container(
                      width: 300,
                      height: 40,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: DropdownButton<String>(
                        value: salutationController,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down, size: 22),
                        underline: const SizedBox(),
                        items: salutationMap.keys.map((String key) {
                          return DropdownMenuItem<String>(
                            value: salutationMap[key],
                            child: Text(key),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            salutationController = value;
                          });
                        },
                      ),
                      // DropdownButtonFormField<String>(
                      //   decoration: InputDecoration(
                      //     labelText: 'Saludation',
                      //     border: OutlineInputBorder(),
                      //   ),
                      //   value: salutationController,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       salutationController = value;
                      //     });
                      //   },
                      //     items: _dropdownValues.map((Map<String, dynamic> item) {
                      //     return DropdownMenuItem<String>(
                      //       value: item['value'],
                      //       child: Text(item['key']),
                      //     );
                      //   }).toList(),
                      // ),
                      //
                      // DropdownButton<String>(
                      //   // decoration: const InputDecoration(
                      //   //   labelText: 'Salutation',
                      //   //   border: OutlineInputBorder(),
                      //   // ),
                      //   value: salutationController,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       salutationController = value;
                      //     });
                      //   },
                     //   underline: const SizedBox(),
                      //   items: _dropdownValues.map((Map<String, dynamic> item) {
                      //     return DropdownMenuItem<String>(
                      //       value: item['value'],
                      //       child: Text(item['key']),
                      //     );
                      //   }).toList(),
                      // ),
                    )
                ),
                const Padding(padding: EdgeInsets.only(top: 30,)),
                Center(
                  child: SizedBox(
                    width: 300,
                    height: 40,
                    child: TextFormField(
                      controller: firstNameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder( borderRadius: BorderRadius.circular(8.0))),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 30,)),
                Center(
                  child: SizedBox(
                    width: 300,
                    height: 40,
                    child: TextFormField(
                      controller: middleNameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: 'Middle Name',
                          border: OutlineInputBorder( borderRadius: BorderRadius.circular(8.0))),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 30,)),
                Center(
                  child: SizedBox(
                    width: 300,
                    height: 40,
                    child: TextFormField(
                      controller: lastNameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: 'Last Name or Initial ',
                          border: OutlineInputBorder( borderRadius: BorderRadius.circular(8.0))),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 30,)),
                Center(
                  child: SizedBox(
                    width: 300,
                    height: 40,
                    child: TextFormField(
                      controller: nickNameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: 'Nick Name or Alias',
                          border: OutlineInputBorder( borderRadius: BorderRadius.circular(8.0))),
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
                          stage2();
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
