
import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

enum VideoStatus { initial, success, failure, play, pause, cameraDenied, cameraPermanentDenied, galleryDenied, galleryPermanentDenied }

class VideoStates {
  const VideoStates({
    this.status = VideoStatus.initial,
    this.video ,
    this.thumbnailImg
  });
  final VideoStatus status;
  final VideoPlayerController? video;
  final Uint8List? thumbnailImg;

    VideoStates copyWith({
    VideoStatus? status,
    VideoPlayerController? video,
    Uint8List? thumbnailImg
  }) {
    return VideoStates(
      status: status ?? this.status,
      video: video ?? this.video,
      thumbnailImg: thumbnailImg ?? this.thumbnailImg
    );
  }
}