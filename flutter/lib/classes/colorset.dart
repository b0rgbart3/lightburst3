
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
// ColorSets are my static pre-defined sets of 4 colors 
// the instantiated colorset will split those up into named variables

class Colorset {

  late Color inside,outside,shadow,text,textShadow, background,insideHi,outsideHi, shadowHi, textHi, textShadowHi;
  late String nameString;

  static const colorNames = ["indigo","blue","green","yellow","orange","red","purple"];

  static const colorsets = [
    // inside      //outside    //shadow     //text        //textShadow    //background
     [0xFF081D96,0xFF081961,0xE0021121,0xFFBBC8FC, 0xff000000,  0x7E0034A4,
     0xAF496CF8,0xAF2232E4,0x88003CFF,0xFFDCFEFB, 0xFF071625],
    [0xFF084F96,0xFF0E3F70,0xE0061F39,0xFF8EE1FD, 0xff000000,  0x8E006BA4,
     0xAF5DC9FF,0xFF26A5DB,0x880088FF,0xFFDCFEFB, 0xFF071625],
    [0xFF08963C,0xFF0E703D,0xE0063921,0xFFA1FFBC, 0xFF00180F, 0x720F6D35,
     0xAF6BFA93,0xFF26DB5F,0x8800FF66,0xFFF5FFE6, 0xFF072513],
    [0xFFDFB300,0xFFA07C04,0x8E8F6701,0xFFF9F7ED, 0xFF201801, 0x88FFB700,
     0xFFFCDD60,0xFFE9C121,0xB1FCDA6B,0xFFFCF6EC, 0xFF1D1301],
    [0xFFD25C02,0xFFA02E04,0xB05A1C02,0xFFFEE6CB, 0xFF241401, 0x88DF6902,
     0xFFFCC067,0xFFFDAB4D,0xC8B15301,0xFFFCE9D5, 0xFF6D3A00],
    [0xFFDA0A41,0xFFA00428,0xB05A020F,0xFFFFDDE8, 0xFF6D001D, 0x88FF004C,
     0xFFFC86B9,0xFFFD4D8B,0xC8FF3C7A,0xFFFAC3C4, 0xFF6D001D],
    [0xFFA302D8,0xFF7F0398,0xB053025A,0xFFF7DDFF, 0xFF67006D, 0x88D400FF,
     0xFFDA79FA,0xFFC84DFD,0xB2CE3CFF,0xFFFAC3F8, 0xFF6D006D],
  ];

  Colorset( colorID ) {
    var colors = colorsets[colorID];

    inside = Color(colors[0]);
    outside = Color(colors[1]);
    shadow = Color(colors[2]);
    text = Color(colors[3]);
    textShadow = Color(colors[4]);
    background = Color(colors[5]);
    insideHi = Color(colors[6]);
    outsideHi = Color(colors[7]);
    shadowHi = Color(colors[8]);
    textHi = Color(colors[9]);
    textShadowHi = Color(colors[10]);
    nameString = colorNames[colorID];

  }
  


}