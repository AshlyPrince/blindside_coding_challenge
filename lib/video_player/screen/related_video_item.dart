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

class RelatedVideoItemWidget extends StatefulWidget {
  RelatedVideoItemWidget(
      {Key? key, required this.item, required this.videoList})
      : super(key: key);

  final Video item;
  List<Video> videoList;

  @override
  _RelatedVideoItemWidgetState createState() => _RelatedVideoItemWidgetState();
}

class _RelatedVideoItemWidgetState extends State<RelatedVideoItemWidget> {
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
    double heightOfVideo = MediaQuery.of(context).size.height / 7;

    return InkWell(
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
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Row(
          children: [
            _videoPlayerController.value.isInitialized
                ? Expanded(
              flex: 1,
                  child: Center(
                      child: Stack(
                        children: [
                          SizedBox(
                            height: heightOfVideo,
                            width: MediaQuery.of(context).size.width / 4,
                            child: AspectRatio(
                                aspectRatio:
                                    _videoPlayerController.value.aspectRatio,
                                child: VideoPlayer(_videoPlayerController)),
                          ),
                        ],
                      ),
                    ),
                )
                : Expanded(
              flex: 1,
                  child: SizedBox(
                      height: heightOfVideo,
                      width: MediaQuery.of(context).size.width / 4,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 14, right: 14),
                child: Text(
                  widget.item.videoName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
