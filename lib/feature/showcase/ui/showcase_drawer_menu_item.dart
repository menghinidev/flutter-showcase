import 'package:flutter/material.dart';

class ShowcaseDrawerMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? onTap;
  const ShowcaseDrawerMenuItem({
    super.key,
    required this.title,
    this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Scaffold.of(context).closeDrawer();
        if (onTap != null) onTap!();
      },
    );
  }
}
