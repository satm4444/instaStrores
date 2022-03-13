import 'package:flutter/material.dart';

class FeedbackTile extends StatelessWidget {
  final String mail;
  final String feed;
  const FeedbackTile({Key? key, required this.mail, required this.feed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.04),
            borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          title: Text(mail),
          subtitle: Text(feed),
          leading: Icon(Icons.person),
        ),
      ),
    );
  }
}
