import 'dart:io';

import 'package:anetv/featuers/home/presentation/manager/all_movies_cubit/actionHandeler.dart';
import 'package:anetv/featuers/home/presentation/views/widgets/catogry_itme_home.dart';
import 'package:anetv/featuers/home/presentation/views/widgets/list_catogry_itme_home.dart';
import 'package:dio/dio.dart';
// import 'package:cloudinary_public/cloudinary_public.dart';
// import 'package:better_player/better_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_vlc_player/flutter_vlc_player.dart';
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
// Import for Android features.
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS/macOS features.
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart'; // For file extension
// import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

// import 'package:webview_flutter/webview_flutter.dart';

import '../../../../main.dart';
/*
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

        ),

      ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: togglePlayPause,
          //   child:
          //   Icon(controller!.value.isPlaying ? Icons.pause : Icons.play_arrow),
          // ),
    ));
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

}
/// Evaluates JavaScript to seek in the media player

*/

class WatchingMovieView extends StatefulWidget {
  final String url;

  const WatchingMovieView({super.key, required this.url});

  @override
  WatchingMovieViewState createState() => WatchingMovieViewState();
}

class WatchingMovieViewState extends State<WatchingMovieView> {
  // late VideoPlayerController _controller;
  // late WebViewController _webViewController;
  bool isIframe = false;
  bool _isPlaying = false;
  // late WebViewController _controller;
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      javaScriptEnabled: true,
      mediaPlaybackRequiresUserGesture: true,
      cacheEnabled: true,
      allowFileAccess: false,
      useHybridComposition: true, // For better rendering performance
      allowsInlineMediaPlayback: true, // Enables inline video playback
      disableContextMenu: false,
      useWideViewPort: true, // Optimizes rendering
      loadWithOverviewMode: true,
      allowContentAccess: true,
      // allowBackgroundAudioPlaying: true,
      // allowsAirPlayForMediaPlayback: true,
      iframeAllow: "camera;video; microphone",
      iframeAllowFullscreen: true);

  PullToRefreshController? pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(minutes: 2), () {
      if (this.mounted) {
        setState(() {
          _visible = false;
        });
      }
    });
    pullToRefreshController = kIsWeb ||
            ![TargetPlatform.iOS, TargetPlatform.android]
                .contains(defaultTargetPlatform)
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(
              color: Colors.blue,
            ),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController?.getUrl()));
              }
            },
          );
  }

  bool _visible = true;
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(minutes: 2), () {
//       if (this.mounted) {
//         setState(() {
//           _visible = false;
//         });
//       }
//     });
//     const String htmlContent1 = '''
//       <!DOCTYPE html>
//       <html>
//       <head>
//         <style>
//           body, html {
//             margin: 0;
//             padding: 0;
//             width: 100%;
//             height: 100%;
//             overflow: hidden;
//           }
//           iframe {
//             width: 100%;
//             height: 100%;
//             border: none;
//           }
//           #fullscreen {
//             position: absolute;
//             top: 0;
//             left: 0;
//             width: 100%;
//             height: 100%;
//             background: black;
//           }
//           #video-container {
//             position: relative;
//             width: 100%;
//             height: 100%;
//           }
//         </style>
//       </head>
//       <body>
//         <div id="video-container">
//           <iframe
//             id="video"
//             src="https://drive.google.com/file/d/FILE_ID/preview?controls=0&autoplay=1&fs=0"
//             allow="autoplay"
//             allowfullscreen>
//           </iframe>
//         </div>
//       </body>
//       </html>
//     ''';
//     // HTML content for overlapping controllers
//     String htmlContent = '''
//     <!DOCTYPE html>
//     <html>
//     <head>
//       <meta name="viewport" content="width=device-width, initial-scale=1.0">
//       <style>
//         body {
//           margin: 0;
//           padding: 0;
//           display: flex;
//           justify-content: center;
//           align-items: center;
//           height: 100vh;
//           background-color: #000;
//         }
//         .player-container {
//           position: relative;
//           width: 90%;
//           height: 300px;
//         }
//         iframe {
//           position: absolute;
//           top: 0;
//           left: 0;
//           width: 100%;
//           height: 100%;
//           border: none;
//         }
//         .player1 {
//           opacity: 0.8;
//         }
//         .player2 {
//           opacity: 0.5;
//         }
//       </style>
//     </head>
//     <body>
//       <div class="player-container">
//         <!-- First Player -->
//         <iframe
//           class="player1"
//           src="https://drive.google.com/file/d/FILE_ID/preview"
//           allowfullscreen>
//         </iframe>
//
//         <!-- Second Player -->
//         <iframe
//           class="player2"
//           src="https://drive.google.com/file/d/FILE_ID/preview"
//           allowfullscreen>
//         </iframe>
//       </div>
//     </body>
//     </html>
//     ''';
//     // if (widget.url.contains("iframe") || widget.url.contains("</iframe>")) {
//     //   print("widget.url2222");
//     //   // _controller = WebViewController()
//     //   //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
//     //   //   ..loadRequest(Uri.dataFromString(widget.url));
//     // } else
//     {
//       // #docregion platform_features
//       late final PlatformWebViewControllerCreationParams params;
//
//       if (WebViewPlatform.instance is WebKitWebViewPlatform) {
//         params = WebKitWebViewControllerCreationParams(
//           allowsInlineMediaPlayback: true,
//           mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{
//             PlaybackMediaTypes.video,
//             PlaybackMediaTypes.audio
//           },
//         );
//       } else {
//         params = const PlatformWebViewControllerCreationParams();
//       }
//
//       _controller = WebViewController.fromPlatformCreationParams(params);
//
//       _controller
//         ..setJavaScriptMode(JavaScriptMode.unrestricted)
// //         ..getUserAgent()
//         ..enableZoom(true)
// //         ..setNavigationDelegate(
// //           NavigationDelegate(
// //             onProgress: (int progress) {
// //               // debugPrint('WebView is loading (progress : $progress%)');
// //             },
// //             onPageStarted: (String url) {
// //               // debugPrint('Page started loading: $url');
// //             },
// //             onPageFinished: (String url) {
// //               //         _controller.evaluateJavascript('''
// //               //   var videos = document.querySelectorAll('video');
// //               //   videos.forEach(function(video) {
// //               //     video.autoplay = true;
// //               //     video.muted = true;  // If you want muted autoplay
// //               //     video.play();
// //               //   });
// //               // ''');
// //             },
// //             onWebResourceError: (WebResourceError error) {
// // //             debugPrint('''
// // // Page resource error:
// // //   code: ${error.errorCode}
// // //   description: ${error.description}
// // //   errorType: ${error.errorType}
// // //   isForMainFrame: ${error.isForMainFrame}
// // //           ''');
// //             },
// //             onNavigationRequest: (NavigationRequest request) {
// //               if (request.url.startsWith('https://drive.google.com/')) {
// //                 debugPrint('blocking navigation to ${request.url}');
// //                 return NavigationDecision.prevent;
// //               }
// //               debugPrint('allowing navigation to ${request.url}');
// //               return NavigationDecision.navigate;
// //             },
// //             onHttpError: (HttpResponseError error) {
// //               // debugPrint('Error occurred on page: ${error.response?.statusCode}');
// //             },
// //             onUrlChange: (UrlChange change) {
// //               // debugPrint('url change to ${change.url}');
// //             },
// //             onHttpAuthRequest: (HttpAuthRequest request) {},
// //           ),
// //         )
// //         ..addJavaScriptChannel(
// //           'flutter_invoke',
// //           onMessageReceived: (JavaScriptMessage message) {
// //             setState(() {
// //               _isPlaying = message.message == 'playing';
// //             });
// //           },
// //         )
//         // ..loadHtmlString(htmlContent.replaceAll(
//         //     'FILE_ID', widget.url));
//         ..loadRequest(Uri.parse(
//             // "https://drive.google.com/file/d/${widget.url}/view"
//             "https://drive.google.com/file/d/${widget.url}?autoplay=1&controls=0"
//             // "https://drive.google.com/file/d/16arurRggjbrCClwAViQrWjCQNsLoOCw5/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")
//             ));
//
//       if (kIsWeb || !Platform.isMacOS) {
//         _controller.setBackgroundColor(const Color(0x80000000));
//       }
//       print(
//           "https://drive.google.com/file/d/${widget.url}/preview?autoplay=1&controls=0");
//       // #docregion platform_features
//       if (_controller.platform is AndroidWebViewController) {
//         (_controller.platform as AndroidWebViewController)
//           ..setMediaPlaybackRequiresUserGesture(true)
//           ..setOnPlatformPermissionRequest(
//               (PlatformWebViewPermissionRequest request) {
//             request.grant();
//           });
//       }
//     }
//   }

  bool isDownloading = false;
  bool? isPlaying = true;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // InAppWebView(
    //   key: webViewKey,
    //   webViewEnvironment: webViewEnvironment,
    //   initialUrlRequest:
    //   URLRequest(url: WebUri("https://drive.google.com/file/d/${widget.url}/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")),
    //   initialSettings: settings,
    //   pullToRefreshController: pullToRefreshController,
    //   onWebViewCreated: (controller) async{
    //     webViewController = controller;print("dddddddddddddddddddddddd===========");
    //    await webViewController!.resume();
    //   },
    //   onLoadStart: (controller, url) {
    //     setState(() {
    //       print("dddddddddddddddddddddddd");
    //       webViewController!.resume();
    //       this.url = url.toString();
    //       urlController.text = this.url;
    //     });
    //   },
    //   onPermissionRequest: (controller, request) async {
    //     return PermissionResponse(
    //         resources: request.resources,
    //         action: PermissionResponseAction.GRANT);
    //   },
    //   shouldOverrideUrlLoading:
    //       (controller, navigationAction) async {
    //     var uri = navigationAction.request.url!;
    //
    //     if (![
    //       "http",
    //       "https",
    //       "file",
    //       "chrome",
    //       "data",
    //       "javascript",
    //       "about"
    //     ].contains(uri.scheme)) {
    //       if (await canLaunchUrl(uri)) {
    //         // Launch the App
    //         await launchUrl(
    //           uri,
    //         );
    //         // and cancel the request
    //         return NavigationActionPolicy.CANCEL;
    //       }
    //     }
    //
    //     return NavigationActionPolicy.ALLOW;
    //   },
    //   onLoadStop: (controller, url) async {
    //     pullToRefreshController?.endRefreshing();
    //     setState(() {
    //       this.url = url.toString();
    //       urlController.text = this.url;
    //     });
    //   },
    //   onReceivedError: (controller, request, error) {
    //     pullToRefreshController?.endRefreshing();
    //   },
    //   onProgressChanged: (controller, progress) {
    //     if (progress == 100) {
    //       pullToRefreshController?.endRefreshing();
    //     }
    //     setState(() {
    //       this.progress = progress / 100;
    //       urlController.text = url;
    //     });
    //   },
    //   onUpdateVisitedHistory: (controller, url, androidIsReload) {
    //     setState(() {
    //       this.url = url.toString();
    //       urlController.text = this.url;
    //     });
    //   },
    //   onConsoleMessage: (controller, consoleMessage) {
    //     if (kDebugMode) {
    //       print(consoleMessage);
    //     }
    //   },
    // ),
    // progress < 1.0
    //     ? LinearProgressIndicator(value: progress)
    //     : Container(),
    return
        // ActionHandler().handleArrowAndEnterAction3(
        // child:
        Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        // child: RawKeyboardListener(
        // focusNode: FocusNode(),
        // child: Actions(
        // actions: <Type, Action<Intent>>{
        //   CloseButtonIntent: CallbackAction<CloseButtonIntent>(
        //     onInvoke: (intent) {
        //       Navigator.pop(context);
        //       return true;
        //     },
        //   ),
        //   UpButtonIntent: CallbackAction<UpButtonIntent>(
        //     onInvoke: (intent) {
        //       // _seekForward(10);
        //       // return _seekForward;
        //     },
        //   ),
        //   DownButtonIntent: CallbackAction<DownButtonIntent>(
        //     onInvoke: (intent) {
        //       // print("sssssssssssssssssssssssssssssssssssssssss");
        //       // _seekBackward(const Duration(minutes: 10));
        //       // return _seekBackward;
        //     },
        //   ),
        //   EnterButtonIntent: CallbackAction<EnterButtonIntent>(
        //     onInvoke: (intent) {
        //       if (isPlaying == true || isPlaying! == null) {
        //         webViewController?.pause();
        //         setState(() {
        //           isPlaying = false;
        //           isPlaying == false;
        //           print("object11112222 $isPlaying");
        //         });
        //       } else {
        //         webViewController?.resume();
        //         setState(() {
        //           isPlaying = true;
        //           isPlaying == true;
        //           print("object11113333 $isPlaying");
        //         });
        //       }
        //       return {
        //         if (isPlaying == true || isPlaying! == null)
        //           {
        //             webViewController?.pause(),
        //             setState(() {
        //               isPlaying = false;
        //               isPlaying == false;
        //               print("object11112222 $isPlaying");
        //             }),
        //           }
        //         else
        //           {
        //             webViewController?.resume(),
        //             setState(() {
        //               isPlaying = true;
        //               isPlaying == true;
        //               print("object11113333 $isPlaying");
        //             }),
        //           }
        //       };
        //     },
        //   ),
        //   RightButtonIntent: CallbackAction<RightButtonIntent>(
        //     onInvoke: (intent) {
        //       // _controller.runJavaScript(jsSeekTo(30));
        //       // return _controller.runJavaScript(jsSeekTo(30));
        //     },
        //   ),
        //   LeftButtonIntent: CallbackAction<LeftButtonIntent>(
        //     onInvoke: (intent) {
        //       // _controller.runJavaScript(jsSeekTo(30));
        //       // return _controller.runJavaScript(jsSeekTo(30));
        //     },
        //   ),
        // },
        child: InAppWebView(
          key: webViewKey,
          webViewEnvironment: webViewEnvironment,
          initialUrlRequest: URLRequest(
              url: WebUri(
                  "https://drive.google.com/file/d/${widget.url}/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")),
          initialSettings: settings,
          pullToRefreshController: pullToRefreshController,
          onWebViewCreated: (controller) async {
            webViewController = controller;
            await webViewController!
                .setAllMediaPlaybackSuspended(suspended: true);
            await webViewController!.platform.resume().then(
              (value) async {
                // print(await);
                print("dddddddddddddddddddddddd===========");
              },
            );
          },
          onLoadStart: (controller, url) {
            setState(() {
              print("dddddddddddddddddddddddd");
              // webViewController!.resume();
              this.url = url.toString();
              urlController.text = this.url;
            });
          },
          onPermissionRequest: (controller, request) async {
            return PermissionResponse(
                resources: request.resources,
                action: PermissionResponseAction.GRANT);
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            var uri = navigationAction.request.url!;

            if (![
              "http",
              "https",
              "file",
              "chrome",
              "data",
              "javascript",
              "about"
            ].contains(uri.scheme)) {
              if (await canLaunchUrl(uri)) {
                // Launch the App
                await launchUrl(
                  uri,
                );
                // and cancel the request
                return NavigationActionPolicy.CANCEL;
              }
            }

            return NavigationActionPolicy.ALLOW;
          },
          onLoadStop: (controller, url) async {
            pullToRefreshController?.endRefreshing();
            setState(() {
              this.url = url.toString();
              urlController.text = this.url;
            });
          },
          onReceivedError: (controller, request, error) {
            pullToRefreshController?.endRefreshing();
          },
          onProgressChanged: (controller, progress) {
            if (progress == 100) {
              pullToRefreshController?.endRefreshing();
            }
            setState(() {
              this.progress = progress / 100;
              urlController.text = url;
            });
          },
          onUpdateVisitedHistory: (controller, url, androidIsReload) {
            setState(() {
              this.url = url.toString();
              urlController.text = this.url;
            });
          },
          onConsoleMessage: (controller, consoleMessage) {
            if (kDebugMode) {
              print(consoleMessage);
            }
          },
        ),

        // child: WebViewWidget(controller: _controller
        // WebViewController()
        // ..setJavaScriptMode(JavaScriptMode.unrestricted)
        //   ..loadRequest(Uri.parse(
        //       "https://drive.google.com/file/d/${widget.url}/view"
        //     // "https://drive.google.com/file/d/${widget.url}/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w"
        //     // "https://drive.google.com/file/d/16arurRggjbrCClwAViQrWjCQNsLoOCw5/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")
        //   ))
      ),
      // ),
      // ),
      // )
      // ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:video_player/video_player.dart';
//
// class WatchingMovieView extends StatefulWidget {
//   final String url;
//
//   const WatchingMovieView({super.key, required this.url});
//
//   @override
//   _WatchingMovieViewState createState() => _WatchingMovieViewState();
// }
//
// class _WatchingMovieViewState extends State<WatchingMovieView> {
//   late FlickManager flickManager;
//   @override
//   void initState() {
//     super.initState();
//     flickManager = FlickManager(
//         autoPlay: true,
//         autoInitialize: true,
//         videoPlayerController: VideoPlayerController.networkUrl(
//           Uri.parse(
//               "https://drive.usercontent.google.com/download?id=${widget.url}&authuser=0&confirm=t&uuid=30a4b2c0-d98e-4fc3-909d-3c7868e03206&at=APvzH3poMdVn07hhKRLmdb7wxZhh%3A1734380470209"),
//         ));
//   }
//
//   @override
//   void dispose() {
//     flickManager.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // print("flickManager" );
//     // print(flickManager.flickVideoManager!.videoPlayerValue!.position);
//     return Container(
//       child: FlickVideoPlayer(flickManager: flickManager),
//     );
//   }
// }
