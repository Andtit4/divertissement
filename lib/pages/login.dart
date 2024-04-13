import 'package:divertissement/pages/home.dart';
import 'package:divertissement/pages/register.dart';
import 'package:divertissement/partials/bottom_nav_bar.dart';
import 'package:divertissement/partials/input.dart';
import 'package:divertissement/services/local.dart';
import 'package:divertissement/utils/constants.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController mdpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight(context) * .06,
            ),
            Container(
              width: screenWidth(context),
              height: screenHeight(context) * .2,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              child: Center(
                child: Text(
                  'VEILLEZ VOUS\nCONNECTER',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight(context) * .04,
            ),
            Container(
              width: double.infinity,
              height: screenHeight(context) * .58,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  // color: Color.fromARGB(255, 22, 48, 79),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(25)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TiInput(
                    color: Colors.white,
                    readonly: false,
                    width: screenWidth(context),
                    inputController: emailController,
                    hintText: 'Entrer votre email',
                    hintColor: Colors.grey,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TiInput(
                    color: Colors.white,
                    readonly: false,
                    width: screenWidth(context),
                    hintText: 'Entrer votre mot de passe',
                    inputController: mdpController,
                    hintColor: Colors.grey,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FluButton(
                      onPressed: () {
                        if (emailController.text == '' ||
                            mdpController.text == '') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Veillez remplir tous les champs !'),
                            backgroundColor: Colors.red,
                          ));
                        } else if (emailController.text == ' ' ||
                            mdpController.text == ' ') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Veillez remplir tous les champs !'),
                            backgroundColor: Colors.red,
                          ));
                        } else {
                          getAuth(emailController.text, mdpController.text);
                          /* register(pseudoController.text, nomController.text,
                              prenomController.text, '0');
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Bienvenu')));
                          Get.offAll(() => BottomNavBar(),
                              transition: Transition.leftToRight,
                              duration: const Duration(seconds: 3)); */
                        }
                      },
                      child: Container(
                        width: screenWidth(context),
                        height: screenHeight(context) * .1,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(25)),
                        child: Center(
                            child: Text(
                          'Créer votre compte',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(onPressed: (){
                            Get.offAll(() => RegisterPage(),
                              transition: Transition.leftToRight,
                              duration: const Duration(seconds: 3));
                          }, child: Text('Pas de compte ? Veillez créer ici'))
                        ],
                      )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
