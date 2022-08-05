import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import 'package:alog/alog.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:svgaplayer_flutter/parser.dart';
import 'package:svgaplayer_flutter/proto/svga.pb.dart';

class VideoManager {
  VideoManager._() {
    // DefaultCacheManager().webHelper
    _instance = this;
  }

  static VideoManager? _instance;

  /// 单例共享
  static VideoManager get instance =>
      _instance != null ? _instance! : VideoManager._();

  // Map<DownLoadInfo, MovieEntity?> cacheVideos = HashMap();
  List<DownLoadInfo> cacheFile = [];
  String tag = "VideoManager";
  var priority = 0;
  static const int maxCoreSize = 3;

  Future<MovieEntity> cacheGiftVideo(DownLoadInfo loadInfo, File file) async {
    var bytes = file.readAsBytesSync();
    MovieEntity entity =
        await SVGAParser.shared.decodeFromBuffer(bytes.buffer.asInt8List());
    return entity;
  }

  DownLoadInfo getDownLoadInfo(String url) {
    var list = cacheFile.where((element) => element.url == url);
    if (list.isNotEmpty) {
      return list.first;
    }
    var newInfo = DownLoadInfo(url, getPriority());
    cacheFile.add(newInfo);
    return newInfo;
  }

  void cacheFiles(List<String> urls) {
    for (var url in urls) {
      getDownLoadInfo(url);
    }
    Alog.e(urls.toString(), tag: "${tag}:cacheFiles");
    _starCacheFile();
  }

  void _starCacheFile({DownLoadInfo? current}) async {
    DownLoadInfo? info = null;
    if (current != null) {
      info = current;
    }
    var needCacheUrls = cacheFile.where((downInfo) =>
        downInfo.file == null && !downInfo.isLoading() && !downInfo.isError());
    int workSize = cacheFile.where((element) => element.isLoading()).length + 1;
    if (needCacheUrls.isNotEmpty) {
      info = needCacheUrls.first;
    }
    if (info != null) {
      if (info.file != null) {
        info.loadFinish(info.file!);
        return;
      }
      if (workSize > maxCoreSize) {
        Alog.e(
            "缓存取消 当前核心：${workSize} priority:${info.priority} 等待缓存数量：${needCacheUrls.length} \nurl：${info.url}",
            tag: "${tag}:_starCacheFile");
        return;
      }
      if (info.isLoading()) {
        Alog.e(
            "缓存重复 当前核心：${workSize} priority:${info.priority} 等待缓存数量：${needCacheUrls.length} \nurl：${info.url}",
            tag: "${tag}:_starCacheFile");
        return;
      }
      info.justLoading();
      try {
        Alog.e(
            "缓存开始 当前核心：${workSize} priority:${info.priority} 等待缓存数量：${needCacheUrls.length} \nurl：${info.url} ",
            tag: "${tag}:_starCacheFile");
        File? file = await DefaultCacheManager().getSingleFile(info.url);
        info.loadFinish(file);
        Alog.e(
            "缓存成功 当前核心：${workSize} priority:${info.priority} 等待缓存数量：${needCacheUrls.length} \nurl：${info.url}",
            tag: "${tag}:_starCacheFile");
      } catch (e) {
        Alog.e(
            "缓存报错 当前核心：${workSize} e:${e.runtimeType} 等待缓存数量：${needCacheUrls.length} \nurl：${info.url} ",
            tag: "${tag}:_starCacheFile");
        DefaultCacheManager().removeFile(info.url);
        info.loadError();
      }
    }
    if (needCacheUrls.length > 0) {
      _starCacheFile();
    }
  }

  void getVideo(String url, {void Function(MovieEntity)? movieSuccess}) async {
    var loadInfo = getDownLoadInfo(url);
    loadInfo.priority = getPriority();
    try {
      if (loadInfo.file != null) {
        Alog.e("取缓存 url：${url}", tag: "${tag} getVideo");
        movieSuccess?.call((await cacheGiftVideo(loadInfo, loadInfo.file!)));
        return;
      } else {
        Alog.e("等待加载 url：${url}", tag: "${tag} getVideo");
        loadInfo.loadBegin((file) async {
          movieSuccess?.call((await cacheGiftVideo(loadInfo, file)));
        });
      }
    } catch (e) {
      loadInfo.loadError();
      Alog.e(e, tag: "GetVideo");
    }
    _starCacheFile(current: loadInfo);
    return;
  }

  Future<File> cacheVideoFile(String url, Uint8List fileBytes) async {
    return DefaultCacheManager().putFile(url, fileBytes);
  }

  int getPriority() {
    this.priority += 1;
    return this.priority;
  }

  void cancelFun() {
    cacheFile.forEach((loadInfo) {
      loadInfo.cancel();
    });
  }
}

class DownLoadInfo extends Comparable<DownLoadInfo> {
  String url;
  int priority;
  bool _isLoading = false;
  bool _isError = false;
  File? file;
  void Function(File)? _success;
  DownLoadInfo(this.url, this.priority);

  bool isLoading() {
    return _isLoading;
  }

  bool isError() {
    return _isError;
  }

  void loadError() {
    this._isLoading = false;
    this._isError = true;
  }

  void justLoading() {
    this._isLoading = true;
    this._isError = false;
  }

  void loadBegin(void Function(File)? success) {
    this._isLoading = false;
    this._success = success ?? this._success;
    this._isError = false;
  }

  void loadFinish(File file) {
    this.file = file;
    this._isLoading = false;
    this._success?.call(file);
  }

  void cancel() {
    this._success = null;
  }

  @override
  int compareTo(DownLoadInfo other) {
    return other.priority.compareTo(this.priority);
  }
}
