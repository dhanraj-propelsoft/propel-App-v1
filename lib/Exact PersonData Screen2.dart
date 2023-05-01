import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExactPersonScreen2 extends StatefulWidget {
  const ExactPersonScreen2({Key? key, required this.personData}) : super(key: key);

  final Map<String, dynamic> personData;

  @override
  _ExactPersonScreen2State createState() => _ExactPersonScreen2State();
}

class _ExactPersonScreen2State extends State<ExactPersonScreen2> {
  // String? genderValueController = 'Gender';
  Map<String, String> genderMap = {
    'Gender': '',
    'Male': '1',
    'Female': '2',
    'Others': '3',
  };

  String? genderValueController;

  @override
  void initState() {
    super.initState();
    genderValueController = genderMap[widget.personData['gender_id'].toString()];
  }


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
              const Padding(padding: EdgeInsets.only(top: 40)),
          // Center(
          //   child: Container(
          //     width: 300,
          //     height: 40,
          //     padding: const EdgeInsets.only(left: 10, right: 10),
          //     decoration: BoxDecoration(
          //       border: Border.all(color: Colors.grey),
          //       borderRadius: BorderRadius.circular(8.0),
          //     ),
          //     child: DropdownButton<String>(
          //       value: genderValueController ?? widget.personData['gender_id'].toString(),
          //       isExpanded: true,
          //       icon: const Icon(Icons.keyboard_arrow_down, size: 22),
          //       underline: const SizedBox(),
          //       items: genderMap.keys.map((String key) {
          //         return DropdownMenuItem<String>(
          //           value: genderMap[key],
          //           child: Text(key, style: TextStyle(fontFamily: 'Nunito')),
          //         );
          //       }).toList(),
          //       onChanged: (value) {
          //         setState(() {
          //           genderValueController = value;
          //         });
          //       },
          //     ),
          //   ),
          // ),

              Center(
                child: Container(
                  width: 300,
                  height: 40,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: DropdownButton<String>(
                    value: genderValueController,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down, size: 22),
                    underline: const SizedBox(),
                    items: genderMap.keys.map((String key) {
                      return DropdownMenuItem<String>(
                        value: genderMap[key],
                        child: Text(key, style: TextStyle(fontFamily: 'Nunito')),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        genderValueController = value;
                      });
                    },
                  ),
                ),
              ),
        const Padding(padding: EdgeInsets.only(top: 40)),
              Center(
                child: Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, //color of border
                        width: 1, //width of border
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.only(left: 10),
                  child:  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${widget.personData['blood_group_id']}',
                      style: TextStyle(fontSize: 16, fontFamily: 'Nunito'),
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              Center(
                child: Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, //color of border
                        width: 1, //width of border
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.only(left: 10),
                  child:  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${widget.personData['dob']}',
                      style: TextStyle(fontSize: 16, fontFamily: 'Nunito'),
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
                        // stage3();
                        //   Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const WelcomScreen()),
                        // );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.white),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(
                              color: Colors.purple,
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
                        style: TextStyle(color: Colors.purple,
                          fontFamily: 'Nunito',),
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