// /*
//  *  Copyright (C), 2015-2021 , schw
//  *  FileName: image_pick
//  *  Author: Tonight丶相拥
//  *  Date: 2021/1/6
//  *  Description:
//  **/
//
//
// import 'package:flutter/material.dart';
// import 'package:wechat_assets_picker/wechat_assets_picker.dart';
// import 'package:wechat_camera_picker/wechat_camera_picker.dart';
//
// export 'package:wechat_assets_picker/wechat_assets_picker.dart';
//
// mixin ImagePick {
//   /// 相册选择
//   Future<List<AssetEntity>?> pickImage(BuildContext context,
//       {int maxImagesLength: 9, int exitImagesLength: 0, List<AssetEntity>? selectedAssets}) async{
//     final list = AssetPicker.pickAssets(
//       context,
//       maxAssets: maxImagesLength - exitImagesLength,
//       selectedAssets: selectedAssets,
//       // themeColor: AppConfig.config.appBarTheme.color,//BusinessColor.brandColor,
//       // pickerTheme: appTheme,
//       requestType: RequestType.image,
//       specialItemPosition: SpecialItemPosition.prepend,
//       specialItemBuilder: (BuildContext context) {
//         return GestureDetector(
//           behavior: HitTestBehavior.opaque,
//           onTap: () async {
//             final AssetEntity? result = await camera(context);
//             if (result != null) {
//               Navigator.of(context).pop([result]);
//             }
//           },
//           child: const Center(
//             child: Icon(Icons.camera_enhance, size: 42.0),
//           ),
//         );
//       }
//     );
//     return list;
//   }
//
//   /// 拍照
//   Future<AssetEntity?> camera(BuildContext context) async{
//     final AssetEntity? result = await CameraPicker.pickFromCamera(
//       context,
//       enableRecording: false,
//       imageFormatGroup: ImageFormatGroup.bgra8888
//     );
//     return result;
//   }
// }