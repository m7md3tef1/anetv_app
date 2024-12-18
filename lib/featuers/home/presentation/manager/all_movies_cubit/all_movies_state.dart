part of 'all_movies_cubit.dart';

sealed class AllMoviesState {}

final class AllMoviesInitial extends AllMoviesState {}

final class AllMoviesLoading extends AllMoviesState {}

final class AllMoviesFailure extends AllMoviesState {
  final String errorMassage;

  AllMoviesFailure(this.errorMassage);
}

final class AllMoviesSuccess extends AllMoviesState {
  final List<MovieModel> allMovies;

  AllMoviesSuccess(this.allMovies);
}

final class AllSearchLoading extends AllMoviesState {}

final class AllSearchFailure extends AllMoviesState {
  final String errorMassage;

  AllSearchFailure(this.errorMassage);
}

final class AllSearchSuccess extends AllMoviesState {
  final List<MovieModel> allSearch;

  AllSearchSuccess(this.allSearch);
}

