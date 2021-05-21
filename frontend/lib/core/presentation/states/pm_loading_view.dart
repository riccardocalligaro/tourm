import 'package:flutter/material.dart';

class TMLoadingView extends StatelessWidget {
  const TMLoadingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
