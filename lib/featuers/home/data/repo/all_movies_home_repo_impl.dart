import 'dart:convert';

import 'package:anetv/core/errors/failures.dart';
import 'package:anetv/core/utils/api_service.dart';
import 'package:anetv/featuers/home/data/models/moves.dart';
import 'package:anetv/featuers/home/data/models/movie_model.dart';
import 'package:anetv/featuers/home/data/repo/all_movies_home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_router.dart';
import '../../../search/presentation/view/search_view.dart';
import '../models/catogry_itme_model.dart';

bool? isEpisodes;
List<Data> movies = [];
var page = 1;

class AllMoviesHomeRepoImpl implements AllMoviesHomeRepo {
  final ApiService apiService;

  const AllMoviesHomeRepoImpl(this.apiService);

  final String baseUrlAllMovies = 'https://alaanetstreaming.com/';
  String fetchMovies({required String category}) {
    print('$category ');
    print('${"baseUrlAllMovies"} ');
    print('${"baseUrlAllMovies $page"} ');
    print(category.toString().contains("https://alaanetstreaming.com/")
        ? category.replaceAll("Page", page.toString())
        : '${baseUrlAllMovies}api/v1/leb/?page=$page&type=movie&category=$category');
    category.toString().contains("search")
        ? isEpisodes = true
        : category.toString().contains("https://alaanetstreaming.com/")
            ? isEpisodes = false
            : isEpisodes = true;
    print(isEpisodes);
    return category.toString().contains("https://alaanetstreaming.com/")
        ? category.replaceAll("Page", page.toString())
        : '${baseUrlAllMovies}api/v1/leb/?page=$page&type=movie&category=$category';
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
      print("fffffffffffffffffffff");
    // print('Movie List: ${jsonEncode(movie)}');
      // print('Movie List222: ${movies[0].name}');
      return right(movie);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailuer.fromDioException(e));
      }
      return left(ServerFailuer(e.toString()));
    }
  }
}

// https://alaanetstreaming.com/v_v/
