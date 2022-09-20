import 'package:chatroom/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chatroom/constants.dart';
late User logedInUser;
final firestore = FirebaseFirestore.instance;
class ChatScreen extends StatefulWidget {
  static String id = 'chatscreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  final messageTxtController = TextEditingController();
  final auth = FirebaseAuth.instance;
  late String messageText;
  Future<void> getCurrentUser() async {
    try {
      final user = await auth.currentUser;
      if (user != null) {
        logedInUser = user;
        print(logedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

//   void getMessages() async {
//     //for simple geting messages
//     // var messages= await firestore.collection('messages').get();
//     // for(var message in messages.docs){
//     //    print(message.data());
//     // }
// //for automatically update message in firebase used
//     await for (var snapshots in firestore.collection('messages').snapshots()) {
//       for (var message in snapshots.docs) {
//         print(message.data());
//       }
//     }
//   }

  // stream or message may fark ya ha kay stream may do chzay hoti han
  // 1. auto update (mean koi b user send karay to dosray kay pas kud ba kud upadate hota ha )
  // 2. ye b message  ki tarah hi work karta ha but ye automatically hota ha
  // message just fetch karnay kay liya istamal hota ha
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                try {
                  auth.signOut();
                  Navigator.pop(context);
                } catch (e, s) {
                  print(s);
                }
              }),
        ],
        title: Hero(tag: 'logo', child: Text('⚡️Chat')),
        backgroundColor: Colors.red.shade500,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          MessageStream(),
          Container(
            decoration: kMessageContainerDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: messageTxtController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    messageTxtController.clear();
                    firestore.collection('messages').add({
                      'sender': logedInUser.email,
                      'text': messageText,
                      'Timestamp': FieldValue.serverTimestamp(),
                    });
                    // getMessages();
                  },
                  child: Text(
                    'Send',
                    style: kSendButtonTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageStream extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('messages').orderBy('Timestamp').snapshots(),
        builder: (context, snapshot) {
          List<MessageBubble> messageWidgets = [];
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red.shade500,
              ),
            );
          } else {
            try {
              final messages = snapshot.data!.docs.reversed;
              for (var message in messages) {
                final messageSender = message.get('sender');
                final currentUser= logedInUser.email;
                final messageText = message.get('text');
                final messageWidget = MessageBubble(
                    sender: messageSender, text: messageText,isMe: currentUser==messageSender,);
                messageWidgets.add(messageWidget);
                print(messageText);
              }
            } catch (e, s) {
              print("Error finding in message fetch from firebase");
            }
          }
          return Expanded(
            child: ListView(
              reverse: true,
              children: messageWidgets,
            ),
          );
        });
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.sender, required this.text,required this.isMe});
  final String sender;
  final String text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(

        crossAxisAlignment: isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(
            "$sender",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
          Material(
            borderRadius: isMe ? BorderRadius.only(topLeft: Radius.circular(30.0),bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0)): BorderRadius.only(topRight: Radius.circular(30.0),bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0)),
            elevation: 5.0,
            color: isMe ? Colors.red.shade500 : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                "$text ",
                style: TextStyle(
                  color: isMe ? Colors.white:  Colors.grey.shade700,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
