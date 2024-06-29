import 'package:flutter/material.dart';

class IconButtonColumn extends StatelessWidget {
  final Function()? onPressed;
  final IconData icon;
  final String text;
  const IconButtonColumn({super.key, this.onPressed, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
          color: theme.iconTheme.color,
        ),
        const SizedBox(height: 4),
        Text(
          text,
          style: theme.textTheme.labelSmall,
        ),
      ],
    );
  }
}
