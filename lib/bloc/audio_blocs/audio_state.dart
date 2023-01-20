import 'package:audioplayers/audioplayers.dart';

enum AudioStatus { initial, success, failure }

class AudioStates {
   AudioStates({
    this.status = AudioStatus.initial,
    this.audio ,
    this.duration = Duration.zero,
    this.position = Duration.zero
  }); 
  final AudioStatus status;
  final AudioPlayer? audio;
  final Duration duration;
   Duration position;
    AudioStates copyWith({
    AudioStatus? status,
    AudioPlayer? audio,
    Duration? duration,
     Duration? position,
  }) {
    return AudioStates(
      status: status ?? this.status,
      audio: audio ?? this.audio,
      duration: duration ?? this.duration,
      position: position ?? this.position
    );
  }
}