/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
///VideoWidget to display the videos and their comments
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/video_player/model/comments.dart';

import 'package:video_player/video_player.dart';
import '../model/video.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({Key? key, required this.item}) : super(key: key);

  final Video item;

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
                          child: Icon(
                            _videoPlayerController.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: 60,
                          ),
                          onTap: () {
                            _videoPlayerController.value.isPlaying
                                ? _videoPlayerController.pause()
                                : _videoPlayerController.play();
                            setState(() {});
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: widget.item.commentTurnedONOff
                  ? Column(children: [
                      widget.item.comments.isNotEmpty
                          ? ListView.builder(
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.all(16),
                              shrinkWrap: true,
                              itemCount: widget.item.comments.length,
                              itemBuilder: (context, index) {
                                var result = widget.item.comments[index];
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '[${result.commentTime}]  ',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.white54),
                                    ),
                                    Text(
                                      result.comment,
                                      style: const TextStyle(
                                          fontSize: 17.0,
                                          color: Colors.white60),
                                    ),
                                  ],
                                );
                              },
                            )
                          : Container(),
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'Comment',
                          hintStyle: const TextStyle(
                              fontSize: 17.0, color: Colors.black54),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.add_comment),
                            onPressed: () {
                              setState(() {
                                Comment comment = Comment();
                                comment.comment = commentController.text;
                                DateTime now = DateTime.now();
                                String formattedDate =
                                    DateFormat('hh:mm').format(now);
                                comment.commentTime = formattedDate;
                                widget.item.comments.add(comment);
                                commentController.clear();
                              });
                            },
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        controller: commentController,
                        minLines: 1,
                        maxLines: 5,
                      )
                    ])
                  : Container(),
            )
          ],
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 3, child: Container()),
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Text(
                    commentText,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Transform.scale(
                  scale: 0.7,
                  child: CupertinoSwitch(
                    activeColor: CupertinoColors.inactiveGray,
                    thumbColor: CupertinoColors.black,
                    value: widget.item.commentTurnedONOff,
                    onChanged: (value) {
                      setState(() {
                        if (value) {
                          commentText = 'Disable comment';
                        } else {
                          commentText = 'Enable comment';
                        }
                        widget.item.commentTurnedONOff = value;
                      });
                    },
                  ),
                ),
              ),
            ]),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
