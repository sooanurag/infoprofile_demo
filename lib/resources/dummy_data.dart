import 'package:infoprofile_demo/models/user_model.dart';

class DummyData {
   static String url =
      "https://pixabay.com/vectors/add-plus-link-chain-linking-6945894/";
  static List<UserModel> users = [
    UserModel(
      fullName: "Anurag Gupta",
      profilePicture: url,
    ),
    UserModel(
      fullName: "Ashish Rai",
      profilePicture: url,
    ),
    UserModel(
      fullName: "Mayank Dubey",
      profilePicture: url,
    ),
    UserModel(
      fullName: "Kruger",
      profilePicture: url,
    ),
  ];
}
