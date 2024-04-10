class ListItem {
  final String id;
  final String title;

  ListItem({
    required this.id,
    required this.title,
  });

  ListItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
  };
}
