part of 'video_player_cubit.dart';

@immutable
sealed class VideoPlayerState {}

final class VideoPlayerInitial extends VideoPlayerState {}

class VideoPlayerLoading extends VideoPlayerState {}

class VideoPlayerPlaying extends VideoPlayerState {}

class VideoPlayerPaused extends VideoPlayerState {}

class VideoPlayerError extends VideoPlayerState {
  final String errorMessage;

  VideoPlayerError(this.errorMessage);
}
