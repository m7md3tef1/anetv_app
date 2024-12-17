import 'dart:io';

import 'package:anetv/featuers/home/presentation/manager/all_movies_cubit/actionHandeler.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_win/video_player_win.dart';
// import '../../../home/presentation/manager/all_movies_cubit/actionHandeler.dart';
/*
final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();

Future<void> transcodeMKV(String inputPath, String outputPath) async {
  await _flutterFFmpeg
      .execute('-i $inputPath -c:v libx264 -c:a aac $outputPath');
}

class WatchingMovieView extends StatefulWidget {
  final String url;

  WatchingMovieView({required this.url});

  @override
  _WatchingMovieViewState createState() => _WatchingMovieViewState();
}

class _WatchingMovieViewState extends State<WatchingMovieView> {
  late VlcPlayerController _videoPlayerController;
  static const _networkCachingMs = 2000;
  static const _subtitlesFontSize = 30;
  static const _height = 400.0;
  // Future<void> storeVideoUrlInFirestore(String downloadUrl) async {
  //   try {
  //     // Reference to Firestore collection
  //     CollectionReference videosCollection = FirebaseFirestore.instance.collection('videos');
  //
  //     // Add the video URL to Firestore
  //     await videosCollection.add({'videoUrl': downloadUrl});
  //
  //     print("Video URL saved to Firestore.");
  //   } catch (e) {
  //     print("Error saving video URL to Firestore: $e");
  //   }
  // }
  final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  bool isConverting = false;

  // Replace with your Google Drive file ID
  final String googleDriveFileId = '1PnhdO3hSOS_EipQXZbBRoKVVSNRyk8jG';
  // Construct the direct download URL
  String getDirectDownloadUrl(String fileId) {
    return 'https://drive.google.com/uc?export=download&id=$fileId';
  }

  // Function to convert MKV video to MP4 on the fly
  Future<void> convertMKVtoMP4(String fileId) async {
    setState(() {
      isConverting = true;
    });

    // Construct the URL for Google Drive video
    final String inputUrl = getDirectDownloadUrl(fileId);

    // Set up the path to save the MP4 file
    final Directory appDocDir = await Directory.systemTemp.createTemp();
    final String outputPath = '${appDocDir.path}/converted_video.mp4';

    // FFmpeg command to transcode the stream directly
    final String command =
        '-i $inputUrl -c:v libx264 -c:a aac -strict experimental $outputPath';

    // Execute the FFmpeg command to convert and stream the video
    await _flutterFFmpeg.execute(command).then((rc) {
      if (rc == 0) {
        setState(() {
          isConverting = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Video converted to MP4 successfully!')));
      } else {
        setState(() {
          isConverting = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Conversion failed!')));
      }
    });
  }

  // Function to download the MKV video from Google Drive
  // Future<String> downloadGoogleDriveVideo(String fileId) async {
  //   final String downloadUrl =
  //       'https://drive.google.com/uc?export=download&id=$fileId';
  //   final response = await http.get(Uri.parse(downloadUrl));
  //
  //   if (response.statusCode == 200) {
  //     // Save the video to a temporary file
  //     final tempDir = await getTemporaryDirectory();
  //     final tempFilePath = '${tempDir.path}/video.mkv';
  //     File tempFile = File(tempFilePath);
  //
  //     // Write the downloaded video to a file
  //     await tempFile.writeAsBytes(response.bodyBytes);
  //     return tempFilePath;
  //   } else {
  //     throw Exception('Failed to download video from Google Drive');
  //   }
  // }

  // Function to convert MKV to MP4
  // Future<void> convertMKVtoMP4(String inputPath) async {
  //   setState(() {
  //     isConverting = true;
  //   });
  //
  //   // Get the path to save the MP4 file
  //   final tempDir = await getTemporaryDirectory();
  //   final outputFilePath = '${tempDir.path}/converted_video.mp4';
  //
  //   // Execute the conversion command
  //   final command =
  //       '-i $inputPath -c:v libx264 -c:a aac -strict experimental $outputFilePath';
  //   await _flutterFFmpeg.execute(command).then((rc) {
  //     if (rc == 0) {
  //       setState(() {
  //         isConverting = false;
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Video converted to MP4 successfully!')));
  //     } else {
  //       setState(() {
  //         isConverting = false;
  //       });
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text('Conversion failed!')));
  //     }
  //   });
  // }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Store Google Drive video link
  Future<void> storeVideoLink(String videoLink) async {
    try {
      await _firestore.collection('videos').add({
        'videoUrl': videoLink, // Storing Google Drive video URL
        'timestamp': FieldValue.serverTimestamp(),
      });
      print("Video link stored successfully");
      _firestore.collection('videos').get().then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          String videoUrl = doc['videoUrl']; // Get stored Google Drive URL
          VlcPlayerController.network(
              videoUrl); // Set the Google Drive URL to the player
          setState(() {
            // Force rebuild to use the updated URL
          });
        }
      }).catchError((e) {
        print("Error retrieving video link: $e");
      });
    } catch (e) {
      print("Error storing video link: $e");
    }
  }

  @override
  void initState() {
    // Step 1: Download the video from Google Drive

    // Example Google Drive link (replace with your actual link)
    // String googleDriveLink = 'https://drive.google.com/file/d/1Uetbi3FWdEJMxcdzY9uLLRbSSqgDpIpI/preview';
    //
    // // Store the link in Firestore
    // storeVideoLink(googleDriveLink);

    print(widget.url);
    print(widget.url
        .replaceAll("/view?usp=drivesdk",
            "/preview?autoplay=1&key=1-wNT6W0_vHfh3wAeS8rrJ6w")
        .replaceAll("/view?usp=drive_link",
            "/preview?autoplay=1&key=1-wNT6W0_vHfh3wAeS8rrJ6w"));
    print(
        "https://drive.google.com/uc?id=1Uetbi3FWdEJMxcdzY9uLLRbSSqgDpIpI&export=download");
    print("object");
    print(
        "https://drive.google.com/uc?export=download&id=1Uetbi3FWdEJMxcdzY9uLLRbSSqgDpIpI");
    super.initState();
    _videoPlayerController = VlcPlayerController.network(
      "https://drive.google.com/uc?export=download&id=1_D_aes6p5rLn-gUZXYTkGkrhKJFx3NU4",
      // hwAcc: HwAcc.auto,
      autoInitialize: true,
      // options: VlcPlayerOptions(
      //   advanced: VlcAdvancedOptions([
      //     VlcAdvancedOptions.networkCaching(_networkCachingMs),
      //     VlcAdvancedOptions.liveCaching(2500),
      //   ]),
      //   subtitle: VlcSubtitleOptions([
      //     VlcSubtitleOptions.boldStyle(true),
      //     VlcSubtitleOptions.fontSize(_subtitlesFontSize),
      //     VlcSubtitleOptions.outlineColor(VlcSubtitleColor.yellow),
      //     VlcSubtitleOptions.outlineThickness(VlcSubtitleThickness.normal),
      //     // works only on externally added subtitles
      //     VlcSubtitleOptions.color(VlcSubtitleColor.navy),
      //   ]),
      //   http: VlcHttpOptions([
      //     VlcHttpOptions.httpReconnect(true),
      //   ]),
      //   rtp: VlcRtpOptions([
      //     VlcRtpOptions.rtpOverRtsp(true),
      //   ]),
      // ),
    )..addListener(() {
        if (_videoPlayerController.value.isBuffering) {
          // Display loading or buffering indicator
          print("Buffering...");
        }
        if (_videoPlayerController.value.isInitialized) {
          // Hide buffering indicator
          print("Video Initialized");
        }
      });
    print(
        "https://drive.google.com/file/d/1PnhdO3hSOS_EipQXZbBRoKVVSNRyk8jG/preview");
    // _videoPlayerController = VlcPlayerController.network(
    //   "https://drive.google.com/uc?export=download&id=1_D_aes6p5rLn-gUZXYTkGkrhKJFx3NU4",

    //   autoInitialize: true,
    //   options: VlcPlayerOptions(
    //     advanced: VlcAdvancedOptions([
    //       VlcAdvancedOptions.networkCaching(_networkCachingMs),
    //       VlcAdvancedOptions.liveCaching(2500),
    //     ]),
    //     subtitle: VlcSubtitleOptions([
    //       VlcSubtitleOptions.boldStyle(true),
    //       VlcSubtitleOptions.fontSize(_subtitlesFontSize),
    //       VlcSubtitleOptions.outlineColor(VlcSubtitleColor.yellow),
    //       VlcSubtitleOptions.outlineThickness(VlcSubtitleThickness.normal),
    //       // works only on externally added subtitles
    //       VlcSubtitleOptions.color(VlcSubtitleColor.navy),
    //     ]),
    //     http: VlcHttpOptions([
    //       VlcHttpOptions.httpReconnect(true),
    //     ]),
    //     rtp: VlcRtpOptions([
    //       VlcRtpOptions.rtpOverRtsp(true),
    //     ]),
    //   ),
    // );
    //
    // _videoPlayerController.addOnInitListener(() async {
    //   await _videoPlayerController.startRendererScanning();
    // });
    // _videoPlayerController.addOnRendererEventListener((type, id, name) {
    //   debugPrint('OnRendererEventListener $type $id $name');
    // });
  }

  // _videoPlayerController.play();
  // _videoPlayerController.seekTo(Duration(seconds: 30));

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose(); // Don't forget to dispose
  }

  // Function to go back by a specific duration (e.g., 10 seconds)
  void _seekBackwards() async {
    Duration currentPosition = _videoPlayerController.value.position;
    Duration newPosition = currentPosition - const Duration(seconds: 10);

    if (newPosition < Duration.zero) {
      newPosition = Duration.zero; // Prevent seeking to negative time
    }

    _videoPlayerController.seekTo(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    return ActionHandler().handleArrowAndEnterAction(
      child: Actions(
        actions: <Type, Action<Intent>>{
          CloseButtonIntent: CallbackAction<CloseButtonIntent>(
            onInvoke: (intent) {
              return Navigator.pop(context);
            },
          ),
          RightButtonIntent: CallbackAction<RightButtonIntent>(
            onInvoke: (intent) {
              return _videoPlayerController.seekTo(const Duration(seconds: 10));
            },
          ),
          LeftButtonIntent: CallbackAction<LeftButtonIntent>(
            onInvoke: (intent) {
              return _seekBackwards();
            },
          ),
          EnterButtonIntent: CallbackAction<EnterButtonIntent>(
            onInvoke: (intent) {
              return _videoPlayerController.play();
            },
          ),
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('MKV Video Player'),
            // toolbarHeight: 0,
          ),
          body: Column(
            children: [
              VlcPlayer(
                controller: _videoPlayerController,
                aspectRatio: 16 / 9, // Adjust the aspect ratio if needed
                placeholder: Center(child: CircularProgressIndicator()),
              ),
              // InkWell(
              //     onTap: () async {
              //       print('objectsssssssssssssss');
              //       await convertMKVtoMP4(googleDriveFileId);
              //       print(('Download & Convert MKV to MP4'));
              //     },
              //     child: Text("data"))
            ],
          ),
        ),
      ),
    );
  }
}
*/

