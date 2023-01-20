// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, prefer_typing_uninitialized_variables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task4/bloc/video_blocs/video_bloc.dart';
import 'package:task4/bloc/video_blocs/video_events.dart';
import 'package:task4/bloc/video_blocs/video_state.dart';
import 'package:task4/helper/const/icon_helper.dart';
import 'package:task4/helper/const/string_helper.dart';
import 'package:task4/representation/widget/button_widget.dart';
import 'package:task4/representation/widget/drawerWidget.dart';
import 'package:task4/representation/widget/text_widget.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: TextWidget(txt: StringHelp.PICK_VIDEO_FROM),
          content: SingleChildScrollView(
            child: BlocBuilder<VideoBloc, VideoStates>(
              builder: (context, state) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: IconHelper.IMAGE_ICON,
                      onTap: () {
                        Navigator.pop(context);
                        BlocProvider.of<VideoBloc>(context)
                            .add(FetchVideo(ImageSource.gallery));
                      },
                      title: TextWidget(txt: StringHelp.PICK_FROM_GALLERY),
                    ),
                    ListTile(
                      leading: IconHelper.VIDEO_ICON,
                      onTap: () {
                        Navigator.pop(context);
                        BlocProvider.of<VideoBloc>(context)
                            .add(FetchVideo(ImageSource.camera));
                      },
                      title: TextWidget(txt: StringHelp.PICK_FROM_CAMERA),
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
   BlocProvider.of<VideoBloc>(context).add(Closed());
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
      appBar: AppBar(title: TextWidget(txt: StringHelp.VIDEO_SCREEN)),
      
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
                BlocBuilder<VideoBloc, VideoStates>(
                  builder: (context, state) {
                    if (state.status == VideoStatus.success) {
                       return Column(
                         children: [
                          TextWidget(txt: StringHelp.thumbNail),
                           Container(
                      width: double.infinity,
                      height: 200,
                      child: Image(image: MemoryImage(state.thumbnailImg!),fit: BoxFit.fill,),
                    ),
                    SizedBox(height: 12,),
                    TextWidget(txt: StringHelp.selectVideo),
                    Container(
                      height: 250,
                      width: double.infinity,
                        child: VideoPlayer(state.video!))
                         ],
                       );
                    }
                    if (state.status == VideoStatus.failure) {
                       return Center(child:TextWidget(txt: StringHelp.ERROR_TEXT));
                    }
                    if (state.status == VideoStatus.initial) {
                       return Center(child:TextWidget(txt: StringHelp.NO_FILE));
                    }
                    return Container();
                   
                  },
                ),
              SizedBox(
                height: 20,
              ),
              Flexible(
                child: ButtonWidget(
                  txt: StringHelp.SELECT_VIDEO, 
                  press: ()=>_showAlertDialog()
                  ))
              
            ],
          ),
        ),
      ),
    );
  }
}
