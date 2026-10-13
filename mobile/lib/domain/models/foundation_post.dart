enum PostCategory {
  noticia,
  hito,
  logisticaEntrega,
  agradecimiento,
}

class FoundationPost {
  final String id;
  final String title;
  final String content;
  final String authorName;
  final DateTime date;
  final PostCategory category;
  final int likesCount;
  final String? badgeText;
  final String iconName;

  const FoundationPost({
    required this.id,
    required this.title,
    required this.content,
    required this.authorName,
    required this.date,
    required this.category,
    this.likesCount = 0,
    this.badgeText,
    this.iconName = 'campaign',
  });

  String get categoryLabel {
    switch (category) {
      case PostCategory.noticia:
        return 'Noticia Oficial';
      case PostCategory.hito:
        return 'Meta Alcanzada';
      case PostCategory.logisticaEntrega:
        return 'Puntos & Logística';
      case PostCategory.agradecimiento:
        return 'Agradecimiento';
    }
  }

  FoundationPost copyWith({
    int? likesCount,
  }) {
    return FoundationPost(
      id: id,
      title: title,
      content: content,
      authorName: authorName,
      date: date,
      category: category,
      likesCount: likesCount ?? this.likesCount,
      badgeText: badgeText,
      iconName: iconName,
    );
  }
}
