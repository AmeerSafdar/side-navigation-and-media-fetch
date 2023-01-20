// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:task4/helper/const/string_helper.dart';
import 'package:task4/representation/widget/drawerWidget.dart';
import 'package:task4/representation/widget/text_widget.dart';
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title:TextWidget(txt: StringHelp.MAIN_SCREEN)
      ),
      body: Center(child: TextWidget(txt: StringHelp.MAIN_SCREEN),),
    );
  }
}
