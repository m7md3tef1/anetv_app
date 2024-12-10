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

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..getUserAgent()..enableZoom(true)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            // debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            // debugPrint('Page finished loading: $url');
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
      ..loadRequest(Uri.parse(widget.url.replaceAll("/view?usp=drivesdk",
              "/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")
          // "https://drive.google.com/file/d/16arurRggjbrCClwAViQrWjCQNsLoOCw5/preview?autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w")
          ));
    print("object");
    print(widget.url.replaceAll("/view?usp=drivesdk",
        "/preview?width=10&height=10&autoplay=1&resourcekey=1-wNT6W0_vHfh3wAeS8rrJ6w"));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Watch Movie - ${widget.url}'), toolbarHeight: 0),
      body: Column(
        children: [
          Expanded(child: WebViewWidget(controller: _controller)),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              if (await _controller.canGoForward()) {
                await _controller.goForward();
              } else {
                messenger.showSnackBar(
                  const SnackBar(content: Text('No forward history item')),
                );
                return;
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.replay),
            onPressed: () {
              _controller.reload();
            },
          ),
        ],
      ),
    );
  }
}
