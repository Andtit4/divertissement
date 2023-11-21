import 'package:divertissement/utils/constants.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * .035,
              ),
              Text(
                'Please register\nbefore continue',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: screenHeight * .02,
              ),
              Container(
                width: double.infinity,
                height: screenHeight * .5,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 22, 48, 79),
                  borderRadius: BorderRadius.circular(25)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
