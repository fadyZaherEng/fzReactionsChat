import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fz_reactions_chat/config/theme/color_schemes.dart';
import 'package:fz_reactions_chat/utils/constants.dart';

/// A dialog widget that allows users to react to a message and perform context-based actions.
///
/// Supports emoji reactions and actions like reply, copy, delete, and close.
/// Also distinguishes between messages sent by the user and others.
class ReactionsDialogWidget extends StatefulWidget {
  final bool isMe;

  /// Callback when an emoji is selected.
  final void Function(String emoji, String messageId) onEmojiSelected;

  /// Callback when a context menu option is selected.
  final void Function(String action, String messageId) onContextMenuSelected;

  /// Callback to clear the reply state externally.
  final void Function() setMassageReplyNull;

  /// ID of the current user.
  final int currentUserId;

  /// Callback for tapping on an image preview.
  final void Function(String imageUrl) onTapPreviewImage;

  /// Widget displaying the current user's message.
  final Widget myMassageContent;

  /// Widget displaying another user's message.
  final Widget receiverMassageContent;

  /// Translated/localized strings for context menu items.
  final String replayText;
  final String copyText;
  final String deleteText;
  final String closeText;

  /// The message object (expected to have `messageReactions` and `messageReactionsCount`).
  final dynamic message;

  const ReactionsDialogWidget({
    super.key,
    required this.isMe,
    required this.onEmojiSelected,
    required this.onContextMenuSelected,
    required this.setMassageReplyNull,
    required this.currentUserId,
    required this.onTapPreviewImage,
    required this.myMassageContent,
    required this.receiverMassageContent,
    required this.closeText,
    required this.copyText,
    required this.deleteText,
    required this.replayText,
    required this.message,
  });

  @override
  State<ReactionsDialogWidget> createState() => _ReactionsDialogWidgetState();
}

class _ReactionsDialogWidgetState extends State<ReactionsDialogWidget> {
  final List<String> _reactions = ["👍", "❤️", "😂", "😮", "😢", "😡", "➕"];
  final List<String> _contextMenu = [
    Constants.reply,
    Constants.copy,
    Constants.delete,
    Constants.close,
  ];

  bool reactionClicked = false;
  int clickedReactionIndex = -1;
  bool contextMenuClicked = false;
  int clickedContextMenuIndex = -1;
  List<String> selectedReactions = [];

  @override
  void initState() {
    super.initState();
    selectedReactions =
        widget.message.messageReactionsCount.map((e) => e.reaction).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 0.8, sigmaY: 0.8),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildReactionsWidget(),
                const SizedBox(height: 5),
                _buildMessageWidget(),
                _buildContextMenuWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Maps the internal constant to localized text from widget.
  String _getText(String contextMenu) {
    switch (contextMenu) {
      case Constants.reply:
        return widget.replayText;
      case Constants.copy:
        return widget.copyText;
      case Constants.delete:
        return widget.deleteText;
      default:
        return widget.closeText;
    }
  }

  /// Builds the emoji reactions bar.
  Widget _buildReactionsWidget() {
    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (widget.isMe
                ? ColorSchemes.greyDivider
                : const Color(0xFFF4EBFE))
                .withOpacity(0.9),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: _reactions.map((reaction) {
              final int index = _reactions.indexOf(reaction);
              final bool isAddButton = reaction == "➕";
              final bool isSelected = _isReactionSelectedByMe(reaction);
              final bool shouldAnimate =
                  reactionClicked && clickedReactionIndex == index;

              return FadeInRight(
                duration: const Duration(milliseconds: 500),
                from: (index * 20).toDouble(),
                child: InkWell(
                  onTap: () {
                    widget.onEmojiSelected(reaction, widget.message.id);
                    setState(() {
                      reactionClicked = true;
                      clickedReactionIndex = index;
                    });
                    Future.delayed(const Duration(milliseconds: 500), () {
                      if (mounted) {
                        setState(() {
                          reactionClicked = false;
                        });
                      }
                    });
                  },
                  child: Pulse(
                    duration: const Duration(milliseconds: 500),
                    animate: shouldAnimate,
                    child: Container(
                      padding: isAddButton
                          ? const EdgeInsets.all(4)
                          : isSelected
                          ? const EdgeInsets.all(2)
                          : const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 8,
                      ),
                      margin: isAddButton
                          ? const EdgeInsets.symmetric(horizontal: 6)
                          : EdgeInsets.zero,
                      decoration: BoxDecoration(
                        shape: isAddButton
                            ? BoxShape.circle
                            : BoxShape.rectangle,
                        borderRadius: isAddButton
                            ? null
                            : isSelected
                            ? BorderRadius.circular(6)
                            : BorderRadius.zero,
                        color: isAddButton
                            ? ColorSchemes.gray.withOpacity(0.4)
                            : isSelected && widget.isMe
                            ? ColorSchemes.iconBackGround.withOpacity(0.7)
                            : isSelected
                            ? ColorSchemes.primary.withOpacity(0.2)
                            : Colors.transparent,
                      ),
                      child: Text(
                        reaction,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: ColorSchemes.white,
                          fontSize: isAddButton ? 14 : 18,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  /// Builds the message bubble shown below the emoji bar.
  Widget _buildMessageWidget() {
    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      from: 100,
      child:
      widget.isMe ? widget.myMassageContent : widget.receiverMassageContent,
    );
  }

  /// Builds the context menu (reply, copy, delete, close).
  Widget _buildContextMenuWidget() {
    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: !widget.isMe
                ? const Color(0xFFF4EBFE).withOpacity(0.9)
                : ColorSchemes.greyDivider.withOpacity(0.9),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _contextMenu.map((contextMenu) {
              int index = _contextMenu.indexOf(contextMenu);
              return FadeInLeft(
                duration: const Duration(milliseconds: 500),
                from: (index * 20).toDouble(),
                child: InkWell(
                  onTap: () {
                    widget.onContextMenuSelected(
                        contextMenu, widget.message.id);
                    setState(() {
                      contextMenuClicked = true;
                      clickedContextMenuIndex = index;
                    });
                    Future.delayed(const Duration(milliseconds: 500), () {
                      if (mounted) {
                        setState(() {
                          contextMenuClicked = false;
                        });
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _getText(contextMenu),
                          style:
                          Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorSchemes.black,
                            fontSize: 14,
                          ),
                        ),
                        Pulse(
                          infinite: false,
                          duration: const Duration(milliseconds: 500),
                          animate: contextMenuClicked &&
                              clickedContextMenuIndex == index,
                          child: Icon(
                            contextMenu == Constants.reply
                                ? Icons.reply
                                : contextMenu == Constants.copy
                                ? Icons.copy
                                : contextMenu == Constants.delete
                                ? Icons.delete
                                : Icons.close,
                            color: ColorSchemes.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  /// Checks if the current user has already selected a given reaction.
  bool _isReactionSelectedByMe(String reaction) {
    return selectedReactions.contains(reaction) &&
        widget.message.messageReactions.any((element) =>
        element.reaction == reaction &&
            element.userId == widget.currentUserId);
  }
}
