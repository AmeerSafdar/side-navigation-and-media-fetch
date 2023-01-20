import 'dart:io';

enum ImageStatus { initial, success, failure }

class ImageStates {
  const ImageStates({
    this.status = ImageStatus.initial,
    this.img ,
  });
  final ImageStatus status;
  final File? img;

    ImageStates copyWith({
    ImageStatus? status,
    File? img,
  }) {
    return ImageStates(
      status: status ?? this.status,
      img: img ?? this.img
    );
  }
}