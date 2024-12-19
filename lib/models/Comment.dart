class Comment {
  final String id;
  final String postId;
  final String author;
  final String content;
  final DateTime createdAt;
  final DateTime postDate;

  Comment({
    required this.id,
    required this.postId,
    required this.author,
    required this.content,
    required this.createdAt,
    required this.postDate,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'],
      postId: json['postId'],
      author: json['author'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      postDate: DateTime.parse(json['postDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'author': author,
      'content': content,
      'postDate': postDate.toIso8601String(),
    };
  }
}
