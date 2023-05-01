import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
class PersonDataConfirmationScreen extends StatefulWidget {
  final List<Map<String, dynamic>>? personData;
  const PersonDataConfirmationScreen({Key? key, this.personData}) : super(key: key);

  @override
  State<PersonDataConfirmationScreen> createState() =>
      _PersonDataConfirmationScreenState();
}

class _PersonDataConfirmationScreenState
    extends State<PersonDataConfirmationScreen> {
  String personName = '';
  String mobileId = '';
  String hiddenmobileId = '';
  String emailId = '';
  String emailIdcaracter = '';

  @override
  void initState() {
    super.initState();
    getPersonData();
  }

  void getPersonData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List? personData = prefs.getStringList('personData')?.map((data) => json.decode(data)).toList();
    setState(() {
      personName = '${personData![0]['firstName']} ${personData[0]['middleName']}';
      mobileId = personData[0][mobileId];
      hiddenmobileId = "${mobileId.substring(0, 3)}*****";
      emailId = personData[0][emailId];
      emailIdcaracter = '${emailId.replaceRange(2, emailId.indexOf('@'), "*" * (emailId.indexOf('@') - 2))}@${emailId.substring(emailId.indexOf('@') + 1)}';
    });
  }
  // @override
  // void initState() {
  //   super.initState();
  //   getNames();
  // }
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
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
                    color: Color(0xFF9900FF),
                    fontFamily: 'Nunito',
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
      const Padding(
          padding: EdgeInsets.only(
        top: 20,
      )),
      const Center(
        child: SizedBox(
          width: 350,
          child: Text(
            'These record are found on our system against credentials By selecting one of them you ensure its your record.',
            style: TextStyle(
                fontSize: 14, fontFamily: 'Nunito', color: Colors.black),
          ),
        ),
      ),
      const Divider(endIndent: 40,indent:40),
        Container(
          alignment: Alignment.centerLeft,
          child: GFCheckboxListTile(
            title: Row(
              children: [
                const GFAvatar(
                  backgroundColor: Colors.purple,
                  child: Text(
                    'A',
                    style: TextStyle(color: Colors.white, fontFamily: 'Nunito'),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                       personName,
                      style: const TextStyle(fontSize: 15,fontFamily: 'Nunito',),
                    ),
                    const SizedBox(height: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(
                          hiddenmobileId,
                          style: const TextStyle(fontSize: 12,fontFamily: 'Nunito',),
                        ),
                         Text(
                           emailIdcaracter,
                          style: const TextStyle(fontSize: 12,fontFamily: 'Nunito',),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            size: 20,
            activeBgColor: Colors.green,
            type: GFCheckboxType.circle,
            activeIcon: const Icon(
              Icons.check,
              size: 15,
              color: Colors.white,
            ),
            onChanged: (value) {
              setState(() {
                isChecked = value;
              });
            },
            value: isChecked,
            inactiveIcon: null,
          ),
        ),
        const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isChecked ? showConfirmationDialog : null,
                child: const Text('Continue',style: TextStyle(fontFamily: 'Nunito')),
              ),
            ])));
  }
  Future<void> showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            title: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              padding: const EdgeInsets.all(10.0),
              child: const Center(
                child: Text(
                  'WARNING',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18.0,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children:  <Widget>[
                  SizedBox(
                    width: 280,
                    child:Column(
                      children: const [
                        Text('You are trying to access a Person DATA hence, if you the one who holds the mobile number and email kindly proceed'
                        ,style: TextStyle(fontFamily: 'Nunito')),
                  Text(
                      'Do you want to make the change ?',style: TextStyle(fontFamily: 'Nunito')),],
                    ) )
                ],
              ),
            ),
            actions: <Widget>[
              Row(children: [
                OutlinedButton(
                  child: const Text('Cancel',style: TextStyle(fontFamily: 'Nunito'),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Spacer(),
                OutlinedButton(
                  child: const Text('Continue',style: TextStyle(fontFamily: 'Nunito')),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],)
            ],
          ),
        );
      },
    );
  }

}
