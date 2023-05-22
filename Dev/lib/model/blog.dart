class Blog {
  final String blogid; //pet show id
  final String title;
  final String description;
  final String imageUrl;
  final DateTime datePublished;

  Blog(
      {required this.blogid,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.datePublished});

  Map<String, dynamic> getJson() {
    return {
      "title": title,
      "description": description,
      "blogid": blogid,
      "datePublished": datePublished,
      'imageUrl': imageUrl,
    };
  }

  factory Blog.getModelFromJson({required Map<String, dynamic> json}) {
    return Blog(
      title: json["title"],
      description: json["description"],
      blogid: json["blogid"],
      datePublished: json["datePublished"],
      imageUrl: json['imageUrl'],
    );
  }
}
