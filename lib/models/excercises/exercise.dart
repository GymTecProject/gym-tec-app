class Exercise {
  String? id;
  String name;
  String url;
  String category;

  Exercise({required this.name, required this.url, required this.category, this.id});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id']??'',
      name: json['name'],
      url: json['url'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'url': url,
        'category': category,
      };
}
