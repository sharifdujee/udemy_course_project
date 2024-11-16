import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class NewMessages extends StatefulWidget {
  const NewMessages({super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final  _messageController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _messageController.dispose();
    super.dispose();

  }

  void _submitMessage()async{
    final enteredMessage = _messageController.text;
    if(enteredMessage.trim().isEmpty){
      return;
    }
    FocusScope.of(context).unfocus();
    _messageController.clear();

    final user = FirebaseAuth.instance.currentUser!;
  final userData =   await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    /// send firebase
    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId':user.uid,
      'username': userData.data()!['userName'],
      'userImage': userData.data()!['image-url'],


    });






  }
  @override
  Widget build(BuildContext context) {

    return Padding(padding: EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(child: TextField(
            controller: _messageController,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: const InputDecoration(
              labelText: 'Send a message...'
            ),
          )),
          IconButton(
            color: Theme.of(context).colorScheme.primary,
              onPressed: (){
              _submitMessage();
              }, icon: Icon(Icons.send))
        ],
      ),
    );
  }
}
