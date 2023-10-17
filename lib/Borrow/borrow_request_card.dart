import 'package:flutter/material.dart';
class BorrowRequestCard extends StatefulWidget {
  final String imageUrl;
  final String username;
  final String title;
  final String body;
  final String profilePicUrl;
  final String userId;

  BorrowRequestCard({
    Key? key,
    required this.imageUrl,
    required this.username,
    required this.title,
    required this.body,
    required this.profilePicUrl,
    required this.userId,
  }) : super(key: key);

  @override
  _BorrowRequestCardState createState() => _BorrowRequestCardState();
}

class _BorrowRequestCardState extends State<BorrowRequestCard> {
  bool isSaved = false;
  bool showFullText = false;
  final user = FirebaseAuth.instance.currentUser!;

  void _handleSendButtonPress() async {
    String currentUserId = user.uid;
    String receiverUserId = widget.userId;

    bool roomExists = await checkIfRoomExists(currentUserId, receiverUserId);

    if (!roomExists && (currentUserId != receiverUserId)) {
      await createRoom(currentUserId, receiverUserId);
    }

    if (currentUserId != receiverUserId) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            senderUserId: currentUserId,
            receiverUserId: receiverUserId,
          ),
        ),
      );
    }
  }

  Future<bool> checkIfRoomExists(String userId1, String userId2) async {
    CollectionReference rooms = FirebaseFirestore.instance.collection('Rooms');

    QuerySnapshot<Map<String, dynamic>> querySnapshot1 = await rooms
        .where('user1', isEqualTo: userId1)
        .where('user2', isEqualTo: userId2)
        .get() as QuerySnapshot<Map<String, dynamic>>;

    QuerySnapshot<Map<String, dynamic>> querySnapshot2 = await rooms
        .where('user1', isEqualTo: userId2)
        .where('user2', isEqualTo: userId1)
        .get() as QuerySnapshot<Map<String, dynamic>>;

    return querySnapshot1.docs.isNotEmpty || querySnapshot2.docs.isNotEmpty;
  }

  Future<void> createRoom(String currentUserId, String receiverUserId) async {
    try {
      CollectionReference rooms =
      FirebaseFirestore.instance.collection('Rooms');

      await rooms.add({
        'user1': currentUserId,
        'user2': receiverUserId,
      });

      print('Room created for $currentUserId and $receiverUserId');
    } catch (error) {
      print('Error creating room: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xFF144272),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(widget.profilePicUrl),
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                widget.username,
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ],
          ),
          Stack(
            children: [
              Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                height: 150,
                width: double.infinity,
              ),
              Positioned(
                top: 16.0,
                left: 16.0,
                right: 16.0,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.title,
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text('<Required',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF5AF5FF),
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        widget.body,
                        maxLines: showFullText ? null : 2,
                        overflow: showFullText ? null : TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            showFullText = !showFullText;
                          });
                        },
                        child: Text(showFullText ? 'Read Less' : 'Read More',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isSaved = !isSaved;
                  });
                },
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                onPressed: () {
                  _handleSendButtonPress();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
