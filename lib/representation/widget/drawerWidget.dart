// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:task4/helper/const/color_helper.dart';
import 'package:task4/helper/const/icon_helper.dart';
import 'package:task4/helper/const/image_helper.dart';
import 'package:task4/helper/const/string_helper.dart';
import 'package:task4/representation/views/audioScreen/audio_screen.dart';
import 'package:task4/representation/views/imagesScreen/image_screen.dart';
import 'package:task4/representation/views/home_screen.dart';
import 'package:task4/representation/views/videoScreen/video_screen.dart';
import 'package:task4/representation/widget/text_widget.dart';
class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: ColorHelper.K_blue
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(ImageHelper.networkImage),
                ),
                const SizedBox(height: 10,),
                Center(child: TextWidget(txt: StringHelp.random_email,)),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
            },
            leading: IconHelper.HOME_ICON,
            title:TextWidget(txt:StringHelp.MAIN_SCREEN),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>VideoScreen()));
            },
            leading: IconHelper.VIDEO_ICON,
            title: TextWidget(txt:StringHelp.VIDEO_SCREEN),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ImageScreen()));
            },
            leading:IconHelper.IMAGE_ICON,
            title: TextWidget(txt:StringHelp.IMAGE_SCREEN),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AudioScreen()));
            },
            leading: IconHelper.AUDIO_ICON,
            title:TextWidget(txt:StringHelp.AUDIO_SCREEN),
          ),
        ],
      ),
    );
  }
}