// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: SharedPref(),
    );
  }
}

class SharedPref extends StatefulWidget {
  const SharedPref({super.key});

  @override
  State<SharedPref> createState() => _SharedPrefState();
}

class _SharedPrefState extends State<SharedPref> {
  final nameController = TextEditingController();
  String? name_value;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getName();
  // }

  void getName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    name_value = pref.getString("Name");
    print('got the object, ');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        //   statusBarColor: Colors.transparent,
        // ));
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.immersive,
        );
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 230, 214, 233),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.2,
                ),
                Icon(
                  Icons.file_copy_sharp,
                  size: screenHeight * 0.1,
                  color: Colors.black,
                ),
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                Text(
                  name_value == null ? "No name saved" : name_value!,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.black),
                ),
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                TextField(
                  controller: nameController,
                  style: TextStyle(color: Color.fromARGB(212, 91, 91, 91)),
                  decoration: InputDecoration(
                    fillColor: Color.fromARGB(255, 241, 240, 240),
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 241, 240, 240))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 251, 251, 251))),
                    hintText: "Enter your name",
                    hintStyle:
                        TextStyle(color: const Color.fromARGB(255, 95, 95, 95)),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setNamedata(nameController.text);
                      print("object saved ");
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      padding: MaterialStateProperty.all(EdgeInsets.all(17)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                    ),
                    child: Text(
                      "S A V E",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        getName();
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      padding: MaterialStateProperty.all(EdgeInsets.all(17)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                    ),
                    child: Text(
                      "S H O W  D A T A",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> setNamedata(namevalue) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  namevalue = pref.setString("Name", namevalue);
}
