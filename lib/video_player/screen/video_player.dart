/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
///VideoPlayerWidget to display all the videos as a list
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///

import 'package:flutter/material.dart';
import 'package:untitled/video_player/screen/video_widget.dart';
import 'package:video_player/video_player.dart';

import '../model/video.dart';

class VideoPlayerWidget extends StatefulWidget {
  VideoPlayerWidget({Key? key, required this.searchItemName}) : super(key: key);

  late String searchItemName;

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  late List<Video> videos = [];
  late List<Video> videosList = [];

  @override
  void initState() {
    super.initState();
    listOfVideos();
  }

  void listOfVideos() {
    Video itemOne = Video();
    itemOne.videoName = 'Bubble gum girl';
    itemOne.commentTurnedONOff = true;
    itemOne.videoCategory = Category.Funny;
    itemOne.videoPath =
        'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4';
    videos.add(itemOne);
    Video itemSecond = Video();
    itemSecond.videoName = 'For Bigger Blazes';
    itemSecond.commentTurnedONOff = true;
    itemSecond.videoCategory = Category.Advertisement;
    itemSecond.videoPath =
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4';
    videos.add(itemSecond);
    Video itemThird = Video();
    itemThird.videoName = 'Big Buck Bunny';
    itemThird.commentTurnedONOff = true;
    itemThird.videoCategory = Category.Movie;
    itemThird.videoPath =
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';
    videos.add(itemThird);
    Video itemFourth = Video();
    itemFourth.videoName = 'Elephant Dream';
    itemFourth.commentTurnedONOff = true;
    itemFourth.videoCategory = Category.Movie;
    itemFourth.videoPath =
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4';
    videos.add(itemFourth);
    Video itemFifth = Video();
    itemFifth.videoName = 'Subaru Outback On Street And Dirt';
    itemFifth.commentTurnedONOff = true;
    itemFifth.videoCategory = Category.Advertisement;
    itemFifth.videoPath =
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4';
    videos.add(itemFifth);
    if (widget.searchItemName == '') {
      videosList = videos;
    } else {
      for (var item in videos) {
        if ((item.videoName.toLowerCase())
            .contains(widget.searchItemName.toLowerCase())) {
          videosList.add(item);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return videosList.isNotEmpty
        ? Expanded(
            child: ListView.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            itemCount: videosList.length,
            itemBuilder: (context, index) {
              var result = videosList[index];
              return VideoWidget(
                item: result,
                videoList: videosList,
              );
            },
          ))
        : Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
            child: const Center(child: Text('No results')),
          );
  }
}
