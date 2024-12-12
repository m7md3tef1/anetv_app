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
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

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
