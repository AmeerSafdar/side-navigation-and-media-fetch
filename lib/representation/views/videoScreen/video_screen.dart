// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, prefer_typing_uninitialized_variables, sized_box_for_whitespace, avoid_unnecessary_containers, non_constant_identifier_names, must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task4/bloc/video_blocs/video_bloc.dart';
import 'package:task4/bloc/video_blocs/video_events.dart';
import 'package:task4/bloc/video_blocs/video_state.dart';
import 'package:task4/helper/const/const.dart';
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
                        permissionUtils.askVideoGalleryPermission(context);
                      },
                      title: TextWidget(txt: StringHelp.PICK_FROM_GALLERY),
                    ),
                    ListTile(
                      leading: IconHelper.VIDEO_ICON,
                      onTap: () {
                        permissionUtils.askVideoCameraPermission(context);
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
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(title: TextWidget(txt: StringHelp.VIDEO_SCREEN)),
      floatingActionButton: BlocBuilder<VideoBloc, VideoStates>(
        builder: (context, state) {
          return FloatingActionButton(
              onPressed: () {
               if(state.video !=null) {
                  if (state.status==VideoStatus.pause) {
                  BlocProvider.of<VideoBloc>(context).add(Play());
                } else {
                  BlocProvider.of<VideoBloc>(context).add(Pause());
                }
                }
              }, 
              child:state.status== VideoStatus.pause ? IconHelper.PLAY_ICON : IconHelper.PAUSE_ICON);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<VideoBloc, VideoStates>(
                  builder: (context, state) {
                    if (state.status == VideoStatus.success || state.status == VideoStatus.play ) {
                      return Column(
                        children: [
                          VideoWidget(
                            asp_ratio: state.video!.value.aspectRatio,
                            video: state.video!,
                            thumbnail: state.thumbnailImg!,
                          )
                        ],
                      );
                    }
                    if (state.status == VideoStatus.pause) {
                      return AspectRatio(
                        aspectRatio: state.video!.value.aspectRatio,
                        child: Image(
                          image: MemoryImage(state.thumbnailImg!),
                          fit: BoxFit.fill,
                        ),
                      );
                    }
                    if (state.status == VideoStatus.failure) {
                      if (state.video != null) {
                        return VideoWidget(
                          asp_ratio: state.video!.value.aspectRatio,
                          video: state.video!,
                          thumbnail: state.thumbnailImg!,
                        );
                      }
                      return Center(child: TextWidget(txt: StringHelp.NO_FILE));
                    }
                    if (state.status == VideoStatus.initial) {
                      return Center(child: TextWidget(txt: StringHelp.NO_FILE));
                    }
                    return Container();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                    txt: StringHelp.SELECT_VIDEO,
                    press: () => _showAlertDialog())
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VideoWidget extends StatelessWidget {
  VideoWidget({Key? key, this.asp_ratio, this.video, this.thumbnail})
      : super(key: key);
  double? asp_ratio;
  VideoPlayerController? video;
  Uint8List? thumbnail;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: asp_ratio!, child: VideoPlayer(video!));
  }
}
