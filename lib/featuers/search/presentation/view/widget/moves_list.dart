import 'dart:convert';

import 'package:anetv/core/utils/app_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        return GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsetsDirectional.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: 200),
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemCount: allMoves.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                InkWell(
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.kWatchingMovieView,
                        extra: allMoves[index].embedLink);
                  },
                  child: CachedNetworkImage(
                    imageUrl: '${allMoves[index].thumbnail}',
                    imageBuilder: (context, imageProvider) => Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    allMoves[index].title,
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (state is AllMoviesFailure) {
        // print(state.errorMassage);
        return Center(child: Text("No Videos Yet"));
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
