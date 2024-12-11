import 'package:anetv/featuers/home/data/models/movie_model.dart';
import 'package:anetv/featuers/home/data/repo/all_movies_home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_movies_state.dart';

class AllMoviesCubit extends Cubit<AllMoviesState> {
  AllMoviesCubit(this.allMoviesHomeRepo) : super(AllMoviesInitial());
  final AllMoviesHomeRepo allMoviesHomeRepo;
  // List<MovieModel>? allMovie;
  Future<void> fetchMovie({required String catogry}) async {
    emit(AllMoviesLoading());
    var result = await allMoviesHomeRepo.fetchMovie(category: catogry);
    result.fold((failure) {
      emit(AllMoviesFailure(failure.errorMessage));
    }, (allMovies) {
      print('Movies received: $allMovies');
      // allMovie=allMovies;
      emit(AllMoviesSuccess(allMovies));
    });
  }
}
