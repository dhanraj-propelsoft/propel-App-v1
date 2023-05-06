import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:propel_login/PhoneNumScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {

  String fullName = '';

  String firstName = '';
  String middleName = '';
  String lastName = '';

  void getNames() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? first = prefs.getString('firstName');
    String? middle = prefs.getString('middleName');
    String? last = prefs.getString('lastName');

    setState(() {
      firstName = first ?? '';
      middleName = middle ?? '';
      lastName = last ?? '';
      fullName = '$firstName${middleName.isNotEmpty?'$middleName ' : ''}$lastName';
    });
  }

  @override
  void initState() {
    super.initState();
    getNames();

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
              child: Text( 'Hi! $fullName',style: const TextStyle(fontSize: 16, fontFamily: 'Nunito')),
            ),
            const Padding(padding: EdgeInsets.only(top: 50)),
            const Center(
              child: SizedBox(
                width: 300,
              child: Text(
                'Your Account has been created successfully, Kindly Login again using last generated password',
                style: TextStyle(fontSize: 15,fontFamily: 'Nunito'),
              ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 50)),
      Padding(
        padding: const EdgeInsets.only(left: 250.0),
         child: SizedBox(
          width: 100,
          height: 35,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF9900FF)),
              ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  const LoginScreen()),
                  );
                },
                child: const Text('Submit',style: TextStyle(fontFamily: 'Nunito'),))
            ),
           ),
          ],
        ),
      ),
    );
  }
}
