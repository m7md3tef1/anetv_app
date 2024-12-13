import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS/macOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../home/presentation/manager/all_movies_cubit/actionHandeler.dart';

import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

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
      "https://drive.google.com/file/d/1PnhdO3hSOS_EipQXZbBRoKVVSNRyk8jG/preview",
      hwAcc: HwAcc.auto,
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
    //   "https://drive.google.com/file/d/1PnhdO3hSOS_EipQXZbBRoKVVSNRyk8jG/preview",
    //   hwAcc: HwAcc.auto,
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
        child: InkWell(
          onTap: () async {
            print('objectsssssssssssssss');
            await convertMKVtoMP4(googleDriveFileId);
            print(('Download & Convert MKV to MP4'));
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text('MKV Video Player'),
              // toolbarHeight: 0,
            ),
            body: VlcPlayer(
              controller: _videoPlayerController,
              aspectRatio: 16 / 9, // Adjust the aspect ratio if needed
              placeholder: Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
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
//     // #docregion platform_features
//     late final PlatformWebViewControllerCreationParams params;
//
//     if (WebViewPlatform.instance is WebKitWebViewPlatform) {
//       params = WebKitWebViewControllerCreationParams(
//         // allowsInlineMediaPlayback: true,
//         // mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{
//         //   // PlaybackMediaTypes.video
//         // },
//       );
//     } else {
//       params = const PlatformWebViewControllerCreationParams();
//     }
//
//      _controller =
//         WebViewController.fromPlatformCreationParams(params);
//     // #enddocregion platform_features
//     print("object");
//     print(widget.url);
//     print(widget.url
//         .replaceAll("/view?usp=drivesdk",
//             "/preview?width=10&height=10&autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")
//         .replaceAll("/view?usp=drive_link",
//             "/preview?width=10&height=10&autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w"));
//     _controller
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..getUserAgent()
//       // ..runJavaScript(
//       //     'const video = document.querySelector("video"); if (video) video.play();')
//       ..enableZoom(true)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // debugPrint('WebView is loading (progress : $progress%)');
//           },
//           onPageStarted: (String url) {
//             // debugPrint('Page started loading: $url');
//           },
//           onPageFinished: (String url) {
//             //         _controller.evaluateJavascript('''
//             //   var videos = document.querySelectorAll('video');
//             //   videos.forEach(function(video) {
//             //     video.autoplay = true;
//             //     video.muted = true;  // If you want muted autoplay
//             //     video.play();
//             //   });
//             // ''');
//           },
//           onWebResourceError: (WebResourceError error) {
// //             debugPrint('''
// // Page resource error:
// //   code: ${error.errorCode}
// //   description: ${error.description}
// //   errorType: ${error.errorType}
// //   isForMainFrame: ${error.isForMainFrame}
// //           ''');
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('https://drive.google.com/')) {
//               debugPrint('blocking navigation to ${request.url}');
//               return NavigationDecision.prevent;
//             }
//             debugPrint('allowing navigation to ${request.url}');
//             return NavigationDecision.navigate;
//           },
//           onHttpError: (HttpResponseError error) {
//             // debugPrint('Error occurred on page: ${error.response?.statusCode}');
//           },
//           onUrlChange: (UrlChange change) {
//             // debugPrint('url change to ${change.url}');
//           },
//           onHttpAuthRequest: (HttpAuthRequest request) {},
//         ),
//       )
//       ..addJavaScriptChannel(
//         'Toaster',
//         onMessageReceived: (JavaScriptMessage message) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(message.message)),
//           );
//         },
//       )
//       ..loadRequest(Uri.parse(widget.url.replaceAll("/view?usp=drivesdk",
//           "/preview?width=10&height=10&autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")
//           .replaceAll("/view?usp=drive_link",
//           "/preview?width=10&height=10&autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")
//           // "https://drive.google.com/file/d/16arurRggjbrCClwAViQrWjCQNsLoOCw5/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")
//           ));
//     //   ..loadRequest(Uri.dataFromString('''
//     // <iframe src=\"https:\/\/vk.com\/video_ext.php?oid=-221539815&id=456239454&hash=44be08db4de388d7\" width=\"640\" height=\"360\" frameborder=\"0\" allowfullscreen=\"1\" allow=\"autoplay; encrypted-media; fullscreen; picture-in-picture\"><\/iframe>
//     // '''));
//
//     // setBackgroundColor is not currently supported on macOS.
//     if (kIsWeb || !Platform.isMacOS) {
//       _controller.setBackgroundColor(const Color(0x80000000));
//     }
//
//     // #docregion platform_features
//     if (_controller.platform is AndroidWebViewController) {
//       AndroidWebViewController.enableDebugging(true);
//       (_controller.platform as AndroidWebViewController)
//           .setMediaPlaybackRequiresUserGesture(false);
//     }
//     // #enddocregion platform_features
//
//     _controller ;
//   }
//
//   // Inject JavaScript to control video settings
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
//   @override
//   Widget build(BuildContext context) {
//     return ActionHandler().handleArrowAndEnterAction(
//       child: Actions(
//         actions: <Type, Action<Intent>>{
//           CloseButtonIntent: CallbackAction<CloseButtonIntent>(
//             onInvoke: (intent) {
//               return Navigator.pop(context);
//             },
//           )
//         },
//         child: Scaffold(
//           body: Actions(
//             actions: {
//               CloseButtonIntent: CallbackAction<CloseButtonIntent>(
//                 onInvoke: (intent) {
//                   return Navigator.pop(context);
//                 },
//               ),
//             },
//             child: Column(
//               children: [
//                 Expanded(child: WebViewWidget(controller: _controller)),
//                 ElevatedButton(
//                   onPressed: playVideo,
//                   child: Text("Play"),
//                 ),
//                 Row(
//                   children: [
//                     ElevatedButton(
//                       onPressed: pauseVideo,
//                       child: Text("Pause"),
//                     ),
//                   ],
//                 ),
//                 ElevatedButton(
//                   onPressed: () => seekTo(30), // Seek to 30 seconds
//                   child: Text("Seek to 30s"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // You can call these functions to control the video
//   void playVideo() async{
//   await  _controller.runJavaScript(
//         'const video = document.querySelector("video"); if (video) video.play();');
//   }
//
//   void pauseVideo() async{
//     await _controller.runJavaScript(
//         'const video = document.querySelector("video"); if (video) video.pause();');
//   }
//
//   void seekTo(double seconds) async{
//     await _controller.runJavaScript(
//         'const video = document.querySelector("video"); if (video) video.currentTime = $seconds;');
//   }
// }
/*
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WatchingMovieView extends StatefulWidget {
  final String url;
//
  const WatchingMovieView({super.key, required this.url});
  @override
  _WatchingMovieViewState createState() => _WatchingMovieViewState();
}

class _WatchingMovieViewState extends State<WatchingMovieView> {
  late VideoPlayerController _controller;
  // https://drive.google.com/file/d/16arurRggjbrCClwAViQrWjCQNsLoOCw5/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w
  @override
  void initState() {
    super.initState();
    print("object");
    print(
        "https://mega.nz/embed/kZAAXJIR#rvaqBncAmSXvXrZJ8ArNSAqK8LPgfDJxMGlz42MfziI!1a");
    print(
        "https://drive.google.com/uc?export=download&id=1Uetbi3FWdEJMxcdzY9uLLRbSSqgDpIpI");
    print(
        "https://drive.google.com/uc?export=download&id=1zpIBzji4T-lmOp_Y4iAlXGkK6QNI8Sw4");
    // print( widget.url
    //     .replaceAll("/view?usp=drivesdk",
    //     "/preview?usp=drive_link&key=1-wNT6W0_vHfh3wAeS8rrJ6w"));
    print(widget.url);
    // print(
    //     "https://drive.google.com/uc?export=download&id=16arurRggjbrCClwAViQrWjCQNsLoOCw5/preview?autoplay=1");
    // Replace the link below with your modified Google Drive link
    _controller = VideoPlayerController.network(
        "https://drive.google.com/file/d/1r-wpwMeCRl51Ik0pIP_yT68vwf5wuFS0")
      ..initialize().then((_) {
        _controller.play();
        // _controller.seekTo(Duration(seconds: 10));
        // Ensure the first frame is shown
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Google Drive Video')),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
*/
/*
class WatchingMovieView extends StatefulWidget {
  final String url;
//
  const WatchingMovieView({super.key, required this.url});
  @override
  State<WatchingMovieView> createState() => WatchingMovieViewState();
}

class WatchingMovieViewState extends State<WatchingMovieView> {
  // Create a [Player] to control playback.
  late final player = Player();
  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();
    // Play a [Media] or [Playlist].
    print(widget.url);
    String googleDriveFileID = "1DVjy2aY7ckmUzVZMgaLdoC9cbMFbIJ9V";
    String videoUrl = "https://drive.google.com/uc?export=download&id=$googleDriveFileID";
    player.open(Media(widget.url));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 9.0 / 16.0,
        // Use [Video] widget to display video output.
        child: Video(controller: controller),
      ),
    );
  }
}*/
