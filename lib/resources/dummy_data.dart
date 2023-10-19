import 'package:infoprofile_demo/models/user_model.dart';

class DummyData {
  static String url =
      "https://pixabay.com/vectors/add-plus-link-chain-linking-6945894/";
  static List<UserModel> users = [
    UserModel(
      fullName: "Anurag Gupta",
      username: "sooanurag",
      profilePicture: "https://picsum.photos/1000/600",
    ),
    UserModel(
      fullName: "Ashish Rai",
      username: "ashishrai123",
      profilePicture: "https://picsum.photos/1000/900",
    ),
    UserModel(
      fullName: "Mayank Dubey",
      username: "golden",
      profilePicture: "https://picsum.photos/600/600",
    ),
    UserModel(
      fullName: "Kruger",
      username: "garuna",
      profilePicture: "https://picsum.photos/1000/400",
    ),
  ];
}
