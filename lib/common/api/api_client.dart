import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}){

    print(appBaseUrl);
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    _mainHeaders={
      'Content-type':'application/json; charset=UTF-8',
    };
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      Response response = await get(
        uri,
        headers: headers ?? _mainHeaders,
      );
      return response;
    } catch (e) {
      print("Error during GET request: $e");
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

}