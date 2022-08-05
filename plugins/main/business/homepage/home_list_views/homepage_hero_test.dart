import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({dynamic arguments})
      : this.roomcover = arguments["roomover"],
        this.roomtag = arguments["roomtag"];
  final String? roomcover;
  final String? roomtag;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Get.back();
        },
        onHorizontalDragStart: (details) {},
        onHorizontalDragCancel: () {},
        onHorizontalDragUpdate: (details) {},
        onHorizontalDragEnd: (details) {},
        onVerticalDragStart: (details) {},
        onVerticalDragCancel: () {},
        onVerticalDragUpdate: (details) {},
        onVerticalDragEnd: (details) {},
        child: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: this.roomtag!,
                child: Image.network(
                  this.roomcover ?? "",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
