import 'package:flutter/material.dart';

class OptionItem {
  final String title;
  final IconData icon;

  OptionItem(this.title, this.icon);
}

class OptionView extends StatelessWidget {
  final OptionItem option;
  final void Function()? onTap;
  const OptionView({super.key, required this.option, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(option.title),
      trailing: Icon(option.icon),
    );
  }
}