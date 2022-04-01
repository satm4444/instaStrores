import 'package:flutter/material.dart';

class TilesWidget extends StatelessWidget {
  const TilesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
            ),
            width: 200,
            // color: Colors.blue,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Image.asset(
                "assets/images/child.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 50,
            width: 100,
            // color: Colors.black.withOpacity(0.1),
            child: Text("NEW ARRIVALS"),
          )
        ],
      ),
    );
  }
}
