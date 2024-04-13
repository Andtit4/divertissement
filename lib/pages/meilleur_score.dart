import 'package:divertissement/model/user_model.dart';
import 'package:divertissement/services/local.dart';
import 'package:divertissement/utils/constants.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeilleurScore extends StatefulWidget {
  const MeilleurScore({super.key});

  @override
  State<MeilleurScore> createState() => _MeilleurScoreState();
}

class _MeilleurScoreState extends State<MeilleurScore> {
  @override
  void initState() {
    getHighScore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  top: screenHeight(context) * .45,
                  left: screenWidth(context) * .3,
                  child: Text(
                    'Meilleur score',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  )),
              Positioned(
                  top: screenHeight(context) * .45,
                  left: screenWidth(context) * .3,
                  child: SizedBox(
                    width: screenWidth(context),
                    height: screenHeight(context) * .3,
                    child: FutureBuilder(
                      future: getHighScore(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return SizedBox(
                            width: screenWidth(context),
                            height: screenHeight(context) * .1,
                            child: Center(child: CircularProgressIndicator(color: Colors.transparent,)));
                        else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'An error occured ${snapshot.error}',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        } else {
                          List<UserModel> data = snapshot.data ?? [];
                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: Row(
                                  children: [
                                    Text(
                                      data[index].pseudo,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      ' - ${data[index].score} points',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
