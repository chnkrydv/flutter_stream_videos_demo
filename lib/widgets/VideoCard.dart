import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream/widgets/VideoControls.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  VideoCard({
    @required this.url,
    @required this.title,
    @required this.description,
  });

  final String url;
  final String title;
  final String description;

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  VideoPlayerController videoController;
  bool videoInitialized;
  bool playing;
  double aspectRatio;
  Duration length;
  Duration position;

  @override
  void initState() {
    super.initState();
    this.videoInitialized = false;
    this.playing = false;
    this.length = Duration.zero;
    this.position = Duration.zero;
    this.initializePlayer();
  }

  void initializePlayer() {
    this.videoController = VideoPlayerController.network(this.widget.url);
    this.videoController.initialize().then((value) => this.onInitialized());
    this.videoController.addListener(this.onVideoValueChange);
  }

  void onInitialized() {
    setState(() {
      final videoValue = this.videoController.value;
      this.videoInitialized = true;
      this.aspectRatio = videoValue.aspectRatio;
      this.length = videoValue.duration;
      print('video initialized');
    });
  }

  void onVideoValueChange() {
    setState(() {
      this.position = this.videoController.value.position;
    });
  }

  void togglePlayPause() {
    if (this.videoController.value.isPlaying) {
      this.videoController.pause();
    } else {
      this.videoController.play();
    }
    setState(() => this.playing = !this.playing);
  }

  void seek(bool forward) {
    final int tenSeconds = forward ? (10) : (-10);
    final newPosition = Duration(seconds: this.position.inSeconds + tenSeconds);
    this.videoController.seekTo(newPosition);
  }

  void rewind() {
    this.videoController.seekTo(Duration.zero);
    this.videoController.play();
    setState(() => this.playing = true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 20),
      decoration: BoxDecoration(
        color: Color(0xfff2f8ff),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(1, 2),
          ),
          BoxShadow(
            color: Colors.white,
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(-2, -3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              this.videoInitialized
                  ? AspectRatio(
                      aspectRatio: videoController.value.aspectRatio,
                      child: VideoPlayer(videoController),
                    )
                  : SizedBox.shrink(),
              VideoControls(
                loading: this.videoInitialized == false,
                aspectRatio: this.aspectRatio,
                length: this.length,
                position: this.position,
                onPlayPauseToggle: this.togglePlayPause,
                onForward: () => this.seek(true),
                onReplay: () => this.seek(false),
                onRewindVideo: this.rewind,
                playing: this.playing,
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 5, right: 15, left: 15),
            child: Text(
              this.widget.title ?? 'Space view',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 15, left: 15),
            child: Text(
              this.widget.description ??
                  'Some description about video, which no one would be interested in but anyways it fills the space in the component',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
