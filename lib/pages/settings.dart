import 'package:divertissement/utils/constants.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
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
        ),
      ),
    );
  }
}
