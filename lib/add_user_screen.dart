import 'dart:convert';
import 'dart:developer';

import 'package:demoproject/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController jobNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Full Name",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                        color: const Color(0xffFDFDFD),
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(
                            color: const Color(0xFF000000).withOpacity(0.1),
                            width: 1)),
                    child: TextField(
                      controller: fullNameController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Job Name",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                        color: const Color(0xffFDFDFD),
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(
                            color: const Color(0xFF000000).withOpacity(0.1),
                            width: 1)),
                    child: TextField(
                      controller: jobNameController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                ///Api call
                addNewUser(context);
              },
              child: Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    color: const Color(0xff4B94FF),
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addNewUser(context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    var requestParameter = {
      "name": fullNameController.text.trim(),
      "job": jobNameController.text.trim(),
    };
    var response = await http.post(
       Uri.parse("https://reqres.in/api/users?pages=1"),
      body: json.encode(requestParameter)
    );
    if (response.statusCode == 201) {
      var result = json.decode(response.body);
      log("CreatedResponse===$result");

      if (result != null) {
        Navigator.of(context).pop({
          "first_name": fullNameController.text.trim(),
          "last_name": "",
          "email": jobNameController.text.trim(),
          "avatar": ""
        });
      }
    }
  }
}
