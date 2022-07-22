import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key, this.message}) : super(key: key);
  static const routeName = 'empty_screen';
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Empty page'),
        centerTitle: true,
        backgroundColor: Colors.orange[900],
      ),
      body: Center(
        child: Container(
          child: Text(
            message ?? 'Error',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
