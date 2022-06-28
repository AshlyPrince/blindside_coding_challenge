/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
///VideoWidget to display the videos and their comments
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/video_player/model/comments.dart';
import 'package:untitled/video_player/screen/single_video_player.dart';

import 'package:video_player/video_player.dart';
import '../model/video.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({Key? key, required this.item, required this.videoList})
      : super(key: key);

  final Video item;
  final List<Video> videoList;

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _videoPlayerController;
  late TextEditingController commentController;
  String commentText = 'Disable Comment';

  @override
  void initState() {
    super.initState();
    commentController = TextEditingController();
    _videoPlayerController =
        VideoPlayerController.network(widget.item.videoPath)
          ..initialize().then((_) {
            setState(() {});
            _videoPlayerController.pause();
          });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double heightOfVideo = MediaQuery.of(context).size.height / 3;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          child: Text(widget.item.videoName,
              style: const TextStyle(color: Colors.white70, fontSize: 17)),
        ),
        _videoPlayerController.value.isInitialized
            ? Center(
                child: Stack(
                  children: [
                    SizedBox(
                      height: heightOfVideo,
                      width: MediaQuery.of(context).size.width / 0.5,
                      child: AspectRatio(
                          aspectRatio: _videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController)),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: heightOfVideo / 2.4),
                        child: InkWell(
                          child: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 60,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SingleVideoPlayer(
                                  item: widget.item,
                                  videoList: widget.videoList,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox(
                height: heightOfVideo,
                width: MediaQuery.of(context).size.width / 0.5,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 20),
        ),
      ],
    );
  }
}
