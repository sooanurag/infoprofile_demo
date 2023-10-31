import 'dart:convert';

UserPostsModel userPostsModelFromJson(dynamic value) => UserPostsModel.fromJson(value);

String userPostsModelToJson(UserPostsModel data) => json.encode(data.toJson());

class UserPostsModel {
    int statusCode;
    String type;
    Data data;

    UserPostsModel({
        required this.statusCode,
        required this.type,
        required this.data,
    });

    factory UserPostsModel.fromJson(Map<String, dynamic> json) => UserPostsModel(
        statusCode: json["statusCode"],
        type: json["type"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "type": type,
        "data": data.toJson(),
    };
}

class Data {
    List<Post> posts;

    Data({
        required this.posts,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        posts: List<Post>.from(json["Posts"].map((x) => Post.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Posts": List<dynamic>.from(posts.map((x) => x.toJson())),
    };
}

class Post {
    String id;
    String userId;
    String url;
    String caption;
    int likeCount;
    int commentCount;
    bool postStatus;
    DateTime createdAt;

    Post({
        required this.id,
        required this.userId,
        required this.url,
        required this.caption,
        required this.likeCount,
        required this.commentCount,
        required this.postStatus,
        required this.createdAt,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"],
        userId: json["userId"],
        url: json["url"],
        caption: json["caption"],
        likeCount: json["likeCount"],
        commentCount: json["commentCount"],
        postStatus: json["postStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "url": url,
        "caption": caption,
        "likeCount": likeCount,
        "commentCount": commentCount,
        "postStatus": postStatus,
        "createdAt": createdAt.toIso8601String(),
    };
}
