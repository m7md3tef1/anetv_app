import 'package:anetv/constants.dart';
import 'package:anetv/core/utils/app_router.dart';
import 'package:anetv/core/utils/service_locator.dart';
import 'package:anetv/featuers/home/data/repo/all_movies_home_repo_impl.dart';
import 'package:anetv/featuers/home/presentation/manager/all_movies_cubit/actionHandeler.dart';
import 'package:anetv/featuers/home/presentation/manager/all_movies_cubit/all_movies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllMoviesCubit(getIt.get<AllMoviesHomeRepoImpl>()),
      child: ActionHandler().handleArrowAndEnterAction(
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: kPrimaryColor,
            textTheme:
                GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
          ),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

// kids_family
