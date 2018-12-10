import 'package:dio/dio.dart';
import 'dart:io';
import 'result.dart';

class HttpMaster {
  static HttpMaster _instance;
  static Dio dio;
  static HttpMaster get instance {
    if (_instance == null) {
      _instance = new HttpMaster();
    }
    return _instance;
  }

  HttpMaster() {
    Options options = new Options(
//        baseUrl: "https://dd.shmy.tech/api/client",
      // baseUrl: "http://172.27.35.17:1994/api/client",
      connectTimeout: 20000,
      receiveTimeout: 20000,
      headers: {
        "App-Platform": Platform.operatingSystem,
      }
    );
    dio = new Dio(options);
//    dio.interceptor.request.onSend = (Options options) async {
//      User userModel = await User.instance;
//      // userModel.
//      Map u = await userModel.findID1();
//      if (options.headers["Authorization"] == null && u != null) {
//        options.headers["Authorization"] = "Bearer " + u["token"];
//      }
//      print(options.path);
//      print(options.data);
//      return options;
//    };
//    dio.interceptor.response.onSuccess = (Response response) {
//      Map data = response.data;
//      bool success = data["success"];
//      if (!success) {
//        return dio.resolve(null);
//      }
//      return dio.resolve(data["payload"]);
//    };
//    dio.interceptor.response.onError = (DioError e) {
//      String msg = this.formatErrorMessage(e.type);
//      if (e.response != null) {
//        msg = e.response.data["message"];
//      }
//      if (msg != "") {
//      }
//      // 请求异常返回null
//      return dio.resolve(null);
//    };
  }


  Future<Result> get(String path, {data, Options options, CancelToken cancelToken}) async {
    try {
      Response response = await dio.get(path,
          data: data, options: options, cancelToken: cancelToken);
      Result result = Result();
      result.code = response.data['code'];
      result.msg = response.data['msg'];
      result.data = response.data['data'];
      return result;
    } on DioError catch (e) {
      String msg = this.formatErrorMessage(e.type);
      Result result = Result();
      result.code = 510;
      result.msg = msg;
      return result;
    }
  }




  Future<Result> getNative(String path, {data, Options options, CancelToken cancelToken}) async {
    try {
      Response response = await dio.get(path,
          data: data, options: options, cancelToken: cancelToken);
      Result result = Result();
      result.code = response.statusCode;
      if(response.statusCode == 200){
        result.msg = "Successfully";
        result.data = response.data;
      }else{
        result.msg = "Failure";
        result.data = response.data['data'];
      }
      return result;
    } on DioError catch (e) {
      String msg = this.formatErrorMessage(e.type);
      Result result = Result();
      result.code = 510;
      result.msg = msg;
      return result;
    }
  }

  Future<Result> post(String path, {data, Options options, CancelToken cancelToken}) async {
    try {
      Response response = await dio.post(path,
          data: data, options: options, cancelToken: cancelToken);
      Result result = Result();
      result.code = response.data['code'];
      result.msg = response.data['msg'];
      result.data = response.data['data'];
      return result;
    } on DioError catch (e) {
      String msg = this.formatErrorMessage(e.type);
      Result result = Result();
      result.code = 510;
      result.msg = msg;
      return result;
    }
  }

  Future<Result> put(String path, {data, Options options, CancelToken cancelToken}) async {
    try {
      Response response = await dio.put(path,
          data: data, options: options, cancelToken: cancelToken);
      Result result = Result();
      result.code = response.data['code'];
      result.msg = response.data['msg'];
      result.data = response.data['data'];
      return result;
    } on DioError catch (e) {
      String msg = this.formatErrorMessage(e.type);
      Result result = Result();
      result.code = 510;
      result.msg = msg;
      return result;
    }
  }

  Future<Result> delete(String path, {data, Options options, CancelToken cancelToken}) async {
    try {
      Response response = await dio.delete(path,
          data: data, options: options, cancelToken: cancelToken);
      Result result = Result();
      result.code = response.data['code'];
      result.msg = response.data['msg'];
      result.data = response.data['data'];
      return result;
    } on DioError catch (e) {
      String msg = this.formatErrorMessage(e.type);
      Result result = Result();
      result.code = 510;
      result.msg = msg;
      return result;
    }
  }

  download(
      String urlPath,
      savePath, {
        OnDownloadProgress onProgress,
        CancelToken cancelToken,
        data,
        Options options,
      }) {
    Dio d = new Dio();
    d.onHttpClientCreate = (HttpClient client) {
      client.idleTimeout = new Duration(seconds: 0);
    };
    d.download(urlPath, savePath,
        onProgress: onProgress,
        cancelToken: cancelToken,
        data: data,
        options: options);
  }

  String formatErrorMessage(DioErrorType type) {
    switch (type) {
      case DioErrorType.DEFAULT:
        return "Network connection error";
      case DioErrorType.CONNECT_TIMEOUT:
        return "Connect timeout";
      case DioErrorType.RECEIVE_TIMEOUT:
        return "Connect timeout";
      case DioErrorType.RESPONSE:
        return "Server connect failure";
      default:
        return "";
    }
  }
}