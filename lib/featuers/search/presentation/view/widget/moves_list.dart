import 'dart:convert';

import 'package:anetv/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../home/presentation/manager/all_movies_cubit/all_movies_cubit.dart';

class MovesList extends StatelessWidget {
  const MovesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllMoviesCubit, AllMoviesState>(
        builder: (context, state) {
      if (state is AllMoviesSuccess) {
        final allMoves = state.allMovies;
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: allMoves.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
            child: Column(
              children: [
                Text(
                  allMoves[index].title,
                  style: const TextStyle(fontSize: 20),
                ),
                InkWell(
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.kWatchingMovieView,
                        extra: allMoves[index].embedLink);
                  },
                  child: Image.network(
                    height: 150,
                    width: double.infinity,
                    '${allMoves[index].thumbnail}',
                    fit: BoxFit.fill,
                  ),
                )
              ],
            ),
          ),
        );
      } else if (state is AllMoviesFailure) {
        print(state.errorMassage);
        return Text(state.errorMassage);
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
