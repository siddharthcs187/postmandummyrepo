class BorrowRequest {
  final String id;
  final String userId;
  final String username;
  final String profilePicUrl;
  final String title;
  final String description;
  final String body;
  final String imageUrl;
  final String saleOrRent;
  bool isSaved;
  BorrowRequest({
    required this.id,
    required this.userId,
    required this.username,
    required this.profilePicUrl,
    required this.title,
    required this.description,
    required this.body,
    required this.imageUrl,
    required this.saleOrRent,
    this.isSaved = false,
  });
}
