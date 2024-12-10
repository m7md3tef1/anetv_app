


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../manager/watching_movie_cubit/video_player_cubit.dart';

// class WatchingMovieViewBody extends StatelessWidget {
//   const WatchingMovieViewBody({super.key, required this.url});
//   final String url;
//   @override
//   Widget build(BuildContext context) {
//     return const Column(
//       children: [
//
//       ],
//     );
//   }
// }

class WatchingMovieViewBody extends StatelessWidget {
  const WatchingMovieViewBody({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VideoPlayerCubit(url), // Provide the Cubit
      child: Scaffold(
        appBar: AppBar(title: const Text('Watch Movie')),
        body: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
          builder: (context, state) {
            final videoCubit = context.read<VideoPlayerCubit>();

            // Handle different states
            if (state is VideoPlayerLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is VideoPlayerError) {
              return Center(child: Text(state.errorMessage));
            } else if (state is VideoPlayerPlaying || state is VideoPlayerPaused) {
              return Center(
                child: AspectRatio(
                  aspectRatio: videoCubit.controller.value.aspectRatio,
                  child: VideoPlayer(videoCubit.controller),
                ),
              );
            } else {
              return const Center(child: Text('Something went wrong.'));
            }
          },
        ),
        floatingActionButton: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
          builder: (context, state) {
            final videoCubit = context.read<VideoPlayerCubit>();
            return FloatingActionButton(
              onPressed: () {
                if (state is VideoPlayerPlaying) {
                  videoCubit.pause();
                } else if (state is VideoPlayerPaused) {
                  videoCubit.play();
                }
              },
              child: Icon(
                state is VideoPlayerPlaying ? Icons.pause : Icons.play_arrow,
              ),
            );
          },
        ),
      ),
    );
  }
}
