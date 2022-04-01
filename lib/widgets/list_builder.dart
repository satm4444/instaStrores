import 'package:flutter/material.dart';
import 'package:instastores/widgets/tiles_widget.dart';

class ListTileBuilder extends StatelessWidget {
  const ListTileBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (builder, index) {
        return TilesWidget();
      },
    );
  }
}
