import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:propel_login/Exact%20PersonData%20Screen2.dart';

class ExactPersonScreen1 extends StatefulWidget {
  const ExactPersonScreen1({Key? key, required this.personData}) : super(key: key);

  final Map<String, dynamic> personData;
  @override
  _ExactPersonScreen1State createState() => _ExactPersonScreen1State();
}

class _ExactPersonScreen1State extends State<ExactPersonScreen1> {
  String? salutationController = 'Salutation';
  Map<String, String> salutationMap = {
    'Salutation': 'Salutation',
    'Mr.': '1',
    'Mrs.': '2',
    'Ms.': '3',
    'Dr.': '4',
  };
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
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0)
                ),
                child: DropdownButton<String>(
                  value: salutationController ?? salutationMap.keys.first,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down, size: 22),
                  underline: const SizedBox(),
                  items: salutationMap.keys.map((String key) {
                    return DropdownMenuItem<String>(
                      value: salutationMap[key],
                      child: Text(key, style: const TextStyle(fontFamily: 'Nunito'),),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      salutationController = value;
                    });
                  },
                ),
              )
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
                initialValue: '${widget.personData['first_name']}',
                style: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder( borderRadius: BorderRadius.circular(8.0)
                  ),
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
                initialValue: '${widget.personData['middle_name']}',
                style: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Middle Name',
                  border: OutlineInputBorder( borderRadius: BorderRadius.circular(8.0)
                  ),
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
                initialValue: '${widget.personData['last_name']}',
                style: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder( borderRadius: BorderRadius.circular(8.0)
                  ),
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
                initialValue: '${widget.personData['nick_name']}',
                style: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Nick Name or Alias',
                  border: OutlineInputBorder( borderRadius: BorderRadius.circular(8.0)
                  ),
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
// const Padding(padding: EdgeInsets.only(top: 60)),
//           Center(
//             child: Container(
//               width: 350,
//               height: 40,
//               decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.black, //color of border
//                     width: 1, //width of border
//                   ),
//                   borderRadius: BorderRadius.circular(5)),
//               padding: const EdgeInsets.only(left: 10),
//               child:  TextFormField(
//                 initialValue: '${widget.personData['nick_name']}',
//                 style: TextStyle(fontSize: 16, fontFamily: 'Nunito'),
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintText: 'Enter new nick name',
//                   hintStyle: TextStyle(color: Colors.grey),
//                 ),
//                 onChanged: (value) {
//                   // Save the updated nick name to a variable or update the widget state.
//                 },
//               ),
//             ),
//           ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExactPersonScreen2(personData: widget.personData),
                      ),
                    );                  },
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
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
                    overlayColor: MaterialStateProperty.all<Color>(
                        Colors.purple.withOpacity(0.1)),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.purple,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}


