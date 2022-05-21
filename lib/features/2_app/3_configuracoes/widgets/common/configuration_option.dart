// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ConfigurationOption extends StatelessWidget {
  final String title;
  final Widget subtitle;
  final IconData icon;

  final IconData? endIcon;

  final VoidCallback? callback;

  const ConfigurationOption({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.endIcon,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: callback,
      leading: SizedBox(
        width: 50,
        child: Center(
          child: Icon(icon),
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: subtitle,
      trailing: Icon(endIcon),
    );
  }
}
