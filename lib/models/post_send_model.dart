class PostSend {

  late String userId;
  late String firstName;
  late String lastName;
  late String content;
  late String date;
   String? imgUrl;

  PostSend(this.userId,this.firstName, this.lastName, this.content,this.date,this.imgUrl);

  PostSend.fromJson(Map<dynamic, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    content = json['content']; 
    date = json['date'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'firstName': firstName,
    'lastName': lastName,
    'content': content,
    'date': date,
    'imgUrl': imgUrl,
  };
}
