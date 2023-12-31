import 'package:http/http.dart' as http;
import 'endPoints.dart';
import 'package:dio/dio.dart';

class MyHttp {
  static Future<http.Response> get({required String endPoint}) async {
    final url = Uri.parse(EndPoints.baseUrl + endPoint);
    return await http.get(url);
  }

  static Future<http.Response> postFormData({
    required String endPoint,
    required Map<String, dynamic> formData,
  }) async {
    final url = Uri.parse(EndPoints.baseUrl + endPoint);
    final request = http.MultipartRequest('POST', url);

    formData.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return response;
    } catch (e) {
      throw Exception('Error sending form data: $e');
    }
  }

  static Future<http.Response> post(
      {required String endPoint, dynamic data}) async {
    final url = Uri.parse(EndPoints.baseUrl + endPoint);
    return await http.post(url, body: data);
  }
}

// import 'package:http/http.dart' as http;
// import '../cache_helper/cache_helper.dart';
// import 'endPoints.dart';

// class MyHttp {
//   static late http.Client client;

//   static void init() {
//     client = http.Client();
//   }

//   static Future<http.Response?> get({required String endPoint}) async {
//     var url = Uri.parse('${EndPoints.baseUrl}$endPoint');
//     try {
//       var response = await client.get(url);
//       return response;
//     } catch (e) {
//       print('Exception: $e');
//       return null;
//     }
//   }

//   static Future<http.Response?> post(
//       {required String endPoint, dynamic data}) async {
//     var url = Uri.parse('${EndPoints.baseUrl}$endPoint');

//     try {
//       var response = await client.post(url, body: data);
//       return response;
//     } catch (e) {
//       print('Exception: $e');
//       return null;
//     }
//   }
// }

class MyDio {
  static late Dio dio;

  static init() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: EndPoints.baseUrl,
      receiveDataWhenStatusError: true,
      validateStatus: (status) => true,
    );

    dio = Dio(baseOptions);
  }

  static Future<Response?> get({required String endPoint}) async {
    return await dio.get(endPoint);
  }

  static Future<Response?> post({required String endPoint, data}) async {
    return await dio.post(endPoint, data: data);
  }
}
