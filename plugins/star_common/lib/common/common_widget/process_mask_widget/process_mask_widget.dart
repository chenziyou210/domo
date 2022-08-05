/*
 *  Copyright (C), 2015-2021
 *  FileName: process_mask_widget
 *  Author: Tonight丶相拥
 *  Date: 2021/9/22
 *  Description: 
 **/

part of appcommon;

class ProcessMaskWidget extends StatefulWidget {
  ProcessMaskWidget({this.width, this.height, required this.controller});
  final double? width;
  final double? height;
  final ProcessMaskController controller;
  @override
  createState() => _ProcessMaskWidgetState(width: width, height: height);
}

class _ProcessMaskWidgetState extends State<ProcessMaskWidget> {
  _ProcessMaskWidgetState({this.height, this.width});
  double? width;
  double? height;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (width == null || height == null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        var size = MediaQuery.of(context).size;
        this.width = size.width;
        this.height = size.height;
        setState(() {});
      });
    }
    widget.controller._setState(this.setState);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller._setState(null);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (width == null || height == null) return SizedBox();

    var h = (widget.controller._percent / 100) * this.height!;

    return Offstage(
        offstage: widget.controller._isOffstage,
        child: Container(
            color: Colors.transparent,
            width: this.width,
            height: this.height,
            child: Stack(children: [
              Center(
                child: Text("${widget.controller._percent}%",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)),
              ),
              if (width != null && height != null)
                Positioned(
                    child: Container(
                        width: this.width,
                        height: this.height,
                        color: Colors.black.withOpacity(0.3)),
                    bottom: h,
                    left: 0,
                    right: 0,
                    top: 0)
            ])));
  }
}

class ProcessMaskController {
  ProcessMaskController([bool? offStage]) : this._isOffstage = offStage ?? true;
  int _percent = 0;
  bool _isOffstage;
  bool _isFailure = false;
  bool _isUploading = false;
  void Function(void Function())? _updateState;
  void _setState(void Function(void Function())? setState) {
    this._updateState = setState;
  }

  void _onProcessChange(int current, int amount) {
    this._percent = (current / amount * 100).toInt();
    this._update();
  }

  void _show() {
    this._percent = 0;
    _isOffstage = false;
    _isUploading = true;
    this._isFailure = false;
    this._update();
  }

  void _hide() {
    _isUploading = false;
    _isOffstage = true;
    this._update();
  }

  void _failure() {
    _isUploading = false;
    this._isFailure = true;
    this._percent = 0;
  }

  void _update() {
    _updateState?.call(() {});
  }
}
