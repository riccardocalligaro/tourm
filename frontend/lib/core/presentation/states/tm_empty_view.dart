import 'package:flutter/material.dart';

class TMEmptyView extends StatelessWidget {
  final String text;
  final IconData icon;

  const TMEmptyView({
    Key key,
    this.text,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Icon(
              icon ?? Icons.hourglass_empty,
              size: 80,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              text ?? 'Nessun elemento',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
