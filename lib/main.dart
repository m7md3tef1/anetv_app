import 'package:anetv/constants.dart';
import 'package:anetv/core/utils/app_router.dart';
import 'package:anetv/core/utils/service_locator.dart';
import 'package:anetv/featuers/home/data/repo/addCubit.dart';
import 'package:anetv/featuers/home/data/repo/all_movies_home_repo_impl.dart';
import 'package:anetv/featuers/home/data/repo/sql_helper.dart';
import 'package:anetv/featuers/home/presentation/manager/all_movies_cubit/actionHandeler.dart';
import 'package:anetv/featuers/home/presentation/manager/all_movies_cubit/all_movies_cubit.dart';
import 'package:flutter/foundation.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

// import 'package:cloudinary_url_gen/cloudinary.dart';
// import 'package:cloudinary_flutter/image/cld_image.dart';
// import 'package:cloudinary_flutter/cloudinary_context.dart';
// import 'package:media_kit/media_kit.dart';
// var cloudinary=Cloudinary.fromStringUrl('cloudinary://API_KEY:API_SECRET@CLOUD_NAME');
// WebViewEnvironment? webViewEnvironment;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.storage.request().then((value) {
    print("dddddddddddddddddddd");
    print(value);
  },);
  // await DBHelper().dB;
  // await DBHelper().initDB();

  //
  // if (!kIsWeb && defaultTargetPlatform == TargetPlatform.windows) {
  //   final availableVersion = await WebViewEnvironment.getAvailableVersion();
  //   assert(availableVersion != null,
  //   'Failed to find an installed WebView2 Runtime or non-stable Microsoft Edge installation.');
  //
  //   webViewEnvironment = await WebViewEnvironment.create(
  //       settings:
  //       WebViewEnvironmentSettings(userDataFolder: 'YOUR_CUSTOM_PATH'));
  // }
  //
  // if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
  //   await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  // }
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  setup();
  // cloudinary.config.urlConfig.secure = true;
  // MediaKit.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => AllMoviesCubit(getIt.get<AllMoviesHomeRepoImpl>())),
        BlocProvider(create: (_) => FavCubit()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: MaterialApp.router(
                routerConfig: AppRouter.router,
                // localizationsDelegates: context.localizationDelegates,
                // locale: context.locale,
                // supportedLocales: context.supportedLocales,
                theme: ThemeData.dark().copyWith(
                  scaffoldBackgroundColor: kPrimaryColor,
                  textTheme: GoogleFonts.montserratTextTheme(
                      ThemeData.dark().textTheme),
                ),
                debugShowCheckedModeBanner: false,
              ),
            );
          }),
    );
  }
}

