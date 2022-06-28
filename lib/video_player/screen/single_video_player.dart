/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
///SingleVideoPlayer to display the videos and their comments
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/video_player/model/comments.dart';
import 'package:untitled/video_player/screen/related_videos.dart';

import 'package:video_player/video_player.dart';
import '../../login/screen/login.dart';
import '../model/video.dart';

class SingleVideoPlayer extends StatefulWidget {
  SingleVideoPlayer({Key? key, required this.item, required this.videoList})
      : super(key: key);

  List<Video> videoList;
  final Video item;

  @override
  _SingleVideoPlayerState createState() => _SingleVideoPlayerState();
}

class _SingleVideoPlayerState extends State<SingleVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  late TextEditingController commentController;
  String commentText = 'Disable Comment';
  late List<Video> relatedVideos;

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
    relatedVideos = findRelatedVideos(widget.videoList, widget.item);
  }

  List<Video> findRelatedVideos(
      List<Video> videosListings, Video itemSelected) {
    List<Video> videosListFinal = [];
    for (var item in videosListings) {
      if (itemSelected.videoCategory == item.videoCategory && item != itemSelected) {
        videosListFinal.add(item);
      }
    }
    return videosListFinal;
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double heightOfVideo = MediaQuery.of(context).size.height / 2;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white70),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          flexibleSpace: const Image(
            image: AssetImage('assets/images/login_image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAlertDialog(context);
          },
          backgroundColor: Colors.grey,
          child: const Icon(Icons.logout_rounded),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _videoPlayerController.value.isInitialized
                  ? Center(
                      child: Stack(
                        children: [
                          SizedBox(
                            height: heightOfVideo,
                            width: MediaQuery.of(context).size.width / 0.5,
                            child: AspectRatio(
                                aspectRatio:
                                    _videoPlayerController.value.aspectRatio,
                                child: VideoPlayer(_videoPlayerController)),
                          ),
                          Center(
                            child: Padding(
                              padding:
                                  EdgeInsets.only(top: heightOfVideo / 2),
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
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: Text(widget.item.videoName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Text(
                        commentText,
                        style: const TextStyle(fontSize: 12,color: Colors.white54),
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
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
                                        var result =
                                            widget.item.comments[index];
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                        comment.comment =
                                            commentController.text;
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
              ),
              const SizedBox(
                height: 15,
              ),
              relatedVideos.isNotEmpty
                  ? RelatedVideoWidget(
                      items: relatedVideos,
                      videoList: widget.videoList,
                    )
                  : Container()
            ],
          ),
        ));
  }

  signOut() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the button
    Widget okButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        signOut();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Alert"),
      content: const Text("Are you sure you want to logout"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
