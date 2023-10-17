class LendRequest {
  final String id;
  final String userId;
  final String username;
  final String profilePicUrl;
  final String imageUrl;
  final String title;
  final String body;
  bool isSaved;

  LendRequest({
    required this.imageUrl,
    required this.id,
    required this.userId,
    required this.username,
    required this.profilePicUrl,
    required this.title,
    required this.body,
    this.isSaved = false,
  });
}