// // kids_family
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:async';
//
// import 'package:webview_windows/webview_windows.dart';
// import 'package:window_manager/window_manager.dart';
//
// final navigatorKey = GlobalKey<NavigatorState>();
//
// void main() async {
//   // For full-screen example
//   WidgetsFlutterBinding.ensureInitialized();
//   await windowManager.ensureInitialized();
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(navigatorKey: navigatorKey, home: ExampleBrowser());
//   }
// }
//
// class ExampleBrowser extends StatefulWidget {
//   @override
//   State<ExampleBrowser> createState() => _ExampleBrowser();
// }
//
// class _ExampleBrowser extends State<ExampleBrowser> {
//   final _controller = WebviewController();
//   final _textController = TextEditingController();
//   final List<StreamSubscription> _subscriptions = [];
//   bool _isWebviewSuspended = false;
//
//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }
//
//   Future<void> initPlatformState() async {
//     // Optionally initialize the webview environment using
//     // a custom user data directory
//     // and/or a custom browser executable directory
//     // and/or custom chromium command line flags
//     //await WebviewController.initializeEnvironment(
//     //    additionalArguments: '--show-fps-counter');
//
//     try {
//       await _controller.initialize();
//       _subscriptions.add(_controller.url.listen((url) {
//         _textController.text = url;
//       }));
//
//       _subscriptions
//           .add(_controller.containsFullScreenElementChanged.listen((flag) {
//         debugPrint('Contains fullscreen element: $flag');
//         windowManager.setFullScreen(flag);
//       }));
//
//       await _controller.setBackgroundColor(Colors.transparent);
//       await _controller.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
//       await _controller.loadUrl('https://flutter.dev');
//
//       if (!mounted) return;
//       setState(() {});
//     } on PlatformException catch (e) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         showDialog(
//             context: context,
//             builder: (_) => AlertDialog(
//               title: Text('Error'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Code: ${e.code}'),
//                   Text('Message: ${e.message}'),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   child: Text('Continue'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 )
//               ],
//             ));
//       });
//     }
//   }
//
//   Widget compositeView() {
//     if (!_controller.value.isInitialized) {
//       return const Text(
//         'Not Initialized',
//         style: TextStyle(
//           fontSize: 24.0,
//           fontWeight: FontWeight.w900,
//         ),
//       );
//     } else {
//       return Padding(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Card(
//               elevation: 0,
//               child: Row(children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'URL',
//                       contentPadding: EdgeInsets.all(10.0),
//                     ),
//                     textAlignVertical: TextAlignVertical.center,
//                     controller: _textController,
//                     onSubmitted: (val) {
//                       _controller.loadUrl(val);
//                     },
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.refresh),
//                   splashRadius: 20,
//                   onPressed: () {
//                     _controller.reload();
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.developer_mode),
//                   tooltip: 'Open DevTools',
//                   splashRadius: 20,
//                   onPressed: () {
//                     _controller.openDevTools();
//                   },
//                 )
//               ]),
//             ),
//             Expanded(
//                 child: Card(
//                     color: Colors.transparent,
//                     elevation: 0,
//                     clipBehavior: Clip.antiAliasWithSaveLayer,
//                     child: Stack(
//                       children: [
//                         Webview(
//                           _controller,
//                           permissionRequested: _onPermissionRequested,
//                         ),
//                         StreamBuilder<LoadingState>(
//                             stream: _controller.loadingState,
//                             builder: (context, snapshot) {
//                               if (snapshot.hasData &&
//                                   snapshot.data == LoadingState.loading) {
//                                 return LinearProgressIndicator();
//                               } else {
//                                 return SizedBox();
//                               }
//                             }),
//                       ],
//                     ))),
//           ],
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         tooltip: _isWebviewSuspended ? 'Resume webview' : 'Suspend webview',
//         onPressed: () async {
//           if (_isWebviewSuspended) {
//             await _controller.resume();
//           } else {
//             await _controller.suspend();
//           }
//           setState(() {
//             _isWebviewSuspended = !_isWebviewSuspended;
//           });
//         },
//         child: Icon(_isWebviewSuspended ? Icons.play_arrow : Icons.pause),
//       ),
//       appBar: AppBar(
//           title: StreamBuilder<String>(
//             stream: _controller.title,
//             builder: (context, snapshot) {
//               return Text(
//                   snapshot.hasData ? snapshot.data! : 'WebView (Windows) Example');
//             },
//           )),
//       body: Center(
//         child: compositeView(),
//       ),
//     );
//   }
//
//   Future<WebviewPermissionDecision> _onPermissionRequested(
//       String url, WebviewPermissionKind kind, bool isUserInitiated) async {
//     final decision = await showDialog<WebviewPermissionDecision>(
//       context: navigatorKey.currentContext!,
//       builder: (BuildContext context) => AlertDialog(
//         title: const Text('WebView permission requested'),
//         content: Text('WebView has requested permission \'$kind\''),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () =>
//                 Navigator.pop(context, WebviewPermissionDecision.deny),
//             child: const Text('Deny'),
//           ),
//           TextButton(
//             onPressed: () =>
//                 Navigator.pop(context, WebviewPermissionDecision.allow),
//             child: const Text('Allow'),
//           ),
//         ],
//       ),
//     );
//
//     return decision ?? WebviewPermissionDecision.none;
//   }
//
//   @override
//   void dispose() {
//     _subscriptions.forEach((s) => s.cancel());
//     _controller.dispose();
//     super.dispose();
//   }
// }
