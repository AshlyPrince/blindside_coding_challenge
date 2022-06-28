/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
///Video model class
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///

import 'package:untitled/video_player/model/comments.dart';

enum Category {
  Funny,
  Movie,
  Advertisement,
}

class Video {
  late String videoName;
  List<Comment> comments = [];

  late Category videoCategory;

  late bool commentTurnedONOff;

  late String videoPath;
}
