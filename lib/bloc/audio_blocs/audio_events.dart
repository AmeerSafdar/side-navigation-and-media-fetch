
import 'package:flutter/cupertino.dart';
abstract class GetAudio {}
class FetchAudio extends GetAudio{
  BuildContext context;
  FetchAudio(this.context);
}
class Closed extends GetAudio{}
class GetDuration extends GetAudio{}
class Play extends GetAudio{}
class Pause extends GetAudio{}
class Drag extends GetAudio{
  Duration? duration;
  Drag(
    this.duration
  );
}


