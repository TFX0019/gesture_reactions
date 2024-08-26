import 'package:flutter/material.dart';

class MessageView extends StatelessWidget {
  final MessageItem message;
  final void Function()? onLongPress;
  const MessageView({super.key, required this.message, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onLongPress: onLongPress,
      child: Row(
      mainAxisAlignment: message.id == 1 ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 8), child: SizedBox(
          width: size.width * 0.7, 
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: message.id == 1 ? Colors.grey : Colors.green.shade200
          ),
          child: Text(message.message),
          ),),)
      ],
    ),
    );
  }
}


class MessageItem {
  final int id;
  final String message;
  final int mid;

  MessageItem(this.id, this.mid, this.message);
}