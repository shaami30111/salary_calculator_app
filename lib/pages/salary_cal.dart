import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:intl/intl.dart';
// import 'dart:io';

class SalaryCal extends StatefulWidget {
  const SalaryCal({super.key});

  @override
  State<SalaryCal> createState() => _SalaryCalState();
}

class _SalaryCalState extends State<SalaryCal> {
  final purpleColor = const Color(0xff6688FF);
  final darkTextColor = const Color(0xff1F1A3D);
  final lightTextColor = const Color(0xff999999);
  final textField = const Color(0xffF5F6FA);
  final borderColor = const Color(0xffD9D9D9);

  final salaryController = TextEditingController();
  final tempController = TextEditingController();
  final taxController = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  TextEditingController enddateinput = TextEditingController();
  double netSal = 0;
  double convertedTemp = 0;
  String sourceUnit = 'Select Unit';
  String targetUnit = 'Select Unit';
  String age1 = '';
  String formattedDate = '';
  String endformattedDate = '';

  DateTime? pickedDateF;
  DateTime? pickedDateL;

  final List<String> temperatureUnits = [
    "Centigrade",
    "Farenheit",
    "Kelvin",
  ];

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(
            FontAwesome5.calculator,
            color: Colors.white,
          ),
          backgroundColor: Colors.blueAccent,
          title: const Text(
            "Universal Calculator",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.indigo,
            labelColor: Colors.white,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w700,
            ),
            tabs: [
              Tab(
                icon: Icon(Icons.currency_exchange),
                text: "Salary Calculator",
              ),
              Tab(
                icon: Icon(Icons.device_thermostat_outlined),
                text: "Temprature Converter",
              ),
              Tab(
                icon: Icon(Icons.timelapse),
                text: "Age Calculator",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Salary converter
            SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Salary Amount",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextField(
                        controller: salaryController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 14.h,
                            horizontal: 20.w,
                          ),
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          filled: true,
                          fillColor: textField,
                          hintText: "Enter Your Salary in Rupees",
                          prefixIcon: Icon(
                            Icons.currency_exchange_rounded,
                            size: 22.sp,
                            color: Colors.grey,
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        "Tax Percentage",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextField(
                        controller: taxController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 14.h,
                            horizontal: 20.w,
                          ),
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          filled: true,
                          fillColor: textField,
                          hintText: "Enter Your Salary Tax",
                          prefixIcon: Icon(
                            Icons.percent,
                            size: 22.sp,
                            color: Colors.grey,
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "Net Salary Amount",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Rs $netSal",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.blue,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 150.w,
                              child: TextButton(
                                onPressed: () {
                                  double salary =
                                      double.tryParse(salaryController.text) ??
                                          0;
                                  double tax =
                                      double.tryParse(taxController.text) ?? 0;
                                  salaryCal(salary, tax);
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 20, 48, 232)),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.black),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(vertical: 17.h)),
                                  textStyle: MaterialStateProperty.all(
                                    TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  "Calculate",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 75.w,
                            ),
                            SizedBox(
                              width: 150.w,
                              child: TextButton(
                                onPressed: () {
                                  salaryController.clear();
                                  taxController.clear();
                                  netSal = 0;
                                  setState(() {});
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 20, 48, 232)),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.black),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(vertical: 17.h)),
                                  textStyle: MaterialStateProperty.all(
                                    TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  "Clear",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Temprature Converter
            SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Temprature in Centigrade",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextField(
                        controller: tempController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 14.h,
                            horizontal: 20.w,
                          ),
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          filled: true,
                          fillColor: textField,
                          hintText: "Enter Temprature",
                          prefixIcon: Icon(
                            Typicons.temperatire,
                            size: 22.sp,
                            color: Colors.grey,
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        "Conversion Unit",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "From: ",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w600),
                          ),
                          DropdownButton<String>(
                            // Step 3.
                            value: sourceUnit,
                            // Step 4.
                            items: <String>[
                              'Select Unit',
                              'Centigrade',
                              'Farenheit',
                              'Kelvin'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            // Step 5.
                            onChanged: (String? newValue) {
                              setState(() {
                                sourceUnit = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "To:     ",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w600),
                          ),
                          DropdownButton<String>(
                            // Step 3.
                            value: targetUnit,
                            // Step 4.
                            items: <String>[
                              'Select Unit',
                              'Centigrade',
                              'Farenheit',
                              'Kelvin'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                ),
                              );
                            }).toList(),
                            // Step 5.
                            onChanged: (String? newValue) {
                              setState(() {
                                targetUnit = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "Temprature Converted:",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "$convertedTemp",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.red[600],
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              double temp =
                                  double.tryParse(tempController.text) ?? 0;
                              tempConvert(temp, sourceUnit, targetUnit);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              backgroundColor: Color.fromARGB(255, 20, 48, 232),
                              padding: EdgeInsets.all(12),
                            ),
                            child: Text(
                              "Calculate",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              tempController.clear();
                              setState(() {
                                sourceUnit = 'Select Unit';
                                targetUnit = 'Select Unit';
                                convertedTemp = 0;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              backgroundColor: Color.fromARGB(255, 20, 48, 232),
                              padding: EdgeInsets.all(12),
                            ),
                            child: Text(
                              "Clear",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Age calculator
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select Date:",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: TextField(
                          controller:
                              dateinput, //editing controller of this TextField
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 14.h,
                              horizontal: 20.w,
                            ),
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            filled: true,
                            fillColor: textField,
                            hintText: "Enter Date of Birth",
                            prefixIcon: Icon(
                              Icons.calendar_month,
                              size: 22.sp,
                              color: Colors.grey,
                            ), //icon of text field
                          ),
                          readOnly:
                              true, //set it true, so that user will not able to edit text
                          onTap: () async {
                            pickedDateF = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(
                                    1980), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));

                            if (pickedDateF != null) {
                              //pickedDate output format => 2021-03-10 00:00:00.000
                              formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDateF!);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                dateinput.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Date is not selected'),
                                  duration: Duration(
                                      seconds:
                                          2), // Optional: set duration for how long the SnackBar should be shown
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Select Ending Date:",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: TextField(
                          controller:
                              enddateinput, //editing controller of this TextField
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 14.h,
                              horizontal: 20.w,
                            ),
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            filled: true,
                            fillColor: textField,
                            hintText: "Enter Date of Birth",
                            prefixIcon: Icon(
                              Icons.calendar_month,
                              size: 22.sp,
                              color: Colors.grey,
                            ), //icon of text field
                          ),
                          readOnly:
                              true, //set it true, so that user will not able to edit text
                          onTap: () async {
                            pickedDateL = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(
                                    1980), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));

                            if (pickedDateL != null) {
                              //pickedDate output format => 2021-03-10 00:00:00.000
                              endformattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDateL!);
                              print(
                                  endformattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                enddateinput.text =
                                    endformattedDate; //set output date to TextField value.
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Date is not selected'),
                                  duration: Duration(
                                      seconds:
                                          2), // Optional: set duration for how long the SnackBar should be shown
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Age Calculated:",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        height: 120.h,
                        width: 380.w,
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              age1,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.red[600],
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              age1,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.red[600],
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (pickedDateF != null && pickedDateL != null) {
                                ageCalOne(formattedDate, endformattedDate);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Date is not selected'),
                                    duration: Duration(
                                        seconds:
                                            2), // Optional: set duration for how long the SnackBar should be shown
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              backgroundColor: Color.fromARGB(255, 20, 48, 232),
                              padding: EdgeInsets.all(12),
                            ),
                            child: Text(
                              "Calculate",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              dateinput.clear();
                              enddateinput.clear();
                              pickedDateF = null;
                              pickedDateL = null;
                              age1 = '';

                              setState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Cleared!'),
                                  duration: Duration(
                                      seconds:
                                          2), // Optional: set duration for how long the SnackBar should be shown
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              backgroundColor: Color.fromARGB(255, 20, 48, 232),
                              padding: EdgeInsets.all(12),
                            ),
                            child: Text(
                              "Clear",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  void salaryCal(double salary, double tax) {
    double taxAmount = (tax / 100) * salary;
    double netSalary = salary - taxAmount;
    setState(() {
      netSal = netSalary;
    });
  }

  void tempConvert(double temp, String source, String target) {
    double convert = 0;
    if (source == 'Centigrade' && target == 'Kelvin') {
      convert = temp + 273.15;
    } else if (source == 'Centigrade' && target == 'Farenheit') {
      convert = (temp * (9 / 5)) + 32;
    } else if (source == 'Farenheit' && target == 'Kelvin') {
      convert = (5 / 9) * (temp - 32) + 273.15;
    } else if (source == 'Farenheit' && target == 'Centigrade') {
      convert = (5 / 9) * (temp - 32);
    } else if (source == 'Kelvin' && target == 'Centigrade') {
      convert = temp - 273.15;
    } else if (source == 'Kelvin' && target == 'Farenheit') {
      convert = ((temp - 273.15) * (9 / 5)) + 32;
    }
    setState(() {
      convertedTemp = convert;
    });
  }

  void ageCalOne(String date, String endD) {
    // String current = DateFormat('yyyy-MM-dd').format(currentd);
    // String duration =
    //     (AgeCalculator.age(date as DateTime, today: current as DateTime))
    //         .toString();
    // print('Your age is $duration');
    // age = duration;
    // setState(() {});
    List<String> part = date.split("-");
    int year = int.parse(part[0]);
    int month = int.parse(part[1]);
    int day = int.parse(part[2]);
    List<String> partE = endD.split("-");

    int cyear = int.parse(partE[0]);
    int cmonth = int.parse(partE[1]);
    int cday = int.parse(partE[2]);
    int ayear = cyear - year;
    int amonth = cmonth - month;
    int aday = cday - day;
    if (cmonth < month) {
      ayear -= 1;
      amonth += 12;
    }
    if (aday < 0 && amonth != 0) {
      amonth -= 1;
      aday += 30;
    }
    if (amonth == 0 && aday < 0) {
      aday += 30;
      amonth = 11;
    }
    // print("Age:Year:$ayear\t Month:$amonth\t Day:$aday");
    age1 = ayear.toString() +
        " Years " +
        amonth.toString() +
        " Months " +
        aday.toString() +
        " Days ";
    setState(() {});
  }

  void ageCalAll() {}
}
