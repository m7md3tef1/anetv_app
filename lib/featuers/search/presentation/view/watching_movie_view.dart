import 'dart:io';

import 'package:anetv/featuers/home/presentation/manager/all_movies_cubit/actionHandeler.dart';
// import 'package:cloudinary_public/cloudinary_public.dart';
// import 'package:better_player/better_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
// import 'package:flutter/services.dart';
// import 'package:video_player/video_player.dart';
// import 'package:video_player_win/video_player_win.dart';

// class WatchingMovieView extends StatefulWidget {
//   final String url;
//
//   WatchingMovieView({required this.url});
//
//   @override
//   _WatchingMovieViewState createState() => _WatchingMovieViewState();
// }
//
// class _WatchingMovieViewState extends State<WatchingMovieView> {
//   late VlcPlayerController _videoPlayerController;
//   static const _networkCachingMs = 2000;
//   static const _subtitlesFontSize = 30;
//   @override
//   void initState() {
//     print(widget.url);
//     print("https://drive.usercontent.google.com/download?id=1YpYfukgujCuaaH1ClI2hXmOMEqMveGcM&authuser=0&confirm=t&uuid=30a4b2c0-d98e-4fc3-909d-3c7868e03206&at=APvzH3poMdVn07hhKRLmdb7wxZhh%3A1734380470209");
//     super.initState();
//     _videoPlayerController = VlcPlayerController.network(
//       "https://drive.usercontent.google.com/download?id=1YpYfukgujCuaaH1ClI2hXmOMEqMveGcM&authuser=0&confirm=t&uuid=30a4b2c0-d98e-4fc3-909d-3c7868e03206&at=APvzH3poMdVn07hhKRLmdb7wxZhh%3A1734380470209",
//       // hwAcc: HwAcc.auto,
//       autoInitialize: true,
//       autoPlay: true,
//       options: VlcPlayerOptions(
//         advanced: VlcAdvancedOptions([
//           VlcAdvancedOptions.networkCaching(_networkCachingMs),
//           VlcAdvancedOptions.liveCaching(2500),
//         ]),
//         subtitle: VlcSubtitleOptions([
//           VlcSubtitleOptions.boldStyle(true),
//           VlcSubtitleOptions.fontSize(_subtitlesFontSize),
//           VlcSubtitleOptions.outlineColor(VlcSubtitleColor.yellow),
//           VlcSubtitleOptions.outlineThickness(VlcSubtitleThickness.normal),
//           // works only on externally added subtitles
//           VlcSubtitleOptions.color(VlcSubtitleColor.navy),
//         ]),
//         // http: VlcHttpOptions([
//         //   VlcHttpOptions.httpReconnect(true),
//         // ]),
//         // rtp: VlcRtpOptions([
//         //   VlcRtpOptions.rtpOverRtsp(true),
//         // ]),
//       ),
//     )..addListener(() {
//         if (_videoPlayerController.value.isBuffering) {
//           // Display loading or buffering indicator
//           print("Buffering...");
//         }
//         if (_videoPlayerController.value.isInitialized) {
//           // Hide buffering indicator
//           print("Video Initialized");
//         }
//       });
//   }
//
//
//   @override
//   void dispose() {
//     super.dispose();
//     _videoPlayerController.dispose(); // Don't forget to dispose
//   }
//
//   void _seekBackwards() async {
//     Duration currentPosition = _videoPlayerController.value.position;
//     Duration newPosition = currentPosition - const Duration(seconds: 10);
//
//     if (newPosition < Duration.zero) {
//       newPosition = Duration.zero; // Prevent seeking to negative time
//     }
//
//     _videoPlayerController.seekTo(newPosition);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ActionHandler().handleArrowAndEnterAction(
//       child: Actions(
//         actions: <Type, Action<Intent>>{
//           CloseButtonIntent: CallbackAction<CloseButtonIntent>(
//             onInvoke: (intent) {
//               return Navigator.pop(context);
//             },
//           ),
//           RightButtonIntent: CallbackAction<RightButtonIntent>(
//             onInvoke: (intent) {
//               return _videoPlayerController.seekTo(const Duration(seconds: 10));
//             },
//           ),
//           LeftButtonIntent: CallbackAction<LeftButtonIntent>(
//             onInvoke: (intent) {
//               return _seekBackwards();
//             },
//           ),
//           EnterButtonIntent: CallbackAction<EnterButtonIntent>(
//             onInvoke: (intent) {
//               return _videoPlayerController.play();
//             },
//           ),
//         },
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text('MKV Video Player'),
//             // toolbarHeight: 0,
//           ),
//           body: Column(
//             children: [
//               VlcPlayer(
//                 controller: _videoPlayerController,
//                 aspectRatio: 16 / 9, // Adjust the aspect ratio if needed
//                 placeholder: Center(child: CircularProgressIndicator()),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart'; // For file extension
import 'dart:convert';

