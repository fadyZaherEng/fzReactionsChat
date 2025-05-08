library fz_reactions_chat;

import 'package:fz_reactions_chat/widgets/stacked_reactions_widget.dart';
import 'package:flutter/material.dart';
import 'package:fz_reactions_chat/widgets/reactions_dialog_widget.dart';

/// A FzReactionsChat.
class FzReactionsChat {
  /// Displays a custom dialog that allows the user to react to a chat message
  /// with emoji reactions and context actions (e.g. reply, copy, delete).
  ///
  /// This widget uses [ReactionsDialogWidget] and must be provided with:
  /// - the message being interacted with
  /// - context menu and emoji callbacks
  ///
  /// The dialog is modal and will not dismiss on outside tap.
  void showReactionsDialog({
    required BuildContext context,
    // Consider changing `dynamic` to your actual `Message` class type
    required dynamic massage,
    required bool isMe,
    required int currentUserId,
    required void Function(String, dynamic) onContextMenuSelected,
    required void Function(String, dynamic) onEmojiSelected,
    required void Function() setMassageReplyNull,
    required void Function(String) onTapPreviewImage,
    required void Function(dynamic) onReplyScroll,

    /// Translated/localized strings for context menu items.
    required String replayText,
    required String copyText,
    required String deleteText,
    required String closeText,
    required Widget myMassageContent,
    required Widget receiveMassageContent,
  }) {
    showDialog(
      context: context,
      // Prevent dismissing dialog by tapping outside
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ReactionsDialogWidget(
              message: massage,
              isMe: isMe,
              onTapPreviewImage: onTapPreviewImage,
              onContextMenuSelected: onContextMenuSelected,
              onEmojiSelected: onEmojiSelected,
              setMassageReplyNull: setMassageReplyNull,
              currentUserId: currentUserId,
              myMassageContent: myMassageContent,
              receiverMassageContent: receiveMassageContent,
              replayText: replayText,
              copyText: copyText,
              deleteText: deleteText,
              closeText: closeText,
            ),
          ),
        );
      },
    );
  }

  Widget stackReactions({
    /// The message object that contains reaction data.
    /// Must have `messageReactions` and `messageReactionsCount` lists.
    required dynamic massage,

    /// Whether the message was sent by the current user.
    required bool isMe,

    /// Whether this widget is rendered inside a dialog view.
    required bool isDialogReactions,

    /// Font size for the emoji reactions.
    required double size,

    /// Callback when the widget is tapped.
    required VoidCallback onPressed,

    /// Optional custom style for the widget.
    required ReactionStyle? style,
  }) {
    return StackedReactionsWidget(
      massage: massage,
      size: size,
      onPressed: onPressed,
      isMe: isMe,
      isDialogReactions: isDialogReactions,
    );
  }
}
