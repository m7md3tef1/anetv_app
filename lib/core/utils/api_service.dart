import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;
  ApiService(this._dio);

  Future<Map<String, dynamic>> get({
    required String apis,
  }) async {
    var response = await _dio.get(apis);
    return response.data;
  }
}
// final String _baseUrl = 'https://www.googleapis.com/books/v1/';
 final String _baseUrl = 'https://alaanetstreaming.com/api/v1/';
