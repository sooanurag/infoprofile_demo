import 'package:infoprofile_demo/resources/paths.dart';
import 'package:lottie/lottie.dart';

class LottieAnimations{
  static LottieBuilder logo = Lottie.asset(AppPaths.logoAnimation);
  static LottieBuilder logoDelayed = Lottie.asset(AppPaths.logoAnimationDelayed,height: 200,repeat: false);
  static LottieBuilder onBoardingOne = Lottie.asset(AppPaths.onBoardingOne,reverse: true);
  static LottieBuilder onBoardingTwo = Lottie.asset(AppPaths.onBoardingtwo,repeat: true);
  static LottieBuilder onBoardingThree = Lottie.asset(AppPaths.onBoardingthree,reverse: true);

}