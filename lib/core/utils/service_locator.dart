
import 'package:anetv/core/utils/api_service.dart';
import 'package:anetv/featuers/home/data/repo/all_movies_home_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void setup() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<AllMoviesHomeRepoImpl>(AllMoviesHomeRepoImpl(getIt.get<ApiService>()));
}
