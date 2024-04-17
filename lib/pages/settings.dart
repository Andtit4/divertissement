import 'package:divertissement/pages/login.dart';
import 'package:divertissement/services/local.dart';
import 'package:divertissement/utils/constants.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.orange,
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SizedBox(
            width: screenWidth(context),
            height: screenHeight(context),
            child: Stack(
              fit: StackFit.expand,
              children: [
                FluImage(
                  'assets/sport.jpg',
                  imageSource: ImageSources.asset,
                ),
                Positioned(
                    top: 0,
                    child: SizedBox(
                      width: screenWidth(context),
                      height: screenHeight(context) * .4,
                      child: FluImage(
                        'assets/logo.jpg',
                        imageSource: ImageSources.asset,
                      ),
                    )),
                Positioned(
                    top: screenHeight(context) * .6,
                    right: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /*  Text(
                      'Profil',
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Musique',
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Langue',
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Politique',
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ), */
                        Text(
                          'Politique',
                          style: TextStyle(
                              color: Colors.amber,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            logout();
                            Get.offAll(() => LoginPage());
                          },
                          child: Text(
                            'Deconnexion',
                            style: TextStyle(
                                color: Colors.amber,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          )

          /*  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenWidth(context),
                height: screenHeight(context) * .35,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FluAvatar(
                      defaultAvatarType: FluAvatarTypes.memojis,
                      size: 100,
                      circle: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Ama Kwatcha',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: screenWidth(context) * .3,
                      height: screenHeight(context) * .08,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(child: Text('Player')),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  'Paramêtre',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              Container(
                width: double.infinity,
                height: screenHeight(context) * .08,
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: [
                    SizedBox(
                      width: screenWidth(context) *.1,
                      child: FluIcon(
                        FluIcons.user,
                        color: Colors.black,
                        style: FluIconStyles.bulk,
                      ),
                    ),
                    
                    Text('Informations personnelles', style: TextStyle(color: Colors.black),)
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: screenHeight(context) * .08,
                margin: EdgeInsets.only(left: 15, bottom: 15),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: [
                    SizedBox(
                      width: screenWidth(context) *.1,
                      child: FluIcon(
                        FluIcons.languageCircle,
                        color: Colors.black,
                        style: FluIconStyles.bulk,
                      ),
                    ),
                    
                    Text('Langues', style: TextStyle(color: Colors.black),)
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: screenHeight(context) * .08,
                margin: EdgeInsets.only(left: 15, bottom: 15),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: [
                    SizedBox(
                      width: screenWidth(context) *.1,
                      child: FluIcon(
                        FluIcons.music,
                        color: Colors.black,
                        style: FluIconStyles.bulk,
                      ),
                    ),
                    
                    Text('Sons', style: TextStyle(color: Colors.black),)
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: screenHeight(context) * .08,
                margin: EdgeInsets.only(left: 15, bottom: 15),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: [
                    SizedBox(
                      width: screenWidth(context) *.1,
                      child: FluIcon(
                        FluIcons.security,
                        color: Colors.black,
                        style: FluIconStyles.bulk,
                      ),
                    ),
                    
                    Text('Politiques', style: TextStyle(color: Colors.black),)
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: screenHeight(context) * .08,
                margin: EdgeInsets.only(left: 15, bottom: 15),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: [
                    SizedBox(
                      width: screenWidth(context) *.1,
                      child: FluIcon(
                        FluIcons.logout,
                        color: Colors.black,
                        style: FluIconStyles.bulk,
                      ),
                    ),
                    
                    Text('Deconnexion', style: TextStyle(color: Colors.black),)
                  ],
                ),
              ),
            

            
            ],
          ),
        ), */
          ),
    );
  }
}
