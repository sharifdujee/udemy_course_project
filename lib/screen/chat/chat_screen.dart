import 'package:chat_apps/shared/widget/chat_message.dart';
import 'package:chat_apps/shared/widget/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

final _fireBase = FirebaseAuth.instance;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupPushNotification() async {
    final fcm = FirebaseMessaging.instance;
    fcm.subscribeToTopic('chat');
    //await fcm.requestPermission();
    final token = await fcm.getToken();
    print('the token is $token');
  }

  @override
  void initState() {
    // TODO: implement initState
    setupPushNotification();
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('FlutterChat'),
          actions: [
            IconButton(
              onPressed: () {
                _fireBase.signOut();
              },
              icon: const Icon(Icons.exit_to_app),
              color: Theme.of(context).colorScheme.secondary,
            )
          ],
        ),
        body: Column(
          children: const [Expanded(child: ChatMessage()), NewMessages()],
        ));
  }
}
