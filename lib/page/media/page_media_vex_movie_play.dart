import 'package:flutter/material.dart';
import 'package:wi_ogsusu/locale/translations.dart';
import 'package:dio/dio.dart';
import 'package:wi_ogsusu/constant.dart';
import 'package:wi_ogsusu/entities/epg_info.dart';
import 'package:wi_ogsusu/entities/epg_detail_info.dart';
import 'package:wi_ogsusu/common/utils/time_util.dart';
import 'package:wi_ogsusu/entities/channel_info.dart';
import 'dart:async';
import 'package:wi_ogsusu/extension/token_master.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:wi_ogsusu/common/http_master.dart';
import 'package:screen/screen.dart';
import 'package:wi_ogsusu/common/utils/time_util.dart';


class VexMoviePlayPage extends StatefulWidget {

  String url;
	String label;

	VexMoviePlayPage(this.url, this.label);

	@override
	_VexMoviePlayPageState createState() =>
	  new _VexMoviePlayPageState(url, label);
}

class _VexMoviePlayPageState extends State<VexMoviePlayPage> {

  String url;
  String label;
  String localeStr = "en_US";
  VideoPlayerController _videoPlayerController;

	_VexMoviePlayPageState(this.url, this.label);

  @override
  void initState() {
		super.initState();
		Screen.keepOn(true);
  }

  @override
  void dispose() {
    _videoPlayerController.pause();
		_videoPlayerController.dispose();
		super.dispose();
  }

  Widget buildPlayWidget() {
	var deviceSize = MediaQuery.of(context).size;
	if (url == null || url.length <= 0) {
	  return new Container(
			width: deviceSize.width,
			height: deviceSize.width / 16 * 9,
			color: Colors.black,
			child: Image.asset(
				'res/img/hold1.jpg',
				fit: BoxFit.cover,
			),
	  );
	}
	_videoPlayerController = VideoPlayerController.network(
	  url,
	);
	return new Chewie(
	  _videoPlayerController,
		aspectRatio: 16 / 9,
		autoPlay: true,
		looping: true,
		materialProgressColors: ChewieProgressColors(
			playedColor: Colors.deepOrange,
			bufferedColor: Colors.deepOrange[100],
			handleColor: Colors.deepOrange,
	  ),
	  placeholder: Image.asset('res/img/hold1.jpg'),
	);
  }


  @override
  Widget build(BuildContext context) {
		return new Scaffold(
			appBar: AppBar(
				backgroundColor: Colors.black,
				centerTitle: false,
				title: Text(label),
			),
			body: new Container(
				width: double.infinity,
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: <Widget>[
						buildPlayWidget(),
					],
				),
			),
		);
  }
}
