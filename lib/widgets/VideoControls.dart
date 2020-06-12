import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoControls extends StatefulWidget {
  const VideoControls({
    @required this.onPlayPauseToggle,
    @required this.onReplay,
    @required this.onForward,
    @required this.onRewindVideo,
    @required this.length,
    @required this.position,
    this.loading = true,
    this.aspectRatio,
    this.showControls = false,
    this.playing = false,
  });

  final Function onPlayPauseToggle;
  final Function onReplay;
  final Function onForward;
  final Function onRewindVideo;
  final Duration length;
  final Duration position;
  final bool loading;
  final double aspectRatio;
  final bool showControls;
  final bool playing;

  @override
  _VideoControlsState createState() => _VideoControlsState();
}

class _VideoControlsState extends State<VideoControls> {
  bool videoEnded() {
    final length = this.widget.length.inSeconds;
    final position = this.widget.position.inSeconds;
    return position >= length;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: this.widget.aspectRatio ?? (16 / 9),
      child: Container(
        alignment: Alignment.center,
        color: this.widget.loading ? Color(0xff223350) : Colors.transparent,
        child: Visibility(
          visible: this.widget.loading,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            strokeWidth: 2,
          ),
          replacement: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Visibility(
                    visible: this.videoEnded(),
                    child: GestureDetector(
                      onTap: this.widget.onRewindVideo,
                      child: Icon(
                        Icons.replay,
                        color: Colors.white,
                        size: 56,
                      ),
                    ),
                    replacement: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: this.widget.onReplay,
                          child: Visibility(
                            visible: this.widget.playing,
                            child: Icon(
                              Icons.replay_10,
                              color: Colors.white,
                              size: 42,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: this.widget.onPlayPauseToggle,
                          child: Visibility(
                            visible: this.widget.playing == false,
                            child: Icon(
                              Icons.play_circle_outline,
                              color: Colors.white,
                              size: 56,
                            ),
                            replacement: Icon(
                              Icons.pause_circle_outline,
                              color: Colors.white,
                              size: 56,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: this.widget.onForward,
                          child: Visibility(
                            visible: this.widget.playing,
                            child: Icon(
                              Icons.forward_10,
                              color: Colors.white,
                              size: 42,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: LinearProgressIndicator(
                  backgroundColor:
                      this.widget.playing ? Colors.white54 : Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      this.widget.playing ? Colors.white : Colors.transparent),
                  value: this.widget.length == Duration.zero
                      ? 0.0
                      : (this.widget.position.inSeconds) /
                          (this.widget.length.inSeconds),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