class WatchingMovieView extends StatefulWidget {
  final String url;
//
  const WatchingMovieView({super.key, required this.url});

  @override
  State<WatchingMovieView> createState() => _WatchingMovieViewState();
}

class _WatchingMovieViewState extends State<WatchingMovieView> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();

    // Example Google Drive link (replace with your actual link)

    _betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        aspectRatio: 16 / 9,
        autoPlay: true,
        looping: true,
      ),
    );

    // Replace with your direct download link
    // String videoUrl = widget.url;
    _betterPlayerController.setupDataSource(
      BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        "https://drive.usercontent.google.com/download?id=1_D_aes6p5rLn-gUZXYTkGkrhKJFx3NU4&authuser=0&confirm=t&uuid=30a4b2c0-d98e-4fc3-909d-3c7868e03206&at=APvzH3poMdVn07hhKRLmdb7wxZhh%3A1734380470209",
        liveStream: true,
        // videoFormat: BetterPlayerVideoFormat.other,
        cacheConfiguration: const BetterPlayerCacheConfiguration(
          useCache: true,
          // maxCacheSize: 100 * 1024 * 1024, // Cache up to 100MB
          // maxCacheFileSize: 50 * 1024 * 1024, // Max single file cache size 50MB
        ),
      ),
    );
  }

  void _seekBackward(seekDuration) async {
    // print('aaaaaaaaaa');
    // print(seekDuration);

    final currentPosition =
        await _betterPlayerController.videoPlayerController!.value.position;
    if (currentPosition != null) {
      final newPosition = currentPosition - seekDuration;
      setState(() {
        _betterPlayerController
            .seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
      });
    }
  }

  void _seekForward(_seekAmount) async {
    // print('bbbbbbbbbbbbbbbbb');
    // print(_seekAmount);

    final currentPosition =
        await _betterPlayerController.videoPlayerController!.value.position;
    setState(() {
      _betterPlayerController
          .seekTo(currentPosition! + Duration(minutes: _seekAmount.toInt()));
    });
  }

  void togglePlayPause() {
    if (_betterPlayerController.videoPlayerController!.value.isPlaying) {
      // print('cccccccccccc');
      setState(() {
        _betterPlayerController.pause();
      });
    } else {
      // print('dddddddddd');
      setState(() {
        _betterPlayerController.play();
      });
    }
  }

  // final String videoUrl = "https://drive.google.com/file/d/1PnhdO3hSOS_EipQXZbBRoKVVSNRyk8jG/preview"; // Replace with your MKV file URL
  final String videoUrl =
      "https://drive.google.com/file/d/1DVjy2aY7ckmUzVZMgaLdoC9cbMFbIJ9V/view?usp=drivesdk";
  // Replace with your MKV file URL
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
                      return Navigator.pop(context);
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
                  child: AspectRatio(
                      aspectRatio: _betterPlayerController
                          .videoPlayerController!.value.aspectRatio,
                      child: BetterPlayer(
                        controller: _betterPlayerController,
                      )),
                ),
              ),
            )),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: togglePlayPause,
        //   child:
        //       Icon(controller!.value.isPlaying ? Icons.pause : Icons.play_arrow),
        // ),
      ),
    );
  }
}