import 'package:webview_flutter/webview_flutter.dart';

// Future<void> uploadVideoToCloudinary(String filePath) async {
//   const cloudName = 'daskfjvou';
//   const apiKey = '773122628716277';
//   const apiSecret = 'MZzM4Nw34FFBNoTdM8K2XCF6i7M';
//   final url = 'https://api.cloudinary.com/v1_1/$cloudName/video/upload';
//
//   try {
//     // Create multipart request
//     var request = http.MultipartRequest('POST', Uri.parse(url));
//     request.fields['upload_preset'] = 'your-upload-preset'; // Optional preset
//     request.fields['api_key'] = apiKey;
//
//     // Add file
//     var file = await http.MultipartFile.fromPath('file', filePath);
//     request.files.add(file);
//
//     // Send request
//     var response = await request.send();
//     print("sssssssssssssssssssssss");
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       print("sssssssssssssssssssssss");
//       var responseData = await http.Response.fromStream(response);
//       var jsonData = json.decode(responseData.body);
//       print("Uploaded Video URL: ${jsonData['url']}");
//     } else {
//       print("Failed to upload video. Status: ${response.statusCode}");
//     }
//   } catch (e) {
//     print("Error uploading video: $e");
//   }
// }

// Future<CloudinaryResponse> uploadFileOnCloudinary(
//     {String? filePath, CloudinaryResourceType? resourceType}) async {
//   String result;
//   CloudinaryResponse response;
//   try {
//     var cloudinary =
//         CloudinaryPublic('CLOUD_NAME', 'UPLOAD_PRESET', cache: false);
//     response = await cloudinary.uploadFile(
//       CloudinaryFile.fromFile(filePath!, resourceType: resourceType!),
//     );
//   } on CloudinaryException catch (e, s) {
//     print(e.message);
//     print(e.request);
//   }
//   return response;
// }

class WatchingMovieView extends StatefulWidget {
  final String url;
//
  const WatchingMovieView({super.key, required this.url});

  @override
  State<WatchingMovieView> createState() => _WatchingMovieViewState();
}

class _WatchingMovieViewState extends State<WatchingMovieView> {
  // late BetterPlayerController _betterPlayerController;

