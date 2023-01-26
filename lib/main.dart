// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:task4/bloc/audio_blocs/audio_bloc.dart';
import 'package:task4/bloc/image_blocs/image_screen_bloc.dart';
import 'package:task4/bloc/video_blocs/video_bloc.dart';
import 'package:task4/helper/const/string_helper.dart';
import 'package:task4/repository/audio_reposirty.dart';
import 'package:task4/repository/get_imageRepo.dart';
import 'package:task4/repository/get_video_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task4/representation/views/imagesScreen/image_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       BlocProvider<ImageBloc>(create: ((context) => ImageBloc(imgRepo: ImageRepository()))),
       BlocProvider<VideoBloc>(create: ((context) => VideoBloc(getVideRepo: GetVideoRepo()))),
       BlocProvider<AudioBlocs>(create: ((context) => AudioBlocs(audioRepo: AudioRepository()))),
      ],
      child: MaterialApp(
        title: StringHelp.TITLE_TEXT,
        debugShowCheckedModeBanner: false,
        home: const ImageScreen(),
      ),
    );
      
  }
}
