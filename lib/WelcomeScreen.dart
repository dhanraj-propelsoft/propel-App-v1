import 'dart:async';

import 'package:flutter/material.dart';
import 'package:propel_login/PhoneNumScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? _salutation;

  //
  Future<void> _loadSalutation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String salutation = prefs.getString('salutation') ?? '';

    if (salutation == '1') {
      setState(() {
        _salutation = 'Mr';
      });
    } else if (salutation == '2') {
      setState(() {
        _salutation = 'Mrs';
      });
    } else if (salutation == '3') {
      setState(() {
        _salutation = 'Mis';
      });
    }  else if (salutation == '4') {
      setState(() {
        _salutation = 'Dr';
      });
    }else {
      setState(() {
        _salutation = '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getNames();
    _loadSalutation();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            const Center(
             child: Text("Propel soft Welcomes You",
               style: TextStyle(color: Color(0xFF9900FF),fontFamily: 'Nunito',fontSize: 18, fontStyle: FontStyle.italic,),
        ),
        ),
        const Padding(padding: EdgeInsets.only(top: 30)),
        Center(
          child: Text("$_salutation.$fullName !",style: const TextStyle(color: Color(0xFF9900FF),fontFamily: 'Nunito',fontSize: 24, fontStyle: FontStyle.italic,),
        ),
        ),
      ]),
    );
  }
}
