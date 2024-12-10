

import 'package:dio/dio.dart';

abstract class Failures {
  final String errorMessage;

  Failures(this.errorMessage);
}

class ServerFailuer extends Failures {
  ServerFailuer(super.errorMessage);

factory ServerFailuer.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailuer(
            'Connection timed out. Please check your internet and try again.');
      case DioExceptionType.sendTimeout:
        return ServerFailuer(
            'Request timed out. Check your connection and try again.');
      case DioExceptionType.receiveTimeout:
        return ServerFailuer(
            'Server response timed out. Check your connection or try again later.');
      case DioExceptionType.badCertificate:
        return ServerFailuer('Oops There was an Error, Please try again');
      case DioExceptionType.badResponse:
        return ServerFailuer.fromResponse(
            dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailuer('The request was canceled. Please try again.');
      case DioExceptionType.connectionError:
        return ServerFailuer(
            'Unable to connect. Please check your internet connection and try again.');
      case DioExceptionType.unknown:
        if (dioException.message != null &&
            dioException.message!.contains('SocketException')) {
          return ServerFailuer('No Internet Connection');
        }
        return ServerFailuer('Unexpected Error, Please try again!');
      default:
        return ServerFailuer('Ops There was an Error, Please try again');
    }
  }

  factory ServerFailuer.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 404) {
      return ServerFailuer('Your request was not found, please try later');
    } else if (statusCode == 500) {
      return ServerFailuer('There is a problem with server, please try later');
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailuer(response['error']['message']);
    } else {
      return ServerFailuer('There was an error , please try again');
    }
  }
}
