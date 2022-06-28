/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
///VideoWidget to display the videos and their comments
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/video_player/model/comments.dart';
import 'package:untitled/video_player/screen/related_video_item.dart';
import 'package:untitled/video_player/screen/single_video_player.dart';

import 'package:video_player/video_player.dart';
import '../model/video.dart';

class RelatedVideoWidget extends StatefulWidget {
  RelatedVideoWidget({Key? key, required this.items, required this.videoList})
      : super(key: key);

  final List<Video> items;
  List<Video> videoList;

  @override
  _RelatedVideoWidgetState createState() => _RelatedVideoWidgetState();
}

class _RelatedVideoWidgetState extends State<RelatedVideoWidget> {
  late TextEditingController commentController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
          child: const Text('Related videos',
              style: TextStyle(color: Colors.white70, fontSize: 17)),
        ),
        widget.items.isNotEmpty
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics (),
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  var result = widget.items[index];
                  return RelatedVideoItemWidget(
                    item: result,
                    videoList: widget.videoList,
                  );
                },
              )
            : Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3),
                child: const Center(child: Text('No results')),
              ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
