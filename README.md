🎬 fz_reactions_chat

A Flutter package for show Reaction Dialog Chat And Stack Widget.

## 📖 Table of Contents
- [Screenshots](#Screenshots)
- [Features](#Features)
- [Getting Started](#getting-started)
- [Usage](#usage)
    - [fzReactionsChat](#fz_reactions_chat)
- [Example](#example)
- [Dependencies Used](#dependencies-used)
- [About the Developer](#about-the-developer)
- [License](#license)

## 🎥 Check out the video trimming in action!
## Screens
| ![Screen 1](https://raw.githubusercontent.com/fadyZaherEng/flutterVideoTrimmerTest/master/assets/1.jpg) | ![Screen 2](https://raw.githubusercontent.com/fadyZaherEng/flutterVideoTrimmerTest/master/assets/2.jpg) |  
|:-----------------------------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------------:| 

## GIF DEMO
 ![GIF DEMO](https://raw.githubusercontent.com/fadyZaherEng/flutterVideoTrimmerTest/master/assets/demo.gif) | 
 |:---------------------------------------------------------------------------------------------------------------:| 

--- 
## Features

- 🚀 A Flutter package for show Reaction Dialog Chat And Stack Widget. 

---
## Getting Started

1. **Add dependency:**
   In your `pubspec.yaml`:
```yaml
dependencies:
  fz_reactions_chat: ^0.0.1
```

2. `Install Package` In your project:
```
flutter pub get
```

3. `Android Configuration:` In your AndroidManifest.xml no Configuration Required:
```xml 
```

in /android/app/build.gradle
```
minSdk = 24
// Prefered 
compileSdk = 34
```

4. `iOS Configuration:` In your iOS Info.plist, no Configuration Required:
``` 
``` 
##  Usage

Here’s a complete example showing how to build a custom Reaction Dialog Chat   using
the `fz_reactions_chat` package.

## usage fzReactionsChat  Reaction Dialog
```dart
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
```
## fzReactionsChat  Stack Reaction
```dart
  fzReactionsChat.stackReactions(
isMe: true,
isDialogReactions: true,
size: 20,
onPressed: () {},
allMessageReactions: {"❤️": 5},
messageReactionsByCountForEachReaction: {"❤️": 1},
),
```
## Example

```dart 
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
            const SizedBox(height: 50),
            fzReactionsChat.stackReactions(
              isMe: true,
              isDialogReactions: true,
              size: 20,
              onPressed: () {},
              allMessageReactions: {"❤️": 5},
              messageReactionsByCountForEachReaction: {"❤️": 1},
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

```
## Example_Full_Code
[You Can Find The Full Code Here](https://github.com/fadyZaherEng/fzReactionsChat)
## Dependencies Used
## This package uses (You do not have to import them):
    animate_do:  

```
Before using this example directly in a Flutter app, don't forget to add the fz_reactions_chat packages to your pubspec.yaml file.
You can try out this example by replacing the entire content of main.dart file of a newly created
Flutter project.
```

## About the Developer
Hello! 👋 I'm Fady Zaher, a Mid Level Flutter Developer with extensive experience in building high-quality mobile applications.
- 📧 Email: fedo.zaher@gmail.com
---
If you like this package, feel free to ⭐️ the repo and share it!

📝 License
MIT License

Copyright (c) 2025 [Fady Zaher]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