  @override
  // void initState() {
  //   super.initState();
  //
  //   // Example Google Drive link (replace with your actual link)
  //
  //   _betterPlayerController = BetterPlayerController(
  //     const BetterPlayerConfiguration(
  //       aspectRatio: 16 / 9,
  //       autoPlay: true,
  //       looping: true,
  //     ),
  //   );
  //
  //   // Replace with your direct download link
  //   // String videoUrl = widget.url;
  //   _betterPlayerController.setupDataSource(
  //     BetterPlayerDataSource(
  //       BetterPlayerDataSourceType.network,
  //       "https://drive.usercontent.google.com/download?id=${widget.url}&authuser=0&confirm=t&uuid=30a4b2c0-d98e-4fc3-909d-3c7868e03206&at=APvzH3poMdVn07hhKRLmdb7wxZhh%3A1734380470209",
  //       liveStream: true,
  //       // videoFormat: BetterPlayerVideoFormat.other,
  //       cacheConfiguration: const BetterPlayerCacheConfiguration(
  //         useCache: true,
  //         // maxCacheSize: 100 * 1024 * 1024, // Cache up to 100MB
  //         // maxCacheFileSize: 50 * 1024 * 1024, // Max single file cache size 50MB
  //       ),
  //     ),
  //   );
  // }
  late VlcPlayerController _videoPlayerController;
  double _currentPosition = 0.0;
  double _videoDuration = 0.0;
  bool _isDragging = false;
  static const _networkCachingMs = 3000;
  static const _subtitlesFontSize = 30;
  @override
  void initState() {
    print(widget.url);
    print(
        "https://drive.usercontent.google.com/download?id=${widget.url}&authuser=0&confirm=t&uuid=30a4b2c0-d98e-4fc3-909d-3c7868e03206&at=APvzH3poMdVn07hhKRLmdb7wxZhh%3A1734380470209");
    super.initState();
    // uploadVideoToCloudinary(
    // "https://drive.usercontent.google.com/download?id=${widget.url}&authuser=0&confirm=t&uuid=30a4b2c0-d98e-4fc3-909d-3c7868e03206&at=APvzH3poMdVn07hhKRLmdb7wxZhh%3A1734380470209");
    _videoPlayerController = VlcPlayerController.network(
      "https://drive.usercontent.google.com/download?id=${widget.url}&authuser=0&confirm=t&uuid=30a4b2c0-d98e-4fc3-909d-3c7868e03206&at=APvzH3poMdVn07hhKRLmdb7wxZhh%3A1734380470209",
      // hwAcc: HwAcc.auto,
      hwAcc: HwAcc.full,
      autoInitialize: true,
      allowBackgroundPlayback: false,
      autoPlay: true,
      options: VlcPlayerOptions(
        advanced: VlcAdvancedOptions([
          // VlcAdvancedOptions.networkCaching(_networkCachingMs),
          VlcAdvancedOptions.liveCaching(3000),
          VlcAdvancedOptions.clockSynchronization(0),
          VlcAdvancedOptions.clockJitter(0),
          VlcAdvancedOptions.fileCaching(3000),
        ]),
        // video: VlcVideoOptions([
        //   VlcVideoOptions.skipFrames(true),
        //   VlcVideoOptions.dropLateFrames(true),
        // ]),
        subtitle: VlcSubtitleOptions([
          VlcSubtitleOptions.boldStyle(true),
          VlcSubtitleOptions.fontSize(_subtitlesFontSize),
          VlcSubtitleOptions.outlineColor(VlcSubtitleColor.yellow),
          VlcSubtitleOptions.outlineThickness(VlcSubtitleThickness.normal),
          // works only on externally added subtitles
          VlcSubtitleOptions.color(VlcSubtitleColor.navy),
        ]),
        http: VlcHttpOptions([
          VlcHttpOptions.httpReconnect(true),
        ]),
        rtp: VlcRtpOptions([
          VlcRtpOptions.rtpOverRtsp(true),
        ]),
      ),
    )..addListener(() {
        if (_videoPlayerController.value.isBuffering) {
          // Display loading or buffering indicator
          print("Buffering...");
        }
        if (_videoPlayerController.value.isInitialized) {
          // Hide buffering indicator
          print("Video Initialized");
        }
        if (_videoPlayerController.value.isPlaying) {
          // Hide buffering indicator
          print("Video isPlaying");
        }
        if (!_isDragging) {
          setState(() {
            _currentPosition =
                _videoPlayerController.value.position.inSeconds.toDouble();
            _videoDuration =
                _videoPlayerController.value.duration.inSeconds.toDouble();
          });
        }
      });
  }

