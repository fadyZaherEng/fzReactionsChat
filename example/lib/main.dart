import 'package:flutter/material.dart';
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
      home: const MyHomePage(title: 'Flutter Chat Reactions'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            TextButton(
              onPressed: () {
                fzReactionsChat.showReactionsDialog(
                  context: context,
                  massage: massage,
                  isMe: isMe,
                  currentUserId: currentUserId,
                  onContextMenuSelected: onContextMenuSelected,
                  onEmojiSelected: onEmojiSelected,
                  setMassageReplyNull: setMassageReplyNull,
                  onTapPreviewImage: onTapPreviewImage,
                  onReplyScroll: onReplyScroll,
                  replayText: replayText,
                  copyText: copyText,
                  deleteText: deleteText,
                  closeText: closeText,
                  myMassageContent: myMassageContent,
                  receiveMassageContent: receiveMassageContent,
                );
              },
              child: const Text("Show Reaction Chat"),
            ),
            fzReactionsChat.stackReactions(
              massage: massage,
              isMe: isMe,
              isDialogReactions: isDialogReactions,
              size: size,
              onPressed: onPressed,
              style: style,
            ),
          ],
        ),
      ),
    );
  }
}
