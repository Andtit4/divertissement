import 'package:divertissement/pages/home.dart';
import 'package:divertissement/partials/input.dart';
import 'package:divertissement/services/local.dart';
import 'package:divertissement/utils/constants.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController pseudoController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();

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
                height: screenHeight * .06,
              ),
              Text(
                'Please register\nbefore continue',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: screenHeight * .04,
              ),
              Container(
                width: double.infinity,
                height: screenHeight * .58,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 22, 48, 79),
                    borderRadius: BorderRadius.circular(25)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TiInput(
                      color: primaryColor,
                      readonly: false,
                      width: screenWidth,
                      inputController: pseudoController,
                      hintText: 'Entrer votre pseudo',
                      hintColor: Colors.white,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TiInput(
                      color: primaryColor,
                      readonly: false,
                      width: screenWidth,
                      hintText: 'Entrer votre nom',
                      inputController: nomController,
                      hintColor: Colors.white,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TiInput(
                      color: primaryColor,
                      readonly: false,
                      width: screenWidth,
                      hintText: 'Entrer votre prénom',
                      inputController: prenomController,
                      hintColor: Colors.white,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    FluButton(
                        onPressed: () {
                          if (pseudoController.text == '' ||
                              nomController.text == '' ||
                              prenomController.text == '') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                                  Text('Veillez remplir tous les champs !'),
                              backgroundColor: Colors.red,
                            ));
                          } else if (pseudoController.text == ' ' ||
                              nomController.text == ' ' ||
                              prenomController.text == ' ') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                                  Text('Veillez remplir tous les champs !'),
                              backgroundColor: Colors.red,
                            ));
                          } else {
                            register(pseudoController.text, nomController.text,
                                prenomController.text);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Bienvenu')));
                            Get.offAll(() => const HomePage(),
                                transition: Transition.leftToRight,
                                duration: const Duration(seconds: 3));
                          }
                        },
                        child: Container(
                          width: screenWidth,
                          height: screenHeight * .1,
                          decoration: BoxDecoration(
                              color: btnColor,
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                              child: Text(
                            'Enregistrer',
                            style: TextStyle(color: Colors.white),
                          )),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
