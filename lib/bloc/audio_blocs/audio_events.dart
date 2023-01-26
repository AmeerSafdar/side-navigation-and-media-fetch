abstract class GetAudio {}

class FetchAudio extends GetAudio{
  FetchAudio();
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


