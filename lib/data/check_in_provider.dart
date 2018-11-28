import 'package:dio/dio.dart';
import 'package:wi_ogsusu/constant.dart';
import 'package:wi_ogsusu/entities/check_in_info.dart';



class CheckInProvider{

  Dio dio;
  int userId;


  CheckInProvider(this.dio, this.userId);

  Future<void> getCheckInData(Function onSuccess, Function onFailure) async{
    try {
      if (userId == null || userId <= 0) {
        return;
      }
      String url = Constant.URL_CHECK_IN_DETAILS;
      Response response = await dio.get(url, data: {
        "userId": userId,
        "type": Constant.PARAM_TYPE,
        "agent": Constant.PARAM_AGENT,
        "platform": Constant.PARAM_PLATFORM,
      });
      if (response == null) {
        onFailure('reponse is empty');
        return;
      }
      if (response.statusCode != 200) {
        onFailure('reponse faile, code: ' + response.statusCode.toString());
        return;
      }
      int code = response.data['code'];
      if (code == 200) {
        CheckInInfo checkInInfo = new CheckInInfo.fromJson(
            response.data['data']);
        if (checkInInfo != null) {
          onSuccess(checkInInfo);
        } else {
          onFailure("parse failure #1731");
        }
      } else {
        String e = response.data['msg'];
        print(e);
        onFailure(e);
      }
    }on DioError catch(e){
      print("DioError: " + e.message);
      onFailure(e.message);
    }
  }

}