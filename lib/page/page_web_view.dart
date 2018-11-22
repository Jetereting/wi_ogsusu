import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wi_ogsusu/widget/page_loading_list9.dart';

class WebViewPage extends StatefulWidget {

  String _url;

  WebViewPage(String url){
    this._url = url;
  }

  @override
  _WebViewPageState createState() => new _WebViewPageState(_url);
}

class _WebViewPageState extends State<WebViewPage> {

  String title = "";
  String _url;
  bool loading = true;
  double progress = 0.3;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();


  _WebViewPageState(String url){
    this._url = url;
  }

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print(url);
    });
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      print(state.type);
      if(state.type == WebViewState.startLoad){
        setState(() {
          progress = 0.3;
          loading = true;
        });
      }else if(state.type == WebViewState.finishLoad){
        setState(() {
          progress = 1.0;
          loading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: _url,
      appBar: new AppBar(
        backgroundColor: Color(0xFF0A0126),
        title: Text(
            loading? 'loading...': ''
        ),
        bottom: loading? PreferredSize(
          child: Container(
            height: 3.0,
            child: LinearProgressIndicator(value: progress,),
          ),
          preferredSize: Size.fromHeight(3.0),
        ): PreferredSize(
          child: SizedBox(height: 0.0,),
          preferredSize: Size.fromHeight(0.0),
        ),
        actions: <Widget>[
          new IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: (){
              if (flutterWebviewPlugin != null) {
                flutterWebviewPlugin.goBack();
              }
            },
          ),
          new IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: (){
              if (flutterWebviewPlugin != null) {
                flutterWebviewPlugin.goForward();
              }
            },
          ),
          new IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: (){
              if (flutterWebviewPlugin != null) {
                flutterWebviewPlugin.reload();
              }
            },
          ),
        ],
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: LoadingList9Page(),
    );
  }

}