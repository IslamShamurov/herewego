class PostSend {

  late String userId;
  late String firstName;
  late String lastName;
  late String content;
  late String date;

  PostSend(this.userId,this.firstName, this.lastName, this.content,this.date);

  PostSend.fromJson(Map<dynamic, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    content = json['content']; 
    date = json['date'];
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'firstName': firstName,
    'lastName': lastName,
    'content': content,
    'date': date,
  };
}
