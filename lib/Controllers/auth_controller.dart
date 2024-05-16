import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<Response<dynamic>> registerUser(Map<String, dynamic>? userData) async {
    try {
      Response<dynamic> response = await _dio.post(
        'https://api.themoviedb.org/3/authentication/token/new',
        data: userData,
        queryParameters: {'apikey': '31521ab741626851b73c684539c33b5a'},
      );
      // Wrap the response data within a Response object and return it
      return Response(
        requestOptions: response.requestOptions,
        data: response.data,
        headers: response.headers,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        isRedirect: response.isRedirect,
        redirects: response.redirects,
      );
    } on DioError catch (e) {
      print(e);
      // Wrap the error response data within a Response object and return it
      return Response(
        requestOptions: e.requestOptions,
        data: e.response!.data,
        headers: e.response!.headers,
        statusCode: e.response!.statusCode,
        statusMessage: e.response!.statusMessage,
        isRedirect: e.response!.isRedirect,
        redirects: e.response!.redirects,
      );
    }
  }


  Future<Response> login(String username, String password) async {
  try {
    Response response = await _dio.post(
      'https://api.themoviedb.org/3/authentication/token/validate_with_login',
      data: {
        'username': username,
        'password': password
      },
      queryParameters: {'apikey': '31521ab741626851b73c684539c33b5a'},
    );
    //returns the successful user data json object
    return response.data;
  } on DioError catch (e) {
    print(e);
    //returns the error object if any
    return e.response!.data;
  }}


Future<Response> getUserProfileData(String accesstoken) async {
    try {
      Response response = await _dio.get(
        'https://api.themoviedb.org/3/account/{account_id}',
        queryParameters: {'apikey': '31521ab741626851b73c684539c33b5a'},
      );
      return response.data;
    } on DioError catch (e) {
      print(e);
      return e.response!.data;
    }}

   /* Future<Response> logout(String accessToken) async {
      try {
        Response response = await _dio.get(
          'https://api.loginradius.com/identity/v2/auth/access_token/InValidate',
          queryParameters: {'apikey': ApiSecret.apiKey},

        );
        return response.data;
      } on DioError catch (e) {
        return e.response!.data;
      }
    }*/
}

