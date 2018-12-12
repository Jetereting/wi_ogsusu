import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:wi_ogsusu/constant.dart';
import 'package:wi_ogsusu/entities/movie_info.dart';
import 'package:wi_ogsusu/entities/movie_detail_info.dart';

class MediaMovieDetailPage extends StatefulWidget{

  MovieInfo _movieInfo;

  MediaMovieDetailPage(MovieInfo movieInfo){
    _movieInfo = movieInfo;
  }

  @override
  MediaMovieDetailPageState createState() => new MediaMovieDetailPageState(_movieInfo);

}

class MediaMovieDetailPageState extends State<MediaMovieDetailPage>{

  bool _loading = false;
  MovieInfo _movieInfo;
  MovieDetailInfo _movieDetailInfo;
  Dio dio = new Dio();


  MediaMovieDetailPageState(MovieInfo movieInfo){
    _movieInfo = movieInfo;
  }


  Future<void> _getMovieDetailData(MovieInfo movieInfo) async{
    setState(() {
      _loading = true;
    });
    String url = Constant.URL_MOVIE_DETAIL + movieInfo.movieId.toString();
    Response response = await dio.get(url).catchError((DioError e){
      print("DioError: " + e.toString());
    });
    if(response == null){
      return;
    }
    int code = response.data['code'];
    if(code == 200) {
      var data = response.data['data'];
      print(data);
      if(mounted) {
        setState(() {
          _loading = false;
          _movieDetailInfo = MovieDetailInfo.fromJson(data);
        });
      }
    }else{
      print(response.data['msg']);
      if(mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getMovieDetailData(_movieInfo);
  }

  @override
  void dispose() {
    super.dispose();
    dio.clear();
  }


  Widget buildMovieDetail(MovieDetailInfo movieDetailInfo){
    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16/9,
          child: FadeInImage.assetNetwork(
            placeholder: 'res/img/hold.jpg',
            image: movieDetailInfo.backdropPath,
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(3.0),
          child: new Row(
            children: <Widget>[
              Text(
                'Status: ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                movieDetailInfo.status,
                style: TextStyle(
                  color: Colors.teal,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(3.0),
          child: new Row(
            children: <Widget>[
              Text(
                'ReleaseDate: ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                movieDetailInfo.releaseDate,
                style: TextStyle(
                  color: Colors.brown,
                  fontStyle: FontStyle.italic
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(3.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Overview: ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(
                child: Text(
                  movieDetailInfo.overview,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.redAccent[400],
        title: new Text(
          _movieInfo.title,
        ),
      ),
      body: new Container(
          alignment: Alignment.center,
          child: _loading ?
          new CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.red)
          ) :
          new RefreshIndicator(
            onRefresh: (){
              _getMovieDetailData(_movieInfo);
            },
            child: _movieDetailInfo != null ?
            buildMovieDetail(_movieDetailInfo) :
            new Container(
              alignment: Alignment.center,
              child: new Column(
                children: <Widget>[
                  SizedBox(height: 60.0,),
                  Image.asset('res/img/icon_sad_80.png', width: 40.0, height: 40.0,),
                  Text(
                    "No data yet!",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                    ),
                  ),

                ],
              ),
            ),
          )
      ),
    );
  }


}