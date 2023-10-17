Future<void> postLendRequest(
    {required String title,
      required String body,
      required String imageUrl,
      required String rentOrSell,
      required String username,
      required String profilePicUrl,
      required String userId}) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    try {
      print('making lend: ' + rentOrSell);
      final lendRequestData = {
        'title': title,
        'body': body,
        'imageUrl': imageUrl,
        'rentOrSell': rentOrSell,
        'username': username,
        'profilePicUrl': profilePicUrl,
        'userId': userId,
      };

      await FirebaseFirestore.instance
          .collection('Lend_Requests')
          .add(lendRequestData);
      print('lend request successful');
    } catch (e) {
      print('Error posting lend request: $e');
    }
  }
}

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