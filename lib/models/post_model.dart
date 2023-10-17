
class PostModel {
  String? id;
  DateTime? createdOn;
  String? postUrl;
  String? caption;
  String? likesId;
  String? commentsId;

  PostModel({
    this.id,
    this.createdOn,
    this.postUrl,
    this.caption,
    this.likesId,
    this.commentsId,
  });

  PostModel.fromMap({required Map<String, dynamic> map}) {
    id = map["_id"];
    createdOn = map["createdOn"]?.toDate();
    postUrl = map["postUrl"];
    caption = map["caption"];
    likesId = map["likesId"];
    commentsId = map["commentsId"];
  }
}
