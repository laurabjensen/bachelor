class Comment {
  final String userId;
  final String comment;
  final DateTime postedAt;

  Comment({required this.userId, required this.comment, required this.postedAt});

  Comment copyWith({
    String? userId,
    String? comment,
    DateTime? postedAt,
  }) {
    return Comment(
      userId: userId ?? this.userId,
      comment: comment ?? this.comment,
      postedAt: postedAt ?? this.postedAt,
    );
  }
}
