import 'package:flutter/material.dart';
import 'dart:ui';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  int? selectedMessageIndex;

  final List<ReactionOption> reactionOptions = [
    ReactionOption('👍', 'Like'),
    ReactionOption('❤️', 'Love'),
    ReactionOption('😂', 'Laugh'),
    ReactionOption('😮', 'Wow'),
    ReactionOption('😢', 'Sad'),
    ReactionOption('🙏', 'Pray'),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () {
                setState(() {
                  selectedMessageIndex = index;
                });
              },
              child: Hero(
                tag: 'message_$index',
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('Mensaje $index'),
                  ),
                ),
              ),
            );
          },
        ),
        if (selectedMessageIndex != null)
          GestureDetector(
            onTap: () {
              setState(() {
                selectedMessageIndex = null;
              });
            },
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: Center(
                  child: Hero(
                    tag: 'message_$selectedMessageIndex',
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildReactionBar(),
                            SizedBox(height: 16),
                            Text('Mensaje $selectedMessageIndex'),
                            SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _buildOption(Icons.star_border, 'Star'),
                                _buildOption(Icons.reply, 'Reply'),
                                _buildOption(Icons.forward, 'Forward'),
                                _buildOption(Icons.copy, 'Copy'),
                                _buildOption(Icons.push_pin, 'Pin'),
                                _buildOption(Icons.report_problem, 'Report'),
                                _buildOption(Icons.delete, 'Delete', color: Colors.red),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildReactionBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...reactionOptions.map((option) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text(option.emoji, style: TextStyle(fontSize: 24)),
          )),
          SizedBox(width: 8),
          Icon(Icons.add, size: 20, color: Colors.grey[600]),
        ],
      ),
    );
  }

  Widget _buildOption(IconData icon, String label, {Color color = Colors.black87}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: color, fontSize: 12)),
      ],
    );
  }
}

class ReactionOption {
  final String emoji;
  final String name;

  ReactionOption(this.emoji, this.name);
}