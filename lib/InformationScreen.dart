import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'Identity ConfirmationPage.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
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
        const Center(
          child: SizedBox(
            width: 300,
            child:  Text('No user information was found on our system,',style: TextStyle( fontFamily: 'Nunito',fontSize: 14)),
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 30)),
        const Center(
          child: SizedBox(
            width: 300,
            child:  Text('To continue further kindly signup for a new account by filling the following details',
              style: TextStyle( fontFamily: 'Nunito',fontSize: 14)),
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 30)),
        const Center(
          child:  SizedBox(
            width: 300,
            child: Text('Its our pleasure to have you as an user',style: TextStyle( fontFamily: 'Nunito',fontSize: 14)),
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 50)),
        SizedBox(
          width: 300,
          height: 40,
          child: Row(
            children: [
              SizedBox(
                width: 100,
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
                  child: const Text('Cancel',style: TextStyle(color: Colors.purple,fontFamily: 'Nunito'),),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 100,
                height: 30,
                child:MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: ElevatedButton(
                    onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PDCScreen()),
                    );},
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
                      'Continue',
                      style: TextStyle(color: Colors.purple,fontFamily: 'Nunito',),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    ));
  }
}
