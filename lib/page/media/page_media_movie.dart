import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wi_ogsusu/constant.dart';
import 'package:wi_ogsusu/entities/movie_info.dart';
import 'page_media_movie_detail.dart';
import 'package:wi_ogsusu/widget/page_loading_list7.dart';

class MediaMoviePage extends StatefulWidget{

  @override
  _MediaMoviePageState createState() => new _MediaMoviePageState();

}

class _MediaMoviePageState extends State<MediaMoviePage>  with AutomaticKeepAliveClientMixin{

  bool _loading = false;
  List<MovieInfo> movieList = [];
  Dio dio = new Dio();
  var total = 0;
  var nextPage = 1;
  var isLastPage = true;

  @override
  bool get wantKeepAlive => true;

  void showErrorNotice(String msg){
    showModalBottomSheet<void>(context: context, builder: (BuildContext context) {
      return new Container(
        child: new Padding(
          padding: const EdgeInsets.all(12.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Icon(Icons.highlight_off, color: Colors.red,),
              new Text(' ' + msg,
                textAlign: TextAlign.left,
                style: new TextStyle(
                  color: Colors.red,
                  fontSize: 16.0
                )
              ),
            ],
          ),
        )
      );
    });
  }

  Future<void> _getMoviesData() async{
    setState(() {
      _loading = true;
    });
    String url = Constant.URL_MOVIES + '?pageNum=$nextPage&pageSize=60';
    Response response = await dio.get(url).catchError((DioError e){
      print("DioError: " + e.toString());
    });
    int code = response.data['code'];
    if(code == 200) {
      total = response.data['data']['total'];
      isLastPage = response.data['data']['isLastPage'];
      nextPage = response.data['data']['nextPage'];
      List data = response.data['data']['list'];
      if(mounted) {
        setState(() {
          _loading = false;
          List<MovieInfo> dataList = data.map((dataStr) {
            return MovieInfo.fromJson(dataStr);
          }).toList();
          if(movieList.length <= 0){
            movieList = dataList;
          }else{
            movieList.addAll(dataList);
          }
//          print(movieList);
        });
      }
    }else{
      print(response.data['msg']);
      if(mounted) {
        setState(() {
          _loading = false;
        });
      }
//      showErrorNotice(response.data['msg']);
    }
  }

  @override
  void initState() {
    super.initState();
    _getMoviesData();
  }

  void itemClick(MovieInfo movieInfo){
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
      return new MediaMovieDetailPage(movieInfo);
    }));
  }

  Widget buildMovieListItem(MovieInfo movieInfo){
    return new GestureDetector(
      onTap: (){
        itemClick(movieInfo);
      },
      child: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              child: new AspectRatio(
                aspectRatio: 9.0 / 14.0,
                child: new Container(
                  child: FadeInImage.assetNetwork(
                    placeholder: 'res/img/hold.jpg',
                    image: movieInfo.poster,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Text(
              movieInfo.title,
              textAlign: TextAlign.start,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            new Expanded(child: SizedBox()),
            Row(
              children: <Widget>[
                Text(
                  movieInfo.voteAverage.toString(),
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.deepOrange,
                  ),
                ),
                new Expanded(child: SizedBox()),
                Text(
                  movieInfo.releaseDate,
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    dio.clear();
  }


  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 4.0),
      child: _loading && movieList.length <= 0 ?
      LoadingList7Page() :
      new RefreshIndicator(
        onRefresh: _getMoviesData,
        child: new GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 4.0,
          padding: const EdgeInsets.all(4.0),
          childAspectRatio: 9/18,
          children: movieList.map((MovieInfo movieInfo) {
            return buildMovieListItem(movieInfo);
          }).toList(),
        ),
      )
    );
  }


}