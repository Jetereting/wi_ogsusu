import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:device_info/device_info.dart';
import 'package:wi_ogsusu/extension/token_master.dart';

class Video extends StatefulWidget{

  String _url;

  Video(String url){
    this._url = url;
  }

  @override
  VideoState createState() => VideoState(_url);

}

class VideoState extends State<Video>{

  VideoPlayerController _controller;
  bool _isPlaying = false;

  String _url;

  VideoState(String url){
    this._url = url;
  }

  @override
  void initState() {
    super.initState();
      playStream(_url);
  }

  void playStream(String url){
    print("play stream: $url");
    _controller = VideoPlayerController.network(
//      'http://resource.ldlegacy.com:8033/videos/ad/1533018060579.mp4',
//      'http://us11.protv.company:8000/live/fLYaKCMYET/Ohsccmf14v/1013013.ts?token=ea470047f6d24d20fe2bac02f9f01f7b',
      url,
    )
      ..setLooping(true)
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _controller.play();
        setState(() {

        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Center(
            child: _controller.value.initialized
                ? AspectRatio(
              aspectRatio: 16/9,
              child: VideoPlayer(_controller),
            )
                : Container(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.white,),
            ),
          ),
          Center(
            child: _isPlaying? Container():
            new Container(
              alignment: Alignment.center,
              child: new CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.yellow)
              ),
            ),
//            child: _isPlaying ? Container() : FloatingActionButton(
//              backgroundColor: Colors.grey,
//              onPressed: _controller.value.isPlaying
//                  ? _controller.pause
//                  : _controller.play,
//              child: Icon(
//                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//              ),
//            ),
          ),
        ],
      )
    );
  }

}