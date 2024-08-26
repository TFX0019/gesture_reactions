import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gesture_reaction/data.dart';
import 'package:gesture_reaction/widgets/message_item.dart';
import 'package:gesture_reaction/widgets/options_item.dart';

final List<ReactionItem> reactionOptions = [
  ReactionItem('👍', 'Like'),
  ReactionItem('❤️', 'Love'),
  ReactionItem('😂', 'Laugh'),
  ReactionItem('😮', 'Wow'),
  ReactionItem('😢', 'Sad'),
  ReactionItem('🙏', 'Pray'),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _showOptions = false;
  MessageItem? _message;
  late Animation<double> _animation;
  late Animation<double> _animation2;
  late Animation<Offset> _slideAnimation;
  final GlobalKey _selectedItemKey = GlobalKey();
  final GlobalKey _listViewKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // _animation2 = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.addListener(() {
      print(_controller.value);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleOptions(MessageItem? message, int index) {
    final RenderBox? listViewRenderBox = _listViewKey.currentContext?.findRenderObject() as RenderBox?;
    
    if(listViewRenderBox != null) {
      final listViewHeight = listViewRenderBox.size.height;
      final itemPosition = (index + 1) * 120.0;
      final scrollOffset = (itemPosition > listViewHeight ? itemPosition - listViewHeight : 0.0);

      setState(() {
      if (message != null && _message != message) {
        _message = message;
        final screenHeight = MediaQuery.of(context).size.height;
        final targetTop = 100.0;
        final startOffset = Offset(0, (scrollOffset + 120.0 - targetTop) / screenHeight);
        _slideAnimation = Tween<Offset>(begin: startOffset, end: Offset.zero)
            .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
        _controller.forward(from: 0.0);
      } else {
        _message = null;
        _controller.reverse();
      }
    });
    }


  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _animation = Tween<double>(begin: 50, end: size.width * 0.8).animate(_controller);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          ListView.builder(
              key: _listViewKey,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: conversation.length,
              itemBuilder: (context, index) {
                final item = conversation[index];
                return Hero(
                    tag: 'message_${item.mid}',
                    child: MessageView(
                      message: item,
                      onLongPress: () => _toggleOptions(item, index),
                    ));
              }),
              if(_message != null)
          AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return IgnorePointer(
                  ignoring: _controller.value == 0,
                  child: GestureDetector(
                    onTap: () => _toggleOptions(null, -1),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5 * _controller.value, 
                        sigmaY: 5 * _controller.value),
                      child: Container(
                        color: Colors.black.withOpacity(0.3 * _controller.value),
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: child,
                      ),
                    ),
                  ),
                ));
              }, child: _buildOptionsOverlay(size))
        ],
      )),
    );
  }

  Widget _buildOptionsOverlay(Size size) {
    return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedBuilder(
                              animation: _animation,
                              builder: (context, child) {
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.fastEaseInToSlowEaseOut,
                                  width: _animation.value,
                                  height: 50,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: _animation.isCompleted ? Wrap(
                                    children: reactionOptions
                                        .map((ele) => ReactionButton(
                                              reaction: ele,
                                            ))
                                        .toList(),
                                  ): null,
                                );
                              }
                            ),
                            Hero(
                                tag: 'message_${_message!.mid}',
                                child: MessageView(message: _message!,)),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white.withOpacity(0.7),
                              ),
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final item = options[index];
                                    return OptionView(
                                      option: item,
                                      onTap: () {
                                        _message = null;
                                        _showOptions = !_showOptions;
                                        setState(() {});
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      Container(
                                        height: 1,
                                        width: size.width,
                                        color: Colors.grey,
                                      ),
                                  itemCount: options.length),
                            )
                          ],
                        ),
                      );
  }
}

class ReactionButton extends StatelessWidget {
  final ReactionItem reaction;
  const ReactionButton({super.key, required this.reaction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          reaction.name,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class ReactionItem {
  final String name;
  final String value;

  ReactionItem(this.name, this.value);
}
