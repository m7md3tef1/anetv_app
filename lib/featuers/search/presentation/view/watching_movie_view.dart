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

  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{
          // PlaybackMediaTypes.video
        },
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features
    print("object");
    print(widget.url);
    print(widget.url
        .replaceAll("/view?usp=drivesdk",
            "/preview?width=10&height=10&autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")
        .replaceAll("/view?usp=drive_link",
            "/preview?width=10&height=10&autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w"));
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..getUserAgent()
      ..enableZoom(true)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            // debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            //         _controller.evaluateJavascript('''
            //   var videos = document.querySelectorAll('video');
            //   videos.forEach(function(video) {
            //     video.autoplay = true;
            //     video.muted = true;  // If you want muted autoplay
            //     video.play();
            //   });
            // ''');
          },
          onWebResourceError: (WebResourceError error) {
//             debugPrint('''
// Page resource error:
//   code: ${error.errorCode}
//   description: ${error.description}
//   errorType: ${error.errorType}
//   isForMainFrame: ${error.isForMainFrame}
//           ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://drive.google.com/')) {
            //   debugPrint('blocking navigation to ${request.url}');
            //   return NavigationDecision.prevent;
            // }
            // debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onHttpError: (HttpResponseError error) {
            // debugPrint('Error occurred on page: ${error.response?.statusCode}');
          },
          onUrlChange: (UrlChange change) {
            // debugPrint('url change to ${change.url}');
          },
          onHttpAuthRequest: (HttpAuthRequest request) {},
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.url
              .replaceAll("/view?usp=drivesdk",
                  "/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")
              .replaceAll("/view?usp=drive_link",
                  "/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")
          // "https://drive.google.com/file/d/16arurRggjbrCClwAViQrWjCQNsLoOCw5/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")
          ));
    //   ..loadRequest(Uri.dataFromString('''
    // <iframe src=\"https:\/\/vk.com\/video_ext.php?oid=-221539815&id=456239454&hash=44be08db4de388d7\" width=\"640\" height=\"360\" frameborder=\"0\" allowfullscreen=\"1\" allow=\"autoplay; encrypted-media; fullscreen; picture-in-picture\"><\/iframe>
    // '''));

    // setBackgroundColor is not currently supported on macOS.
    if (kIsWeb || !Platform.isMacOS) {
      controller.setBackgroundColor(const Color(0x80000000));
    }

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  // Inject JavaScript to control video settings
  void _injectVideoSettings() {
    _controller.runJavaScript('''
      var videos = document.querySelectorAll('video');
      videos.forEach(function(video) {
        video.autoplay = true;  // Enable autoplay
        video.muted = true;     // Mute video
        video.play();           // Play video
      });
    ''');
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
          )
        },
        child: Scaffold(
          body: WebViewWidget(controller: _controller),
        ),
      ),
    );
  }
}

//
// class WatchingMovieView extends StatefulWidget {
//   @override
//   _WatchingMovieViewState createState() => _WatchingMovieViewState();
// }
//
// class _WatchingMovieViewState extends State<WatchingMovieView> {
//   VideoPlayerController? _controller;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Create a VideoPlayerController for the video you want to play.
//     _controller = VideoPlayerController.network(
//         'https://media.geeksforgeeks.org/wp-content/uploads/20230924220731/video.mp4');
//
//     // Initialize the VideoPlayerController.
//     _controller!.initialize();
//
//     // Play the video.
//     _controller!.play();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: _controller!.value.aspectRatio,
//       child: VideoPlayer(_controller!),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//
//     // Dispose of the VideoPlayerController.
//     _controller!.dispose();
//   }
// }
