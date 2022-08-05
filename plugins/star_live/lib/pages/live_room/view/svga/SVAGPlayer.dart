import 'package:alog/alog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:star_common/manager/video_manager.dart';
import 'package:svgaplayer_flutter/player.dart';

import '../../live_room_chat_model.dart';
export 'package:star_common/manager/video_manager.dart';

class SVGAPlayer extends StatefulWidget {
  final IMModel imController;
  final PlayComplete playComplete;

  SVGAPlayer(this.playComplete, this.imController) : super();

  @override
  _SVGAPlayerState createState() => _SVGAPlayerState();
}

class _SVGAPlayerState extends State<SVGAPlayer>
    with SingleTickerProviderStateMixin {
  late SVGAAnimationController animationController;
  var loading = false;

  @override
  void initState() {
    loading = false;
    this.animationController = SVGAAnimationController(vsync: this);
    this.loadAnimation();
    super.initState();
  }

  @override
  void dispose() {
    Alog.e("dispose", tag: "SVGAPlayer");
    loading = false;
    this.animationController.dispose();
    super.dispose();
    VideoManager.instance.cancelFun();
  }

  void completeAnimation() {
    Alog.e("completeAnimation", tag: "SVGAPlayer");
    loading = false;
    // this.animationController.videoItem = null;
    loadAnimation();
  }

  void star() async {
    Alog.e("star:${!loading}", tag: "SVGAPlayer");
    if (loading) {
      if (this.animationController.videoItem != null) {
        return;
      }
    }
    completeAnimation();
  }

  void loadAnimation() async {
    Alog.e("loadAnimation:${!loading}", tag: "SVGAPlayer");
    animationController.clear();
    animationController.reset();
    var loadUrl = widget.playComplete.getNextUrl();
    if (loadUrl?.isEmpty ?? true) {
      animationController.stop();
      return;
    }
    print("playComplete loadAnimation:${loadUrl}");
    loading = true;
    VideoManager.instance.getVideo(loadUrl!, movieSuccess: playSvga);
  }

  void playSvga(dynamic entry) {
    Alog.e("playSvga:${!loading} result：${entry != null}", tag: "SVGAPlayer");
    if (entry == null || widget.imController.chats.playState.value == -1) {
      loading = false;
      return;
    }
    this.animationController.videoItem = entry;
    this
        .animationController
        .forward() // Try to use .forward() .reverse()
        .whenComplete(completeAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Alog.e("playState:${widget.imController.chats.playState.value}",
          tag: "playState");

      if (widget.imController.chats.playState.value == -1) {
        animationController.stop(canceled: true);
        animationController.reset();
        animationController.videoItem = null;
        loading = false;
      } else if (widget.imController.chats.svgUrl.isNotEmpty) {
        star();
      }
      if (loading == false) {
        ///处理动画播放完成的时候 残留在界面上的动画
        this.animationController.clear();
      }
      return Container(
        height: context.height,
        width: context.width,
        child: SVGAImage(this.animationController, fit: BoxFit.fill),
      );
    });
  }
}

abstract class PlayComplete {
  String? getNextUrl();
}
