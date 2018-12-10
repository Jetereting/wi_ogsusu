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


class MediaEpgDetailPage extends StatefulWidget {

  EpgInfo _epgInfo;

  MediaEpgDetailPage(EpgInfo epgInfo) {
	this._epgInfo = epgInfo;
  }

  @override
  _MediaEpgDetailPageState createState() =>
	  new _MediaEpgDetailPageState(_epgInfo);
}

class _MediaEpgDetailPageState extends State<MediaEpgDetailPage> {

  bool _detailLoading = false;
  bool _channelLoading = false;
  EpgInfo _epgInfo;
  List<EpgDetailInfo> _epgDetailList = [];
  ChannelInfo _channelInfo;
  String localeStr = "en_US";
  VideoPlayerController _videoPlayerController;

  _MediaEpgDetailPageState(EpgInfo epgInfo) {
		this._epgInfo = epgInfo;
  }

  Future<void> _getEpgDetailData() async {
		setState(() {
			_detailLoading = true;
		});
		String url = Constant.URL_EPG_DETAIL + _epgInfo.channelId;
		HttpMaster.instance.get(url).then((result) {
			if (!mounted) {
				return;
			}
			setState(() {
				_detailLoading = false;
			});
			int code = result.code;
			if (code != 200) {
				print(result.msg);
				setState(() {
					_epgDetailList = [
						EpgDetailInfo(
								_epgInfo.channelId,
								TimeUtil.currentTimeSeconds(),
								TimeUtil.currentTimeSeconds() + 3600,
								"Local Programming...")
					];
				});
				return;
			}
			setState(() {
				List dataList = result.data;
				var list = dataList.map((dataStr) {
					return new EpgDetailInfo.fromJson(dataStr);
				}).toList();
				if(list.length > 0) {
					_epgDetailList = list;
				}
			});
		});
  }

  Future<void> _getChannelData() async {
	setState(() {
	  _channelLoading = true;
	});
	String url = Constant.URL_CHANNEL + _epgInfo.channelId;
	HttpMaster.instance.get(url).then((result) {
	  if (!mounted) {
			return;
	  }
	  setState(() {
			_channelLoading = false;
	  });
	  int code = result.code;
	  if (code != 200) {
		print(result.msg);
			return;
	  }
	  setState(() {
			var data = result.data;
			_channelInfo = ChannelInfo.fromJson(data);
			getStreamToken().then((token) {
				if (token != null && token.length > 0) {
				setState(() {
					_channelLoading = false;
					_channelInfo.url = _channelInfo.url + "?token=$token";
				});
				}
			});
	  });
	});
  }

  @override
  void initState() {
		super.initState();
		Screen.keepOn(true);
		_getEpgDetailData();
		_getChannelData();
  }

  @override
  void dispose() {
		_videoPlayerController.dispose();
		print("dispose");
		super.dispose();
  }

  Widget buildEpgPlayWidget(ChannelInfo channelInfo) {
	var deviceSize = MediaQuery.of(context).size;
	if (channelInfo == null || _channelLoading) {
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
	  channelInfo.url,
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

  Widget buildEpgDetailListItem(EpgDetailInfo epgDetailInfo, Size deviceSize) {
		localeStr = Translations.of(context).currentLanguage +
			"_" +
			Translations.of(context).currentCountry;
		var currentSeconds = TimeUtil.currentTimeSeconds();
		Color bgColor = Colors.black;
		if (currentSeconds > epgDetailInfo.startTime &&
			currentSeconds < epgDetailInfo.endTime) {
			bgColor = Colors.green[400];
		}
		return new GestureDetector(
			onTap: () {},
			child: new Container(
				padding: EdgeInsets.all(3.0),
				child: new Row(
				children: <Widget>[
					Container(
					width: deviceSize.width / 5,
					alignment: Alignment.centerLeft,
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						crossAxisAlignment: CrossAxisAlignment.center,
						children: <Widget>[
						Text(
							TimeUtil.toStrTimeWithLocaleStr(
								epgDetailInfo.startTime, localeStr),
							maxLines: 1,
							softWrap: true,
							overflow: TextOverflow.ellipsis,
							style: TextStyle(
							color: Colors.grey,
							fontSize: 11.0,
							),
						),
						Text(
							TimeUtil.toStrTimeWithLocaleStr(
								epgDetailInfo.endTime, localeStr),
							maxLines: 1,
							softWrap: true,
							overflow: TextOverflow.ellipsis,
							style: TextStyle(
							color: Colors.grey,
							fontSize: 11.0,
							),
						),
						],
					),
					),
					Container(
						margin: EdgeInsets.only(left: 3.0, right: 8.0),
						width: 1.0,
						height: 26.0,
						color: Colors.grey,
					),
					Expanded(
					child: Text(
						epgDetailInfo.label,
						maxLines: 2,
						softWrap: true,
						overflow: TextOverflow.ellipsis,
						style: TextStyle(
						color: bgColor,
						),
					),
					),
				],
				)),
		);
  }

  Widget buildEpgDetailListWidget(List<EpgDetailInfo> _epgDetailList) {
		var deviceSize = MediaQuery.of(context).size;
		return new Expanded(
			child: _detailLoading
				? new Container(
					alignment: Alignment.center,
					child: new CircularProgressIndicator(
						valueColor: AlwaysStoppedAnimation(Colors.red)),
				)
				: new RefreshIndicator(
					child: new ListView.builder(
						padding: EdgeInsets.all(3.0),
						itemCount: _epgDetailList.length * 2,
						itemBuilder: (BuildContext context, int index) {
							if (index.isOdd) {
							return const Divider();
							}
							return buildEpgDetailListItem(
								_epgDetailList[index ~/ 2], deviceSize);
						},
					),
					onRefresh: _getEpgDetailData,
				),
		);
  }

  @override
  Widget build(BuildContext context) {
		return new Scaffold(
			appBar: AppBar(
				backgroundColor: Colors.black,
				centerTitle: false,
				title: Text(_epgInfo.label),
			),
			body: new Container(
				width: double.infinity,
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: <Widget>[
					buildEpgPlayWidget(_channelInfo),
					buildEpgDetailListWidget(_epgDetailList),
					],
				),
			),
		);
  }
}
