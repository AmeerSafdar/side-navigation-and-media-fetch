
import 'package:flutter/cupertino.dart';

abstract class GetImage {}

class FetchImage extends GetImage{
  BuildContext context;
  FetchImage(this.context);
}
class Closed extends GetImage{}
