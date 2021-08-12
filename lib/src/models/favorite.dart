class FavoriteModel {
  final int? id;
  final String title;
  final String content;
  final String lang;

  FavoriteModel(
      {required this.id,
      required this.title,
      required this.content,
      required this.lang});

  FavoriteModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        content = res['content'],
        lang = res['lang'];

  Map<String, Object?> toMap() {
    return {'id': id, 'title': title, 'content': content, 'lang': lang};
  }
}
