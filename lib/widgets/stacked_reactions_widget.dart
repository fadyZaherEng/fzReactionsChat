import 'package:flutter/material.dart';

/// A widget that displays stacked emoji reactions on a message bubble.
///
/// This can be used both inside the main chat UI and within a dialog (based on [isDialogReactions]).
/// Tapping the widget triggers [onPressed].
///
/// The widget automatically adjusts the display for messages sent by the current user ([isMe]).
class StackedReactionsWidget extends StatefulWidget {
  /// The message object that contains reaction data.
  /// Must have `messageReactions` and `messageReactionsCount` lists.
  ///
  /// message Reactions By Count For Each Reaction
  final Map<String, int> messageReactionsByCountForEachReaction;
  ///All Massage Reaction
  final Map<String, int> allMessageReactions;

  /// Whether the message was sent by the current user.
  final bool isMe;

  /// Whether this widget is rendered inside a dialog view.
  final bool isDialogReactions;

  /// Font size for the emoji reactions.
  final double size;

  /// Callback when the widget is tapped.
  final VoidCallback onPressed;

  /// Optional custom style for the widget.
  final ReactionStyle? style;

  const StackedReactionsWidget({
    super.key,
    required this.messageReactionsByCountForEachReaction,
    required this.allMessageReactions,
    required this.size,
    required this.onPressed,
    required this.isMe,
    required this.isDialogReactions,
    this.style,
  });

  @override
  State<StackedReactionsWidget> createState() => _StackedReactionsWidgetState();
}

class _StackedReactionsWidgetState extends State<StackedReactionsWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: _buildReactionContainer(
        reactions: widget.messageReactionsByCountForEachReaction.entries
            .map<String>((e) => e.key)
            .toList(),
      ),
    );
  }

  Widget _buildReactionContainer({required List<String> reactions}) {
    final style = widget.style ??
        ReactionStyle.defaultStyle(
          isMe: widget.isMe,
          isDialog: widget.isDialogReactions,
          theme: Theme.of(context),
        );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        borderRadius: style.borderRadius,
        color: style.backgroundColor,
        border: Border.all(color: style.borderColor, width: style.borderWidth),
      ),
      child: ClipOval(
        child: Padding(
          padding: style.padding,
          child: Row(
            children: [
              if (_shouldShowCountBefore()) _buildCountWidget(style),
              ...List.generate(
                reactions.length,
                (index) {
                  final reaction = reactions[index].trim();
                  if (reaction.isEmpty) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      reaction,
                      style: style.reactionTextStyle.copyWith(
                        fontSize: widget.size,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
              if (_shouldShowCountAfter()) _buildCountWidget(style),
            ],
          ),
        ),
      ),
    );
  }

  bool _shouldShowCountBefore() {
    return widget.allMessageReactions.length > 1 && widget.isMe;
  }

  bool _shouldShowCountAfter() {
    return widget.allMessageReactions.length > 1 && !widget.isMe;
  }

  Widget _buildCountWidget(ReactionStyle style) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Text(
        widget.allMessageReactions.length.toString(),
        textAlign: TextAlign.center,
        style: style.countTextStyle,
      ),
    );
  }
}

/// Defines visual styles for the [StackedReactionsWidget].
class ReactionStyle {
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final TextStyle reactionTextStyle;
  final TextStyle countTextStyle;

  const ReactionStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.padding,
    required this.reactionTextStyle,
    required this.countTextStyle,
  });

  /// Default style factory that builds based on theme, user ownership, and dialog mode.
  factory ReactionStyle.defaultStyle({
    required bool isMe,
    required bool isDialog,
    required ThemeData theme,
  }) {
    return ReactionStyle(
      backgroundColor: isDialog && !isMe
          ? theme.colorScheme.primary.withOpacity(0.25)
          : theme.colorScheme.surfaceVariant,
      borderColor: theme.colorScheme.primary,
      borderWidth: 0.4,
      borderRadius: BorderRadius.circular(25),
      padding: const EdgeInsets.all(2),
      reactionTextStyle: TextStyle(
        fontSize: 14,
        color: theme.textTheme.bodyMedium?.color,
      ),
      countTextStyle: theme.textTheme.bodyMedium!.copyWith(
        color: isDialog && !isMe ? Colors.white : Colors.black,
      ),
    );
  }
}
