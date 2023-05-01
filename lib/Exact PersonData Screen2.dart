import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ExactPersonScreen2 extends StatefulWidget {
  const ExactPersonScreen2({Key? key, required this.personData}) : super(key: key);

  final Map<String, dynamic> personData;

  @override
  _ExactPersonScreen2State createState() => _ExactPersonScreen2State();
}

class _ExactPersonScreen2State extends State<ExactPersonScreen2> {
  Map<String, String> genderMap = {
    'Male': 'Male',
    'Female': 'Female',
    'Other': 'Other',
  };
  Map<String, String> bloodGroupMap = {
    'A+': 'A+',
    'A-': 'A-',
    'B+': 'B+',
    'B-': 'B-',
    'O+': 'O+',
    'O-':  'O-',
  'AB+': 'AB+',
  'AB-': 'AB-',
  };
  late String gender;
  late String bloodGroup;
  late String genderValueController;
  late String bloodGroupValueController;

  @override
  void initState() {
    super.initState();
    if (widget.personData['gender_id'] == 1) {
      gender = 'Male';
    } else if (widget.personData['gender_id'] == 2) {
      gender = 'Female';
    } else if (widget.personData['gender_id'] == 3) {
      gender = 'Others';
    } else {
      gender = 'Unknown';
    }
    genderValueController = gender;

    if (widget.personData['blood_group_id'] == 1) {
      bloodGroup = 'A+';
    } else if (widget.personData['blood_group_id'] == 2) {
      bloodGroup = 'A-';
    } else if (widget.personData['blood_group_id'] == 3) {
      bloodGroup = 'B+';
    } else if (widget.personData['blood_group_id'] == 4) {
      bloodGroup = 'B-';
    } else if (widget.personData['blood_group_id'] == 5) {
      bloodGroup = 'O+';
    }  else if (widget.personData['blood_group_id'] == 6) {
      bloodGroup = 'O-';
    }  else if (widget.personData['blood_group_id'] == 7) {
      bloodGroup = 'AB+';
    }  else if (widget.personData['blood_group_id'] == 8) {
      bloodGroup = 'AB-';
    } else {
      bloodGroup = 'Unknown';
    }
    bloodGroupValueController = bloodGroup;
    _dobController = TextEditingController(
      text: widget.personData['dob'],
    );
  }
  late final TextEditingController _dobController;

  // @override
  // void initState() {
  //   super.initState();
  //
  // }

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _dobController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
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
              Center(
                child: Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: Colors.black,
                    //   width: 1,
                    // ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.only(left: 10),
                  child: DropdownButton<String>(
                    value: genderValueController,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down, size: 22),
                    underline: const SizedBox(),
                    items: genderMap.keys.map((String key) {
                      return DropdownMenuItem<String>(
                        value: genderMap[key],
                        child: Text(
                          key,
                          style: const TextStyle(fontFamily: 'Nunito'),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        genderValueController = value!;
                        gender = genderMap[value]!;
                      });
                    },
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              Center(
                child: Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: Colors.black,
                    //   width: 1,
                    // ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.only(left: 10),
                  child: DropdownButton<String>(
                    value: bloodGroupValueController,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down, size: 22),
                    underline: const SizedBox(),
                    items: bloodGroupMap.keys.map((String key) {
                      return DropdownMenuItem<String>(
                        value: bloodGroupMap[key],
                        child: Text(
                          key,
                          style: const TextStyle(fontFamily: 'Nunito'),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        bloodGroupValueController = value!;
                        bloodGroup = bloodGroupMap[value]!; // update `bloodGroup` variable based on selected option
                      });
                    },
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              Center(
                child: Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: _selectDate,
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _dobController,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.date_range, size: 22),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Nunito',
                        ),
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