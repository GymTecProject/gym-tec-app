class Exercise {
  String name;
  String url;
  String category;

  Exercise({required this.name, required this.url, required this.category});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      url: json['url'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() => {
      'name': name,
      'url': url,
      'category': category,
    };
}
