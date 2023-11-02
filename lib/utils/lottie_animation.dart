import 'package:infoprofile_demo/resources/paths.dart';
import 'package:lottie/lottie.dart';

class LottieAnimations {
  static LottieBuilder logo = Lottie.asset(AppPaths.logoAnimation);
  static LottieBuilder logoDelayed =
      Lottie.asset(AppPaths.logoAnimationDelayed, height: 200, repeat: false);
  static LottieBuilder onBoardingOne =
      Lottie.asset(AppPaths.onBoardingOne, reverse: true);
  static LottieBuilder followBlack =
      Lottie.asset(AppPaths.followBlack, reverse: true);
  static LottieBuilder followWhite =
      Lottie.asset(AppPaths.followWhite, reverse: true);
  static LottieBuilder onBoardingTwo =
      Lottie.asset(AppPaths.onBoardingtwo, repeat: true);
  static LottieBuilder onBoardingThree =
      Lottie.asset(AppPaths.onBoardingthree, reverse: true);
  static LottieBuilder globe = Lottie.asset(AppPaths.globe, repeat: true);
  static LottieBuilder boxes =
      Lottie.asset(AppPaths.boxes, repeat: true, height: 200);
  static LottieBuilder email =
      Lottie.asset(AppPaths.email, repeat: true, height: 20);
  static LottieBuilder lock =
      Lottie.asset(AppPaths.lock, repeat: true, height: 20);
  static LottieBuilder facebook =
      Lottie.asset(AppPaths.facebook, repeat: true, height: 30);
  static LottieBuilder linkdin =
      Lottie.asset(AppPaths.linkdin, repeat: true, height: 30);
  static LottieBuilder twitter =
      Lottie.asset(AppPaths.twitter, repeat: true, height: 30);
  static LottieBuilder person =
      Lottie.asset(AppPaths.person, repeat: true, height: 20);
}
