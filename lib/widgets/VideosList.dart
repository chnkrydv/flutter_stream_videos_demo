import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream/content/videoURLs.dart';
import 'package:stream/widgets/VideoCard.dart';

class VideosList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color(0xffccd4dd),
        padding: EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: videoUrls
              .map((u) => VideoCard(
                    url: u["url"],
                    title: u["title"],
                    description: u["description"],
                  ))
              .toList(),
        ),
      ),
    );
  }
}
