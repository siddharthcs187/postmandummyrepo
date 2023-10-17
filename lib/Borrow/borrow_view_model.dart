Future<void> postBorrowRequest(
    {required String title,
      required String body,
      required String imageUrl,
      required String username,
      required String profilePicUrl,
      required String userId}) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    try {
      final borrowRequestData = {
        'title': title,
        'body': body,
        'imageUrl': imageUrl,
        'username': username,
        'profilePicUrl': profilePicUrl,
        'userId': userId,
      };

      await FirebaseFirestore.instance
          .collection('Borrow_Requests')
          .add(borrowRequestData);
      print('borrow request successful');
    } catch (e) {
      print('Error posting borrow request: $e');
    }
  }
}
Future<int> getLendRequestCount() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    // User not authenticated
    return 0;
  }

  try {
    QuerySnapshot lendRequests = await FirebaseFirestore.instance
        .collection('Lend_Requests')
        .where('userId', isEqualTo: user.uid)
        .get();

    return lendRequests.size;
  } catch (e) {
    print('Error getting lend requests: $e');
    return 0;
  }
}