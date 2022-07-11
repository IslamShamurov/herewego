class Post {
  late String userId;
  late String title;
  late String content;

  Post(this.userId, this.title, this.content);

  Post.fromJson(Map<dynamic, dynamic> json) {
    title = json['title'];
    userId = json['userId'];

    content = json['content'];
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'title': title,
    'content': content,
  };
}
