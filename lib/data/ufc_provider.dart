import 'package:dio/dio.dart';


class UfcProvider{

  Dio dio = Dio();
  final String EVENT_URL = "http://ufc-data-api.ufc.com/api/v1/us/events";
  final String MEDIA_URL = "http://ufc-data-api.ufc.com/api/v1/us/media/665797";


  Future<String> fetchEvents () async{
    Response response = await dio.get(EVENT_URL).catchError((DioError e){
      print("DioError: " + e.toString());
    });
    if(response.statusCode == 200){
      List dataList = response.data;
      print(dataList);

    }
    return "";
  }
}