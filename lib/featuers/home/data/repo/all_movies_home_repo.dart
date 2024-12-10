import 'package:anetv/core/errors/failures.dart';
import 'package:anetv/featuers/home/data/models/movie_model.dart';

import 'package:dartz/dartz.dart';

abstract class AllMoviesHomeRepo {
  Future<Either<Failures, List<MovieModel>>> fetchMovie(
      {required String catogry});
}
