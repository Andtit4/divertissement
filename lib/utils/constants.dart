import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

String appName = 'Divertissement';

screenWidth(BuildContext context) {
  return MediaQuery.sizeOf(context).width;
}

screenHeight(BuildContext context) {
  return MediaQuery.sizeOf(context).height;
}


Color bgColor = Colors.black;
Color primaryColor = Color(0xff141a33);
Color btnColor = Color(0xff06d3f6);

TextStyle defaultFont = GoogleFonts.roboto();
TextTheme defaultTextTheme = GoogleFonts.poppinsTextTheme();
