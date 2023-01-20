// ignore_for_file: use_rethrow_when_possible, unused_local_variable, unused_import

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task4/helper/const/string_helper.dart';

class AudioRepository{
  final AudioPlayer _audioPlayer=AudioPlayer();
  Duration? duration,position;

 Future<AudioPlayer> pickAudio() async{
   try{ 

    final result=await FilePicker.platform.pickFiles(
      allowedExtensions: [StringHelp.map3],
      type: FileType.custom
    );
    _audioPlayer.play(UrlSource(result!.files.single.path!));
    _audioPlayer.resume();

    
    }
    catch(e){
      throw e;
    }
    
  return _audioPlayer;
  }

   pickPosition(){
    _audioPlayer.onPositionChanged.listen((p) {
      position=p;

    });

    _audioPlayer.onDurationChanged.listen((Duration d) {
        duration=d;
});

  return [duration,position,_audioPlayer];
  }



}