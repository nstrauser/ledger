import 'package:flutter/material.dart';
import '../shared/theme.dart';

class TextFieldHeader extends StatelessWidget {
  final title;

  const TextFieldHeader({
    Key key, this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 85.0,
        margin: EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(title,
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.headline3,

        )
    );
  }
}