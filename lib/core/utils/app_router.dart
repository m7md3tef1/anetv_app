import 'package:anetv/featuers/home/data/models/movie_model.dart';
import 'package:anetv/featuers/home/presentation/views/home_view.dart';
import 'package:anetv/featuers/search/presentation/view/search_view.dart';
import 'package:anetv/featuers/search/presentation/view/widget/search.dart';
import 'package:anetv/featuers/splash/presentation/views/splash_view.dart';
import 'package:go_router/go_router.dart';

import '../../featuers/home/data/models/catogry_itme_model.dart';
import '../../featuers/search/presentation/view/watching_movie_view.dart';

abstract class AppRouter {
  static const kHomeView = '/homeView';
  static const kBookDetailsView = '/bookDetailsView';
  static const kSearchView = '/searchView';
  static const kSearch = '/search';
  static const kWatchingMovieView = '/WatchingMovieView';

  static final router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: kSearchView,
      builder: (context, state) => SearchView(
        catogry: state.extra as CatogryItmeModel,
      ),
    ),
    GoRoute(
      path: kWatchingMovieView,
      builder: (context, state) => WatchingMovieView(
        url: state.extra as String,
      ),
    ),

    GoRoute(
      path: kSearch,
      builder: (context, state) => Search(),
    ),
    GoRoute(
      path: kHomeView,
      builder: (context, state) => const HomeView(),
    ),
    // GoRoute(
    //   path: kBookDetailsView,
    //   builder: (context, state) => const BookDetailsView(),
    // )
  ]);
}
