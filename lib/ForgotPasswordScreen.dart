import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'PasswordScreen.dart';
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Center(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 30)),
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                children: [
                  const SizedBox(
                    width: 150,
                    height: 50,
                  ),
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
            const Padding(padding: EdgeInsets.symmetric(horizontal: 50,vertical: 30)),
            const Align(
              alignment: Alignment(-0.7, 0.5),
              child: Text('Hi! Selvaraj',style: TextStyle(fontWeight: FontWeight.bold),),
            ),
           const Padding(padding: EdgeInsets.only(top: 50)),
             const Center(
               child:
             SizedBox(
               width: 360,
               child: Text('Hope you bad entered wrong Password you can try again or else Reset through Forgot Password',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14), ),
              ),
             ),
            const Padding(padding: EdgeInsets.only(top: 50)),
            SizedBox(
              width: 300,
              height: 40,
              child: Row(
                children: [
                  SizedBox(
                    width: 150,
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
                      child: const Text("Forgot Password",style: TextStyle(color: Colors.purple),),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PasswordScreen()),
                        );
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
                      ),
                      child: const Text('Try Again',style: TextStyle(color: Colors.purple)),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 50)),
            const SizedBox(
              width: 250,
              child: Text.rich(
                TextSpan(
                  text: "If you don't hold the above email/mobile , also if you are not holding any previous account Kindly contact ",
                  style: TextStyle(fontSize: 12,color: Colors.black54),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Propelsoft',
                      style: TextStyle(
                          color: Color(0xFF9900FF),
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
