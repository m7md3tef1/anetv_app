

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  //VideoPlayerCubit() : super(VideoPlayerInitial());
  final VideoPlayerController _controller;

  VideoPlayerCubit(String videoUrl)
      : _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl)),
        super(VideoPlayerInitial()) {
    _initializeVideo();
  }

  void _initializeVideo() async {
    try {
      emit(VideoPlayerLoading()); // Start loading the video
      await _controller.initialize();
      emit(VideoPlayerPlaying()); // Video is ready to play
    } catch (e) {
      emit(VideoPlayerError('Error loading video: $e')); // Handle errors
    }
  }

  void play() {
    if (!_controller.value.isInitialized) return;
    _controller.play();
    emit(VideoPlayerPlaying());
  }

  void pause() {
    if (!_controller.value.isInitialized) return;
    _controller.pause();
    emit(VideoPlayerPaused());
  }

  void dispose() {
    _controller.dispose();
    super.close();
  }

  VideoPlayerController get controller => _controller;
}
