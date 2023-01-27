// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task4/bloc/image_blocs/image_screen_bloc.dart';
import 'package:task4/bloc/image_blocs/image_screen_event.dart';
import 'package:task4/bloc/image_blocs/image_state.dart';
import 'package:task4/helper/const/const.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget(txt: StringHelp.IMAGE_SCREEN),
      ),
      body: BlocListener<ImageBloc, ImageStates>(
        listener: (context, state) {
          if (state.status==ImageStatus.cameraDenied) {
              dialogUtils.showAlertDialog(context, yesButtonTaped: ()=>Navigator.pop(context), 
              noBtnPress: ()=>Navigator.pop(context), 
              action: StringHelp.PERMISSION, titleContent: StringHelp.PERMISSION_DENIED);
          }
          else if (state.status==ImageStatus.cameraPermanentDenied){
             dialogUtils.showAlertDialog(
                context, yesButtonTaped: (){
                Navigator.pop(context);
                openAppSettings();
                }, noBtnPress: ()=>Navigator.pop(context),
                action: StringHelp.PERMISSION, 
                titleContent: '${StringHelp.PERMISSION_DENIED} ${StringHelp.OPEN_APP_SETTINGS}');
      
          }
          if (state.status==ImageStatus.galleryDenied) {
               dialogUtils.showAlertDialog(context, yesButtonTaped: ()=>Navigator.pop(context), 
                noBtnPress: ()=>Navigator.pop(context), 
                action: StringHelp.PERMISSION, titleContent: StringHelp.PERMISSION_DENIED);
          }
          else if (state.status==ImageStatus.galleryPermanentDenied){
             dialogUtils.showAlertDialog(
              context, yesButtonTaped:  (){
                Navigator.pop(context);
                openAppSettings();
                }, noBtnPress: ()=>Navigator.pop(context),
                action: StringHelp.PERMISSION, 
                titleContent: '${StringHelp.PERMISSION_DENIED} ${StringHelp.OPEN_APP_SETTINGS}');
      
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                        if ((state.status == ImageStatus.success||state.status == ImageStatus.cameraDenied|| state.status == ImageStatus.cameraPermanentDenied||state.status == ImageStatus.galleryDenied|| state.status == ImageStatus.galleryPermanentDenied)&&state.img!=null) {
                          return Container(
                              height: 450,
                              width: double.infinity,
                              child: Image.file(
                                state.img!,
                                fit: BoxFit.fill,
                              ));
                        }
                        if (state.status == ImageStatus.initial) {
                          return Container(
                              child: TextWidget(txt: StringHelp.NO_FILE));
                        }
                        if ((state.status == ImageStatus.failure||state.status == ImageStatus.cameraDenied|| state.status == ImageStatus.cameraPermanentDenied||state.status == ImageStatus.galleryDenied|| state.status == ImageStatus.galleryPermanentDenied)&&state.img!=null) {
                          if (state.img != null) {
                            return Container(
                                height: 450,
                                width: double.infinity,
                                child: Image.file(
                                  state.img!,
                                  fit: BoxFit.cover,
                                ));
                          }
                          return Container(
                              child: TextWidget(txt: StringHelp.NO_FILE));
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
                      txt: StringHelp.PICK_IMAGE,
                      press: () => BlocProvider.of<ImageBloc>(context)
                          .add(FetchImage(context))))
            ],
          ),
        ),
      ),
    );
  }
}
