import 'package:image_picker/image_picker.dart';

abstract class GetVideo {}

class FetchVideo extends GetVideo{
  final ImageSource src;
  FetchVideo(this.src);
}
class Closed extends GetVideo{}
