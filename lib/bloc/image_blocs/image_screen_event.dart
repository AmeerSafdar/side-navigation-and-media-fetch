import 'package:image_picker/image_picker.dart';

abstract class GetImage {}

class FetchImage extends GetImage{
  final ImageSource src;
  FetchImage(this.src);
}
class Closed extends GetImage{}
