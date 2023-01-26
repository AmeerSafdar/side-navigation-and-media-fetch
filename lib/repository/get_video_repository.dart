// ignore_for_file: prefer_typing_uninitialized_variables, unused_field, use_rethrow_when_possible

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class GetVideoRepo{
    late VideoPlayerController _videoPlayerController;
    File? video;
    Uint8List?  _thumNailImg ;
    XFile?  videPicked;
 Future<VideoPlayerController?> pickVideo(ImageSource imageType) async {
    
    try {
       
       videPicked=await ImagePicker().pickVideo(source: imageType);
       File tempvideo = File(videPicked!.path);
        video = tempvideo;
       _videoPlayerController=VideoPlayerController.file(video!)..initialize().then((_){
         _videoPlayerController.setLooping(false);
          _videoPlayerController.play();
       });
      
    } catch (error) {
        throw error;
    }
   return _videoPlayerController;
 
  }

  pause(){
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
    }
  }
  play(){
    if (!_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
  }

Future<Uint8List?> getThumbNail() async{
      _thumNailImg = await VideoThumbnail.thumbnailData(
          video: video!.path,
          imageFormat: ImageFormat.JPEG,
          maxWidth: 128,
          quality: 25,
);
  return _thumNailImg;
  }

  

}