  void _seekBackward(seekDuration) async {
    // print('aaaaaaaaaa');
    // print(seekDuration);

    final currentPosition = await _videoPlayerController.getPosition();
    if (currentPosition != null) {
      final newPosition = currentPosition - seekDuration;
      setState(() {
        _videoPlayerController
            .seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
      });
    }
  }

  void _seekForward(_seekAmount) async {
    // print('bbbbbbbbbbbbbbbbb');
    // print(_seekAmount);

    final currentPosition = await _videoPlayerController.value.position;
    setState(() {
      _videoPlayerController
          .seekTo(currentPosition + Duration(minutes: _seekAmount.toInt()));
    });
  }

  void togglePlayPause() {
    if (_videoPlayerController.value.isPlaying) {
      // print('cccccccccccc');
      setState(() {
        _videoPlayerController.pause();
      });
    } else {
      // print('dddddddddd');
      setState(() {
        _videoPlayerController.play();
      });
    }
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await _videoPlayerController.stopRecording();
    await _videoPlayerController.stopRendererScanning();
    await _videoPlayerController.dispose();
  }

  void _onSliderChanged(double value) {
    setState(() {
      _currentPosition = value;
    });
  }

  void _onSliderReleased(double value) {
    _videoPlayerController.seekTo(Duration(seconds: value.toInt()));
    setState(() {
      _isDragging = false;
    });
  }

  void _onSliderDragStart(double value) {
    setState(() {
      _isDragging = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ActionHandler().handleArrowAndEnterAction3(
        child: Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: RawKeyboardListener(
          focusNode: FocusNode(),
          child: Actions(
              actions: <Type, Action<Intent>>{
                CloseButtonIntent: CallbackAction<CloseButtonIntent>(
                  onInvoke: (intent) {
                    Navigator.pop(context);
                    return true;
                  },
                ),
                UpButtonIntent: CallbackAction<UpButtonIntent>(
                  onInvoke: (intent) {
                    _seekForward(10);
                    return _seekForward;
                  },
                ),
                DownButtonIntent: CallbackAction<DownButtonIntent>(
                  onInvoke: (intent) {
                    // print("sssssssssssssssssssssssssssssssssssssssss");
                    _seekBackward(const Duration(minutes: 10));
                    return _seekBackward;
                  },
                ),
                EnterButtonIntent: CallbackAction<EnterButtonIntent>(
                  onInvoke: (intent) {
                    togglePlayPause();
                    return togglePlayPause;
                  },
                ),
                RightButtonIntent: CallbackAction<RightButtonIntent>(
                  onInvoke: (intent) {
                    _seekForward(1);
                    return _seekForward;
                  },
                ),
                LeftButtonIntent: CallbackAction<LeftButtonIntent>(
                  onInvoke: (intent) {
                    _seekBackward(const Duration(minutes: 1));
                    return _seekBackward;
                  },
                ),
              },
              child: Focus(
                autofocus: true,
                child: Column(children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: VlcPlayer(
                        controller: _videoPlayerController,
                        aspectRatio:
                            16 / 9, // Adjust the aspect ratio if needed
                        placeholder:
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ), // Video Time Slider
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _formatDuration(
                                  Duration(seconds: _currentPosition.toInt())),
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              _formatDuration(
                                  Duration(seconds: _videoDuration.toInt())),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Slider(
                          value: _currentPosition,
                          min: 0,
                          max: _videoDuration,
                          onChanged: _onSliderChanged,
                          onChangeStart: _onSliderDragStart,
                          onChangeEnd: _onSliderReleased,
                          activeColor: Colors.blue,
                          inactiveColor: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ]),
              )),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: togglePlayPause,
          //   child:
          //       Icon(controller!.value.isPlaying ? Icons.pause : Icons.play_arrow),
          // ),
        ),
      ),
    ));
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }
}
