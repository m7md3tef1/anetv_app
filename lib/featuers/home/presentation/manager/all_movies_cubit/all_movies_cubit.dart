import 'dart:convert';

import 'package:anetv/featuers/home/data/models/moves.dart';
import 'package:anetv/featuers/home/data/models/movie_model.dart';
// import 'package:anetv/featuers/home/data/repo/all_movies_home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/moves.dart';
import '../../../data/models/moves.dart';
import '../../../data/models/moves.dart';
import '../../../data/repo/all_movies_home_repo.dart';
import '../../../data/repo/all_movies_home_repo_impl.dart';

part 'all_movies_state.dart';

class AllMoviesCubit extends Cubit<AllMoviesState> {
  AllMoviesCubit(this.allMoviesHomeRepo) : super(AllMoviesInitial());
  final AllMoviesHomeRepo allMoviesHomeRepo;
  // List<MovieModel>? allMovie;
  Future<void> fetchMovie({required String catogry}) async {
    emit(AllMoviesLoading());
    var result = await allMoviesHomeRepo.fetchMovie(category: catogry);
    result.fold((failure) {
      // catogry.contains("search")?
      // emit(AllSearchFailure(failure.errorMessage))      :
      emit(AllMoviesFailure(failure.errorMessage));
    }, (allMovies) {
      // print('Movies received: $allMovies');
      // allMovie=allMovies;
      // catogry.contains("search")?
      // emit(AllSearchSuccess(allMovies))      :
      emit(AllMoviesSuccess(allMovies));
    });
  }
  // Future<void> searchMovie({required String catogry}) async {
  //   emit(AllSearchLoading());
  //   var result = await allMoviesHomeRepo.fetchMovie(category: catogry);
  //
  //   // print("object");
  //   result.fold((failure) {
  //     emit(AllSearchFailure(failure.errorMessage));
  //   }, (allMovies) {
  //     // print('222222222222222222222222222  ${jsonEncode(allMovies)}');
  //
  //     emit(AllSearchSuccess(allMovies));
  //   });
  // }
}
