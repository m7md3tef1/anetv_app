import 'package:anetv/core/utils/app_router.dart';
import 'package:anetv/core/utils/assets.dart';
import 'package:anetv/featuers/splash/presentation/views/widgets/sliding_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../home/data/local/cacheHelper.dart';
import '../../login.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    // initSlidingAnimation();
    getUsers().then(
      (value) {
        navigateToHome();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: SizedBox(height: height * .5, child: Image.asset(AssetsData.logo)),
    );
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 3), () {
      bool find = false;
      // print("Email");
      // print(Email);
      // print(users!.length);
      for (int i = 0; i < users!.length; i++) {
        if (email.toString() == users![i].email.toString()) {
          find = true;
        }
      }
      // print("find");
      // print(find);
      if (find == true) {
        GoRouter.of(context)
            .push(isLogin == true ? AppRouter.kHomeView : AppRouter.kLoginView);
      } else {
        GoRouter.of(context).push(AppRouter.kLoginView);
      }
      // Get.to(()=>const HomeView(),transition:Transition.fade,duration: kTranstionDuration);
    });
  }

  // void initSlidingAnimation() {
  //   animationController =
  //       AnimationController(vsync: this, duration: const Duration(seconds: 2));
  //   slidingAnimation =
  //       Tween<Offset>(begin: const Offset(0, 10), end: Offset.zero)
  //           .animate(animationController);
  //   // slidingAnimation.addListener(() {
  //   //   setState(() {});
  //   // });
  //   animationController.forward();
  // }
}
