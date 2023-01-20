// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task4/bloc/image_blocs/image_screen_bloc.dart';
import 'package:task4/bloc/image_blocs/image_screen_event.dart';
import 'package:task4/bloc/image_blocs/image_state.dart';
import 'package:task4/helper/const/icon_helper.dart';
import 'package:task4/helper/const/string_helper.dart';
import 'package:task4/representation/widget/button_widget.dart';
import 'package:task4/representation/widget/drawerWidget.dart';
import 'package:task4/representation/widget/text_widget.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {


  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: TextWidget(txt: StringHelp.PICK_IMAGE_FROM),
          content: SingleChildScrollView(
            child: BlocBuilder<ImageBloc, ImageStates>(
              builder: (context, state) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: IconHelper.IMAGE_ICON,
                      onTap: () {
                        Navigator.pop(context);
                        BlocProvider.of<ImageBloc>(context)
                            .add(FetchImage(ImageSource.gallery));
                      },
                      title: TextWidget(txt: StringHelp.PICK_FROM_GALLERY),
                    ),
                    ListTile(
                      leading: IconHelper.VIDEO_ICON,
                      onTap: () {
                        Navigator.pop(context);
                        BlocProvider.of<ImageBloc>(context)
                            .add(FetchImage(ImageSource.camera));
                      },
                      title:TextWidget(txt: StringHelp.PICK_FROM_CAMERA),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: TextWidget(txt: StringHelp.CANCEL),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

   @override
  void didChangeDependencies() {
   BlocProvider.of<ImageBloc>(context).add(Closed());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget(txt: StringHelp.IMAGE_SCREEN),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  BlocBuilder<ImageBloc, ImageStates>(
                    builder: (context, state) {

                      if (state.status == ImageStatus.success){
                      return Container(
                        height: 500,
                        width: double.infinity,
                          child: Image.file(state.img!,fit: BoxFit.fill,));
                      }
                      if (state.status == ImageStatus.initial){
                       return Container(
                          child: TextWidget(txt: StringHelp.NO_FILE));
                      }
                      if (state.status == ImageStatus.failure){
                       return Container(
                          child:TextWidget(txt: StringHelp.ERROR_TEXT)
                          );
                      }
                      return Container();

                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: ButtonWidget(
              txt: StringHelp.PICK_IMAGE, press: _showAlertDialog
              ))
           
          ],
        ),
      ),
    );
  }
}
