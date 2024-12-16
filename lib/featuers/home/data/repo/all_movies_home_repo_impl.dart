import 'dart:convert';

import 'package:anetv/core/errors/failures.dart';
import 'package:anetv/core/utils/api_service.dart';
import 'package:anetv/featuers/home/data/models/moves.dart';
import 'package:anetv/featuers/home/data/models/movie_model.dart';
import 'package:anetv/featuers/home/data/repo/all_movies_home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

bool? isEpisodes;
List<Data> movies = [];
class AllMoviesHomeRepoImpl implements AllMoviesHomeRepo {
  final ApiService apiService;

  const AllMoviesHomeRepoImpl(this.apiService);

  final String baseUrlAllMovies = 'https://alaanetstreaming.com/';
  String fetchMovies({required String category}) {
    print('$category ');
    print('${"baseUrlAllMovies"} ');
    print(category.toString().contains("https://alaanetstreaming.com/")
        ? category
        : '${baseUrlAllMovies}api/v1/leb/?page=1&per_page=200&type=movie&category=$category');
    category.toString().contains("https://alaanetstreaming.com/")
        ? isEpisodes = false
        : isEpisodes = true;
    print(isEpisodes);
    return category.toString().contains("https://alaanetstreaming.com/")
        ? category
        : '${baseUrlAllMovies}api/v1/leb/?page=1&type=movie&category=$category';
  }

  @override
  Future<Either<Failures, List<MovieModel>>> fetchMovie(
      {required String category}) async {
    print("category");
    print(category);
    try {
      var data = await apiService.get(apis: fetchMovies(category: category));
      // print('API Response: $data');
      List<MovieModel> movie = [];
      movies.clear();
      print(isEpisodes);
      if (isEpisodes == false) {
        for (var i in data['data']) {
          movies.add(Data.fromJson(i));
        }
      } else {
        for (var i in data['data']) {
          movie.add(MovieModel.fromJson(i));
        }
      }
    // print('Movie List: ${jsonEncode(movie)}');
    //  print('Movie List222: ${movies[0].name}');
      return  right(movie);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailuer.fromDioException(e));
      }
      return left(ServerFailuer(e.toString()));
    }
  }
}

// https://alaanetstreaming.com/v_v/
