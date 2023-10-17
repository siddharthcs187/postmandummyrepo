Future<int> getBorrowRequestCount() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    // User not authenticated
    return 0;
  }

  try {
    QuerySnapshot borrowRequests = await FirebaseFirestore.instance
        .collection('Borrow_Requests')
        .where('userId', isEqualTo: user.uid)
        .get();

    return borrowRequests.size;
  } catch (e) {
    print('Error getting borrow requests: $e');
    return 0;
  }
}