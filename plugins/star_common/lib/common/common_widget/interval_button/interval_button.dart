/*
 *  Copyright (C), 2015-2022
 *  FileName: interval_button
 *  Author: Tonight丶相拥
 *  Date: 2022/4/9
 *  Description: 
 **/

part of appcommon;

class CustomIntervalButton extends StatefulWidget {
  CustomIntervalButton({required this.child,
    this.timerInterval: 2, this.onTap});
  final Widget child;
  final int timerInterval;
  final VoidCallback? onTap;
  @override
  createState()=> _CustomIntervalButtonState();
}

class _CustomIntervalButtonState extends State<CustomIntervalButton> {

  bool _isInInterval = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widget.child.cupertinoButton(
      onTap: (){
        if (_isInInterval || widget.onTap == null) {
          return;
        }
        widget.onTap!();
        _isInInterval = true;
        Timer(Duration(seconds: widget.timerInterval), (){
          _isInInterval = false;
        });
      }
    );
  }
}