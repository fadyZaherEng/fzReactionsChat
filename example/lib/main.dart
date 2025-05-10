import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fz_reactions_chat/fz_reactions_chat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat Reactions',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ChatReactions(title: 'Flutter Chat Reactions'),
    );
  }
}

class ChatReactions extends StatefulWidget {
  const ChatReactions({super.key, required this.title});

  final String title;

  @override
  State<ChatReactions> createState() => _ChatReactionsState();
}

class _ChatReactionsState extends State<ChatReactions> {
  FzReactionsChat fzReactionsChat = FzReactionsChat();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            TextButton(
              onPressed: () {
                fzReactionsChat.showReactionsDialog(
                  context: context,
                  isMe: true,
                  onContextMenuSelected: (context, massageId) {},
                  onEmojiSelected: (reaction, massageId) {},
                  setMassageReplyNull: () {},
                  onTapPreviewImage: (image) {},
                  onReplyScroll: (_) {},
                  replayText: "Replay",
                  copyText: "Copy",
                  deleteText: "Delete",
                  closeText: "Close",
                  myMassageContent: const Text("My Massage"),
                  receiveMassageContent: const Text("receive Massage"),
                  messageId: "5",
                  reactionSelectedByMy: "❤️",
                );
              },
              child: const Text("Show Reaction Dialog Chat"),
            ),
            const SizedBox(height: 200),
            SizedBox(
              width: 50,
              height: 50,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: 50,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                       color: Colors.purple,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 5,
                    right: 0,
                    child: fzReactionsChat.stackReactions(
                      isMe: true,
                      isDialogReactions: true,
                      size: 20,
                      width: 50,
                      onPressed: () {},
                      allMessageReactions: {"❤️": 5},
                      messageReactionsByCountForEachReaction: {"❤️": 1},
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
