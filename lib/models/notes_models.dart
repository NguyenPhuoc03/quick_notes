class Note {
  String? id;
  String title;
  String content;
  int color;
  String createAt;
  //String updateAt;


  Note({
    this.id,
    required this.title,
    required this.content,
    required this.color,
    required this.createAt,
    //required this.updateAt
  });
  factory Note.fromJson(String id, Map<String, dynamic> json) {
    return Note(
      id: id,
      title: json['title'] ?? "Error",
      content: json['content'] ?? "Error",
      color: json['color_id'] ?? 0,
      createAt: json['createAt'] ?? "Error",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'color_id': color,
      'createAt': createAt,
    };
  }
}