// class WatchingMovieView extends StatefulWidget {
//   final String url;
//
//   const WatchingMovieView({super.key, required this.url});
//
//   @override
//   WatchingMovieViewState createState() => WatchingMovieViewState();
// }
//
// class WatchingMovieViewState extends State<WatchingMovieView> {
//   // late VideoPlayerController _controller;
//   // late WebViewController _webViewController;
//   bool isIframe = false;
//
//   late final WebViewController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // print("widget.url");print(widget.url.contains("iframe") || widget.url.contains("</iframe>"));
//     if (widget.url.contains("iframe") || widget.url.contains("</iframe>")) {
//       print("widget.url2222");
//       // _controller = WebViewController()
//       //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       //   ..loadRequest(Uri.dataFromString(widget.url));
//     } else {
//       // #docregion platform_features
//       late final PlatformWebViewControllerCreationParams params;
//
//       if (WebViewPlatform.instance is WebKitWebViewPlatform) {
//         params = WebKitWebViewControllerCreationParams(
//           // allowsInlineMediaPlayback: true,
//           mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{
//             PlaybackMediaTypes.video
//           },
//         );
//       } else {
//         params = const PlatformWebViewControllerCreationParams();
//       }
//
//       _controller = WebViewController.fromPlatformCreationParams(params);
//       // #enddocregion platform_features
//       // print("object");
//       // print(widget.url);
//       // print(widget.url
//       //     .replaceAll("/view?usp=drivesdk",
//       //         "/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")
//       //     .replaceAll("/view?usp=drive_link",
//       //         "/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")
//       //     .replaceAll("/view?usp=sharing",
//       //         "/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w"));
//       _controller
//         ..setJavaScriptMode(JavaScriptMode.unrestricted)
//         ..getUserAgent()
//         // ..runJavaScript(
//         //     'const video = document.querySelector("video"); if (video) video.play();')
//         ..enableZoom(true)
//         ..setNavigationDelegate(
//           NavigationDelegate(
//             onProgress: (int progress) {
//               // debugPrint('WebView is loading (progress : $progress%)');
//             },
//             onPageStarted: (String url) {
//               // debugPrint('Page started loading: $url');
//             },
//             onPageFinished: (String url) {
//               //         _controller.evaluateJavascript('''
//               //   var videos = document.querySelectorAll('video');
//               //   videos.forEach(function(video) {
//               //     video.autoplay = true;
//               //     video.muted = true;  // If you want muted autoplay
//               //     video.play();
//               //   });
//               // ''');
//             },
//             onWebResourceError: (WebResourceError error) {
// //             debugPrint('''
// // Page resource error:
// //   code: ${error.errorCode}
// //   description: ${error.description}
// //   errorType: ${error.errorType}
// //   isForMainFrame: ${error.isForMainFrame}
// //           ''');
//             },
//             onNavigationRequest: (NavigationRequest request) {
//               if (request.url.startsWith('https://drive.google.com/')) {
//                 debugPrint('blocking navigation to ${request.url}');
//                 return NavigationDecision.prevent;
//               }
//               debugPrint('allowing navigation to ${request.url}');
//               return NavigationDecision.navigate;
//             },
//             onHttpError: (HttpResponseError error) {
//               // debugPrint('Error occurred on page: ${error.response?.statusCode}');
//             },
//             onUrlChange: (UrlChange change) {
//               // debugPrint('url change to ${change.url}');
//             },
//             onHttpAuthRequest: (HttpAuthRequest request) {},
//           ),
//         )
//         ..addJavaScriptChannel(
//           'Toaster',
//           onMessageReceived: (JavaScriptMessage message) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(message.message)),
//             );
//           },
//         )
//         ..loadRequest(Uri.parse(widget.url
//                 .replaceAll("/view?usp=drivesdk",
//                     "/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")
//                 .replaceAll("/view?usp=drive_link",
//                     "/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")
//                 .replaceAll("/view?usp=sharing",
//                     "/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")
//             // "https://drive.google.com/file/d/16arurRggjbrCClwAViQrWjCQNsLoOCw5/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")
//             ));
//       //   ..loadRequest(Uri.dataFromString('''
//       // <iframe src=\"https:\/\/vk.com\/video_ext.php?oid=-221539815&id=456239454&hash=44be08db4de388d7\" width=\"640\" height=\"360\" frameborder=\"0\" allowfullscreen=\"1\" allow=\"autoplay; encrypted-media; fullscreen; picture-in-picture\"><\/iframe>
//       // '''));
//
//       // setBackgroundColor is not currently supported on macOS.
//       if (kIsWeb || !Platform.isMacOS) {
//         _controller.setBackgroundColor(const Color(0x80000000));
//       }
//
//       // #docregion platform_features
//       if (_controller.platform is AndroidWebViewController) {
//         AndroidWebViewController.enableDebugging(true);
//         (_controller.platform as AndroidWebViewController)
//             .setMediaPlaybackRequiresUserGesture(false);
//       }
//     }
//     // #enddocregion platform_features
//   }
//
//   //Inject JavaScript to control video settings
//   void _injectVideoSettings() {
//     _controller.runJavaScript('''
//       var videos = document.querySelectorAll('video');
//       videos.forEach(function(video) {
//         video.autoplay = true;  // Enable autoplay
//         video.muted = true;     // Mute video
//         video.play();           // Play video
//       });
//     ''');
//   }
//
//   Offset _mousePosition = Offset.zero;
//   // bool _isShortcutActivated = false;
//
//   void _moveMouse(Offset delta) {
//     setState(() {
//       _mousePosition += delta;
//     });
//   }
//
//   void handleKeyPress(RawKeyEvent event) {
//     if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
//       // Seek forward
//       _controller.runJavaScript("""
//         const video = document.querySelector('video');
//         if (video) video.currentTime += 10;
//       """);
//     } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
//       // Seek backward
//       _controller.runJavaScript("""
//         const video = document.querySelector('video');
//         if (video) video.currentTime -= 10;
//       """);
//     } else if (event.isKeyPressed(LogicalKeyboardKey.space)) {
//       // Play/Pause toggle
//       _controller.runJavaScript("""
//         const video = document.querySelector('video');
//         if (video) {
//           if (video.paused) video.play();
//           else video.pause();
//         }
//       """);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
// //     _controller.loadRequest(Uri.parse(widget.url
// //               .replaceAll("/view?usp=drivesdk",
// //                   "/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")
// //               .replaceAll("/view?usp=drive_link",
// //                   "/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")));
// //     _controller.runJavaScript("""
// //   document.addEventListener('keydown', function(event) {
// //     const video = document.querySelector('video');
// //     if (!video) return;
// //
// //     switch (event.code) {
// //       case 'ArrowRight':
// //         video.currentTime += 10; // Seek forward
// //         break;
// //       case 'ArrowLeft':
// //         video.currentTime -= 10; // Seek backward
// //         break;
// //       case 'Space':
// //         if (video.paused) {
// //           video.play();
// //         } else {
// //           video.pause();
// //         }
// //         break;
// //     }
// //   });
// // """);
//
//     return Scaffold(
//         body: (widget.url.contains("iframe") ||
//                 widget.url.contains("</iframe>"))
//             ? Center(
//                 child: Text("Url Is InValid \n ${widget.url}",
//                     textAlign: TextAlign.center),
//               )
//             : RawKeyboardListener(
//                 focusNode: FocusNode(),
//                 autofocus: true,
//                 onKey: handleKeyPress,
//                 child: WebViewWidget(controller: _controller
//                     // WebViewController()
//                     //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
//                     //   ..loadRequest(Uri.parse(widget.url
//                     //       .replaceAll("/view?usp=drivesdk",
//                     //           "/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")
//                     //       .replaceAll("/view?usp=drive_link",
//                     //           "/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")
//                     //       .replaceAll("/view?usp=sharing",
//                     //           "/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")))
//                     )));
//     // Shortcuts(
//     // shortcuts: <LogicalKeySet, Intent>{
//     //   LogicalKeySet(LogicalKeyboardKey.arrowUp): UpButtonIntent(),
//     //   LogicalKeySet(LogicalKeyboardKey.arrowDown): DownButtonIntent(),
//     //   LogicalKeySet(LogicalKeyboardKey.arrowLeft): LeftButtonIntent(),
//     //   LogicalKeySet(LogicalKeyboardKey.arrowRight): RightButtonIntent(),
//     //   LogicalKeySet(LogicalKeyboardKey.enter): EnterButtonIntent(),
//     //   LogicalKeySet(LogicalKeyboardKey.select): EnterButtonIntent(),
//     // },
//     // child: Actions(
//     // actions: <Type, Action<Intent>>{
//     //   UpButtonIntent: CallbackAction(
//     //     onInvoke: (intent) => _moveMouse(Offset(0, -10)),
//     //   ),
//     //   DownButtonIntent: CallbackAction(
//     //     onInvoke: (intent) => _moveMouse(Offset(0, 10)),
//     //   ),
//     //   LeftButtonIntent: CallbackAction(
//     //     onInvoke: (intent) => _moveMouse(Offset(-10, 0)),
//     //   ),
//     //   RightButtonIntent: CallbackAction(
//     //     onInvoke: (intent) => _moveMouse(Offset(10, 0)),
//     //   ),
//     //   EnterButtonIntent: CallbackAction(
//     //     onInvoke: (intent) {
//     //       // setState(() {
//     //       //   print("sssssssssssssssssssssss");
//     //       // });
//     //       return print("sssssssssssssssssssssss");
//     //       // setState(() {
//     //       //   _isShortcutActivated = !_isShortcutActivated;
//     //       // });
//     //     },
//     //   ),
//     // },
//     // child:
//     // Stack(
//     //   alignment: AlignmentDirectional.center,
//     //   children: [
//     //     // Display shortcut state
//     //     // Positioned(
//     //     //   top: 10,
//     //     //   left: 10,
//     //     //   child: Text(
//     //     //     _isShortcutActivated
//     //     //         ? 'Shortcut Activated'
//     //     //         : 'Shortcut Deactivated',
//     //     //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//     //     //   ),
//     //     // )
//     //     MouseRegion(
//     //         cursor: SystemMouseCursors.click,
//     //         // onHover: (event) {
//     //         //   setState(() {
//     //         //     _mousePosition = event.position;
//     //         //   });
//     //         // },
//     //         child: WebViewWidget(controller: _controller)),
//     //     Positioned(
//     //       left: _mousePosition.dx,
//     //       top: _mousePosition.dy,
//     //       child: const Icon(Icons.mouse, size: 24, color: Colors.blue),
//     //     )
//     //   ],
//     // ),
//     //   ),
//     // ),
//     // );
//   }
//
//   // You can call these functions to control the video
//   void playVideo() async {
//     await _controller.runJavaScript(
//         'const video = document.querySelector("video"); if (video) video.play();');
//   }
//
//   void pauseVideo() async {
//     await _controller.runJavaScript(
//         'const video = document.querySelector("video"); if (video) video.pause();');
//   }
//
//   void seekTo(double seconds) async {
//     await _controller.runJavaScript(
//         'const video = document.querySelector("video"); if (video) video.currentTime = $seconds;');
//   }
// }
/*
class WatchingMovieView extends StatefulWidget {
  final String url;

  const WatchingMovieView({super.key, required this.url});
  @override
  _WatchingMovieViewState createState() => _WatchingMovieViewState();
}

class _WatchingMovieViewState extends State<WatchingMovieView> {
  // late VideoPlayerController _controller;
  // final Duration seekDuration = const Duration(minutes: 10);
  // List<Subtitle> subtitles = [];
  // String currentCaption = "";

  late VideoPlayerController videoPlayerController;
  // late VideoPlayerController videoPlayerController;
  WinVideoPlayerController? controller;
  @override
  void initState() {
    super.initState();

    print("object");
    print(widget.url);
    if (Platform.isWindows) {
      controller = WinVideoPlayerController.network(
        'https://drive.usercontent.google.com/download?id=${widget.url}&authuser=0&confirm=t&uuid=30a4b2c0-d98e-4fc3-909d-3c7868e03206&at=APvzH3poMdVn07hhKRLmdb7wxZhh%3A1734380470209',
      );

      controller!.initialize().then((value) {
        if (controller!.value.isInitialized) {
          controller!.play();
          controller!.setLooping(true);
          setState(() {});

          controller!.addListener(() {
            if (controller!.value.isCompleted) {
              print("ui: player completed, pos=${controller!.value.position}");
            }
          });
        } else {
          print("video file load failed");
        }
      }).catchError((e) {
        print("controller.initialize() error occurs: $e");
      });
      controller!.setLooping(true);
      controller!.play();
      setState(() {});
    } else {
      init();
    }
    // _loadSubtitles();
    // _controller = VideoPlayerController.networkUrl(
    //   Uri.parse(
    //       "https://drive.usercontent.google.com/download?id=${widget.url}&authuser=0&confirm=t&uuid=30a4b2c0-d98e-4fc3-909d-3c7868e03206&at=APvzH3poMdVn07hhKRLmdb7wxZhh%3A1734380470209"),
    // videoPlayerOptions: VideoPlayerOptions(
    //     webOptions: const VideoPlayerWebOptions(
    //         allowContextMenu: true,
    //         // controls: VideoPlayerWebOptionsControls.enabled(
    //         //     allowDownload: true, allowFullscreen: true)
    //     )),
    // );
    // ..initialize().then((_) {
    //   setState(() {
    //     // _controller.addListener(_updateCaption);
    //     _controller.play();
    //   });
    // });
  }

  init() async {
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        'https://drive.usercontent.google.com/download?id=${widget.url}&authuser=0&confirm=t&uuid=30a4b2c0-d98e-4fc3-909d-3c7868e03206&at=APvzH3poMdVn07hhKRLmdb7wxZhh%3A1734380470209'));
    await videoPlayerController.initialize().then((v) {
      setState(() {});
    });
    await videoPlayerController.play();
  }

  void _seekBackward(seekDuration) async {
    // print('aaaaaaaaaa');
    // print(seekDuration);
    if (Platform.isWindows) {
      final currentPosition = await controller!.position;
      if (currentPosition != null) {
        final newPosition = currentPosition - seekDuration;
        setState(() {
          controller!.seekTo(
              newPosition > Duration.zero ? newPosition : Duration.zero);
        });
      }
    } else {
      final currentPosition = await videoPlayerController.position;
      if (currentPosition != null) {
        final newPosition = currentPosition - seekDuration;
        setState(() {
          videoPlayerController.seekTo(
              newPosition > Duration.zero ? newPosition : Duration.zero);
        });
      }
    }
  }
  void _seekForward(_seekAmount) async {
    // print('bbbbbbbbbbbbbbbbb');
    // print(_seekAmount);
    if (Platform.isWindows) {
      final currentPosition = await controller!.value.position;
      setState(() {
        controller!
            .seekTo(currentPosition + Duration(minutes: _seekAmount.toInt()));
      });
    } else {
      final currentPosition = await videoPlayerController.value.position;
      setState(() {
        videoPlayerController
            .seekTo(currentPosition + Duration(minutes: _seekAmount.toInt()));
      });
    }
  }

  void togglePlayPause() {
    if (Platform.isWindows) {
      if (controller!.value.isPlaying) {
        // print('cccccccccccc');
        setState(() {
          controller!.pause();
        });
      } else {
        // print('dddddddddd');
        setState(() {
          controller!.play();
        });
      }
    } else {
      if (videoPlayerController.value.isPlaying) {
        // print('cccccccccccc');
        setState(() {
          videoPlayerController.pause();
        });
      } else {
        // print('dddddddddd');
        setState(() {
          videoPlayerController.play();
        });
      }
    }
  }
  @override
  void dispose() {
    Platform.isWindows
        ? controller!.dispose()
        : videoPlayerController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    // print(!Platform.isWindows);
    return ActionHandler().handleArrowAndEnterAction3(
      child: Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: !Platform.isWindows
              ? RawKeyboardListener(
                  focusNode: FocusNode(),
                  child: Actions(
                    actions: <Type, Action<Intent>>{
                      CloseButtonIntent: CallbackAction<CloseButtonIntent>(
                        onInvoke: (intent) {
                          Navigator.pop(context);
                          return Navigator.pop(context);
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
                      child: AspectRatio(
                          aspectRatio: videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(videoPlayerController)),
                    ),
                  ),
                )
              : ValueListenableBuilder<WinVideoPlayerValue>(
                  valueListenable: controller!,
                  builder: ((context, value, child) {
                    return RawKeyboardListener(
                      focusNode: FocusNode(),
                      child: Actions(
                        actions: <Type, Action<Intent>>{
                          CloseButtonIntent: CallbackAction<CloseButtonIntent>(
                            onInvoke: (intent) {
                              Navigator.pop(context);
                              return Navigator.pop(context);
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
                          child: WinVideoPlayer(controller!),
                        ),
                      ),
                    );
                  }),
                ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: togglePlayPause,
        //   child:
        //       Icon(controller!.value.isPlaying ? Icons.pause : Icons.play_arrow),
        // ),
      ),
    );
  }
}
*/
