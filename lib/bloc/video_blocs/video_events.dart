import 'package:flutter/cupertino.dart';

abstract class GetVideo {}

class FetchVideo extends GetVideo{
  BuildContext context;
  FetchVideo(this.context);
}
class Closed extends GetVideo{}
class Play extends GetVideo{}
class Pause extends GetVideo{}
