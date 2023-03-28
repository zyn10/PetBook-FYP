import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    userProvider.getUser.uid;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('uid', isNotEqualTo: userProvider.getUser.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.size,
            itemBuilder: (BuildContext context, int index) {
              final user = snapshot.data!.docs[index];
              final fullname = user['fullname'];
              final photoUrl = user['photoUrl'];
              final uid = user['uid'];

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(photoUrl),
                ),
                title: Text(fullname),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        recipientName: fullname,
                        recipientUid: uid,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String recipientName;
  final String recipientUid;

  const ChatScreen({
    super.key,
    required this.recipientName,
    required this.recipientUid,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipientName),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _db
                  .collection('chats')
                  .doc(_getChatId())
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(8.0),
                  itemCount: snapshot.data!.size,
                  itemBuilder: (BuildContext context, int index) {
                    final message = snapshot.data!.docs[index];
                    final isSender =
                        message['senderUid'] == _auth.currentUser!.uid;
                    final backgroundColor =
                        isSender ? Colors.blue : Colors.grey[300];
                    final textColor = isSender ? Colors.white : Colors.black;

                    return Container(
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: isSender
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            message['text'],
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            DateTime.fromMillisecondsSinceEpoch(
                              message['timestamp'].millisecondsSinceEpoch,
                            ).toString(),
                            style: TextStyle(
                              color: textColor.withOpacity(0.7),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(bottom: 50, left: 30, right: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: "Type your message here...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ... rest of the code ...

  void _sendMessage() async {
    final currentUser = _auth.currentUser;

    if (_messageController.text.isNotEmpty) {
      await _db
          .collection('chats')
          .doc(_getChatId())
          .collection('messages')
          .add({
        'text': _messageController.text,
        'senderUid': currentUser!.uid,
        'recipientUid': widget.recipientUid,
        'timestamp': Timestamp.now(),
      });

      _messageController.clear();
    }
  }

  String _getChatId() {
    final currentUser = _auth.currentUser;
    if (currentUser!.uid.hashCode <= widget.recipientUid.hashCode) {
      return '${currentUser.uid}-${widget.recipientUid}';
    } else {
      return '${widget.recipientUid}-${currentUser.uid}';
    }
  }
}
