/*
 *  Copyright (C), 2015-2021
 *  FileName: http_channel_extension
 *  Author: Tonight丶相拥
 *  Date: 2021/3/11
 *  Description: 
 **/

part of httpplugin;

extension HttpChannelExtension on HttpChannel {
  setUserSuccess(void Function(dynamic)? success) {
    userSuccess = success;
  }

  /// 取消请求
  void cancelRequest(int token) {
    HttpMidBuffer.buffer.cancelRequestWidth(token);
  }

  /// 账号注册
  /// account: 账号
  /// password：密码
  /// repassword：确认密码
  Future<HttpResultContainer> register(
      {required String account,
      required String password,
      required String rePassword,
      required String deviceCode,
      required String code}) {
    return _onCommonRequest(
        AppRequest.registered,
        {
          HttpPluginKey.BODY: {
            "password": password,
            "rePassword": rePassword,
            "account": account,
            "code": code,
            "deviceCode": deviceCode
          }
        },
        needToken: false);
  }

  /// 登录
  /// 账号登录
  Future<HttpResultContainer> logIn(
      String account,
      String code,
      int device,
      {String? type}) {
    return _onCommonRequest(
        AppRequest.logIn,
        {
          HttpPluginKey.BODY: {
            "type": type,
            "account": account,
            "device": device,
            "code": code,
          }
        },
        needToken: false);
  }

  /// 登录
  /// type：0-游客登录、1-账号登录
  Future<HttpResultContainer> guestlogin(String deviceCode) {
    return _onCommonRequest(
        AppRequest.guestlogIn, {
          HttpPluginKey.BODY: {
            "deviceCode": deviceCode,
          }
        },
        needToken: false);
  }

  /// 上传图片
  Future<HttpResultContainer> uploadImage(dynamic image,
      {void Function(int count, int amount)? process,
      void Function(int? token)? cancelToken}) async {
    // return HttpMidBuffer.buffer.uploadWithParameter(AppRequest.uploadImage, {
    //   HttpPluginKey.BODY: image,
    //   HttpPluginKey.HEADER: {
    //     "token": AppUser.user.token!
    //   }
    // });
    var value = await MultipartFile.fromFile(image);

    return HttpMidBuffer.buffer.uploadWithParameter(
        AppRequest.uploadImage,
        {
          HttpPluginKey.HEADER: {
            "content-type": "multipart/form-data",
            "token": httpToken()
          },
          HttpPluginKey.BODY: FormData.fromMap({"file": value})
        },
        cancelToken: cancelToken,
        process: process);
    // return _onCommonRequest(AppRequest.uploadImage, {
    //   HttpPluginKey.HEADER: {
    //     "content-type": "multipart/form-data"
    //   },
    //   HttpPluginKey.BODY: FormData.fromMap({
    //     "file": value
    //   })
    // }, cancelToken: cancelToken);
  }

  /// 用户信息
  Future<HttpResultContainer> userInfo() async {
    // MqttManager.install.connect(
    //     AppManager.getInstance<GlobalSettingModel>().viewModel.mqtt_ip,
    //     AppManager.getInstance<AppUser>().userId);
    print("MqttManager connect userInfo");
    var result = await _onCommonRequest(AppRequest.userInfo, {});
    if (result.data != null) {
      if (result.data["data"] != null &&
          result.data["data"]["userId"] != null) {
        var userId = result.data["data"]["userId"];
        userSuccess?.call(userId);
      }
    }
    return result;
  }

  /// 编辑个人信息
  Future<HttpResultContainer> editUserInfo({
    String? avatar,
    String? birthday,
    String? city,
    String? emotion,
    String? profession,
    int? sex,
    String? signature,
    String? roomCover,
    String? roomBackground,
  }) {
    return _onCommonRequest(AppRequest.editUserInfo, {
      HttpPluginKey.BODY: {
        "birthday": birthday,
        "city": city,
        "emotion": emotion,
        "header": avatar,
        "profession": profession,
        "sex": sex ?? 0,
        "signature": signature,
        "roomCover": roomCover,
        "roomBackground": roomBackground,
      }
    });
  }

  /// 设置信息
  Future<HttpResultContainer> settingInfo() {
    return _onCommonRequest(AppRequest.settingInfo, {});
  }

  /// 系统参数
  Future<HttpResultContainer> systemParameter() {
    return _onCommonRequest(AppRequest.systemParameter, {});
  }

  /// 设置更新
  /// id: 用户id: userId
  Future<HttpResultContainer> settingUpdate(
      {required String accountSecurity,
      required int appLock,
      required String id,
      required String language}) {
    return _onCommonRequest(AppRequest.settingUpdate, {
      HttpPluginKey.BODY: {
        "accountSecurity": accountSecurity,
        "appLock": appLock,
        "id": id,
        "language": language
      }
    });
  }

  /// 获取黑名单
  Future<HttpResultContainer> blackList(int page, [int pageSize = _pageSize]) {
    return _onCommonRequest(AppRequest.blackList, {
      HttpPluginKey.BODY: {"pageNum": page, "pageSize": pageSize}
    });
  }

  /// 删除黑名单
  Future<HttpResultContainer> deleteBlackList(String id) {
    return _onCommonRequest(AppRequest.deleteBlackList, {
      HttpPluginKey.BODY: {"id": id}
    });
  }

  /// 加入黑名单
  Future<HttpResultContainer> insertBlackList(String id) {
    return _onCommonRequest(AppRequest.insertBlackList, {
      HttpPluginKey.BODY: {"blackId": id}
    });
  }

  /// 关注列表
  Future<HttpResultContainer> favoritePaging(String userId, int page,
      [int pageSize = _pageSize]) {
    return _onCommonRequest(AppRequest.favoritePaging, {
      HttpPluginKey.BODY: {
        "userId": userId,
        "pageNum": page,
        "pageSize": pageSize,
      }
    });
  }

  /// 添加关注
  Future<HttpResultContainer> favoriteInsert(String id, String roomid) {
    return _onCommonRequest(AppRequest.favoriteInsert, {
      HttpPluginKey.BODY: {"followUserId": id, "roomId": roomid}
    });
  }

  /// 取消关注
  Future<HttpResultContainer> favoriteCancel(String id) {
    return _onCommonRequest(AppRequest.favoriteDelete, {
      HttpPluginKey.BODY: {"followUserId": id}
    });
  }

  /// 退出登录
  Future<HttpResultContainer> logOut() {
    return _onCommonRequest(AppRequest.logOut, {});
  }

  /// 主播列表
  /// type
  Future<HttpResultContainer> anchorListByType(
      int page, int? type, int pageSize,
      {String? city, int? gameId, int? sex}) {
    return _onCommonRequest(AppRequest.anchorList, {
      HttpPluginKey.BODY: {
        "id": type,
        "pageNum": page,
        "pageSize": pageSize,
        "city": city,
        "gameId": gameId,
        "sex": sex
      }
    });
  }

  /// 关注主播列表
  /// type
  Future<HttpResultContainer> watchlistListByType(int page,
      [int pageSize = _pageSize]) {
    return _onCommonRequest(AppRequest.followAnchorList, {
      HttpPluginKey.BODY: {"pageNum": page, "pageSize": pageSize}
    });
  }

  /// 创建普通直播间
  /// defaultRoom: （1:普通房间 2:门票房间 3:计时房间 4:游戏房间）
  /// isopen_props:  是否开启道具(0：否1：是)
  Future<HttpResultContainer> createCommonRoom({
    required int feeType,
    required int isNameCardOpen,
    required String roomCover,
    required String roomTitle,
    required int roomType,
    required int showCardAmount,
    required String ticketAmount,
    required String timeDeduction,
    required int gameId,
    required String wxInfo,
    required String isRegion,
  }) {
    return _onCommonRequest(AppRequest.createCommonRoom, {
      HttpPluginKey.BODY: {
        "feeType": feeType,
        "isNameCardOpen": isNameCardOpen,
        "roomCover": roomCover,
        "roomTitle": roomTitle,
        "roomType": roomType,
        "showCardAmount": showCardAmount,
        "ticketAmount": ticketAmount,
        "timeDeduction": timeDeduction,
        "gameId": gameId,
        "wxInfo": wxInfo,
        "isRegion": isRegion,
        // "anchorType": anchorType
      }
    });
  }

  // /// 创建游戏直播间
  // Future<HttpResultContainer> createGameRoom(
  //     {required String roomTitle,
  //     required String cover,
  //     required int level,
  //     required String anchorType}) {
  //   return createCommonRoom(
  //       roomTitle: roomTitle,
  //       cover: cover,
  //       anchorType: anchorType,
  //       level: level,
  //       type: 4);
  // }
  //
  // /// 创建门票直播间
  // Future<HttpResultContainer> createTickerAmountRoom(
  //     {required String roomTitle,
  //     required String cover,
  //     required double ticketAmount,
  //     required String minute,
  //     required String anchorType}) {
  //   return _onCommonRequest(AppRequest.createCommonRoom, {
  //     HttpPluginKey.BODY: {
  //       "roomType": 2,
  //       "roomTitle": roomTitle,
  //       "roomCover": cover,
  //       "ticketAmount": ticketAmount,
  //       "timeDeduction": "0",
  //       "openProps": true,
  //       // "ticketTryseeTime": int.parse(minute),
  //       // "anchorType": anchorType
  //     }
  //   });
  // }
  //
  // /// 创建计时直播间
  // Future<HttpResultContainer> createTimeDeductionRoom(
  //     {required String roomTitle,
  //     required String cover,
  //     required double timeDeduction,
  //     required String minute,
  //     required String anchorType}) {
  //   return _onCommonRequest(AppRequest.createCommonRoom, {
  //     HttpPluginKey.BODY: {
  //       "roomType": 3,
  //       "roomTitle": roomTitle,
  //       "roomCover": cover,
  //       "timeDeduction": timeDeduction,
  //       "ticketAmount": "0",
  //       "openProps": true,
  //       // "ticketTryseeTime": int.parse(minute),
  //       // "anchorType": anchorType
  //     }
  //   });
  // }

  // /// 主播退出直播间
  // Future<HttpResultContainer> anchorExitRoom({required String roomId}){
  //   return _onCommonRequest(AppRequest.anchorExitRoom, {
  //     HttpPluginKey.QUERYPARAMETER: {
  //       "roomID": roomId
  //     }
  //   });
  // }

  /// 关闭直播间
  Future<HttpResultContainer> destroyRoom({
    required String roomId,
    // required String groupId
  }) {
    return _onCommonRequest(AppRequest.destroyRoom, {
      HttpPluginKey.BODY: {
        "roomId": roomId,
        // "groupId": groupId
      }
    });
  }

  Future<HttpResultContainer> checkRecharge() {
    return _onCommonRequest(AppRequest.checkRecharge, {HttpPluginKey.BODY: {}});
  }

  /// 刷礼物
  /// 刷的礼物类型: 1普通礼物,扣货币资产; 2会员背包内的礼物
  Future<HttpResultContainer> brushGift({
    required String roomId,
    required String giftId,
    required String giftNum,
    required int type,
    required int comboCount,
  }) {
    return _onCommonRequest(AppRequest.brushGift, {
      HttpPluginKey.BODY: {
        "roomId": roomId,
        "giftId": giftId,
        "giftNum": giftNum,
        "brushGiftType": type,
        "comboCount": comboCount,
      }
    });
  }

  /// 观众退出直播间
  Future<HttpResultContainer> audienceExitRoom(
      {required String roomId, required bool follow

      ///1: 直接退出 2:观众:关注主播并退出直播间
      }) {
    return _onCommonRequest(AppRequest.audienceExitRoom, {
      HttpPluginKey.BODY: {"roomId": roomId, "follow": follow}
    });
  }

  // /// 退出并关注
  // Future<HttpResultContainer> audienceExitAndAttention({
  //   required String roomId,
  //   required String anchorId,
  //   required String userId
  // }){
  //   return _onCommonRequest(AppRequest.audienceExitAndAttention, {
  //     HttpPluginKey.QUERYPARAMETER: {
  //       "roomID": roomId,
  //       "anchorId": anchorId,
  //       "userId": userId
  //     }
  //   });
  // }

  // /// 直播间观众数量
  // Future<HttpResultContainer> audienceCount({
  //   required String roomId
  // }){
  //   return _onCommonRequest(AppRequest.audienceCount, {
  //     HttpPluginKey.QUERYPARAMETER: {
  //       "roomID": roomId
  //     }
  //   });
  // }

  /// 日排行
  Future<HttpResultContainer> dailyRank(
      {required String anchorId,
      required int pageNum,
      int pageSize: _pageSize}) {
    return _onCommonRequest(AppRequest.liveRoomRank, {
      HttpPluginKey.BODY: {
        "anchorId": anchorId,
        "pageNum": pageNum,
        "pageSize": pageSize,
        "state": 1
      }
    });
  }

  /// 月排行
  Future<HttpResultContainer> monthRank(
      {required String anchorId,
      required int pageNum,
      int pageSize: _pageSize}) {
    return _onCommonRequest(AppRequest.liveRoomRank, {
      HttpPluginKey.BODY: {
        "anchorId": anchorId,
        "pageNum": pageNum,
        "pageSize": pageSize,
        "state": 3
      }
    });
  }

  /// 周排行
  Future<HttpResultContainer> weekRank(
      {required String anchorId,
      required int pageNum,
      int pageSize: _pageSize}) {
    return _onCommonRequest(AppRequest.liveRoomRank, {
      HttpPluginKey.BODY: {
        "anchorId": anchorId,
        "pageNum": pageNum,
        "pageSize": pageSize,
        "state": 2
      }
    });
  }

  /// 获取user 信息
  Future<HttpResultContainer> getUserInfo(String userId) {
    return _onCommonRequest(AppRequest.getUserInfo, {
      HttpPluginKey.BODY: {
        "userId": userId,
      }
    });
  }

  /// 直播间获取user 信息
  Future<HttpResultContainer> getLiveRoomUserInfo(String userId) {
    return _onCommonRequest(AppRequest.getLiveRoomUserInfo, {
      HttpPluginKey.BODY: {
        "userId": userId,
        "roomId": StorageService.to.getString("roomId"),
      }
    });
  }

  Future<HttpResultContainer> getNobelHideStatus() {
    return _onCommonRequest(
        AppRequest.getNobelHideStatus, {HttpPluginKey.BODY: {}});
  }

  Future<HttpResultContainer> setNobelHideStatus(
      int? rankProperties, int? roomProperties) {
    return _onCommonRequest(AppRequest.setNobelHideStatus, {
      HttpPluginKey.BODY: {
        "rankProperties": rankProperties,
        "roomProperties": roomProperties,
      }
    });
  }

//直播间首充活动奖励-新
  Future<HttpResultContainer> getFirstChargeReward() {
    return _onCommonRequest(AppRequest.getRewardInfo, {});
  }

  /// 直播间礼物列表
  Future<HttpResultContainer> roomGiftList(
      {required int pageNum, int pageSize: _pageSize}) {
    return _onCommonRequest(AppRequest.roomGiftList, {
      HttpPluginKey.BODY: {"pageNum": pageNum, "pageSize": pageSize}
    });
  }

  // /// 进入直播间
  // Future<HttpResultContainer> addAudience({required String roomId, required String userInfo}){
  //   return _onCommonRequest(AppRequest.addAudience, {
  //     HttpPluginKey.QUERYPARAMETER: {
  //       "roomID": roomId,
  //       "userInfo": userInfo
  //     }
  //   });
  // }

  /// 附近主播
  Future<HttpResultContainer> locationAnchor(String latitude, String longitude,
      {required int pageNum, int pageSize: _pageSize}) {
    return _onCommonRequest(AppRequest.locationSave, {
      HttpPluginKey.BODY: {
        "data": {"latitude": latitude, "longitude": longitude},
        "pageNum": pageNum,
        "pageSize": pageSize
      }
    });
  }

  /// 上传地理位置
  Future<HttpResultContainer> locationSave(String latitude, String longitude) {
    return _onCommonRequest(AppRequest.locationSave, {
      HttpPluginKey.BODY: {"latitude": "string", "longitude": "string"}
    });
  }

  // /// 根据roomId 获取直播间信息
  // Future<HttpResultContainer> getAnchors(String id){
  //   return _onCommonRequest(AppRequest.getAnchors, {
  //     HttpPluginKey.QUERYPARAMETER: {
  //       "roomID": id
  //     }
  //   });
  // }

  /// 首页日排行
  Future<HttpResultContainer> indexDailyRank(int pageNum,
      [int pageSize = _pageSize]) {
    return _onCommonRequest(AppRequest.indexRank, {
      HttpPluginKey.BODY: {
        "pageNum": pageNum,
        "pageSize": pageSize,
        "rankType": 1
      }
    });
  }

  /// 首页月排行
  Future<HttpResultContainer> indexMonthRank(int pageNum,
      [int pageSize = _pageSize]) {
    return _onCommonRequest(AppRequest.indexRank, {
      HttpPluginKey.BODY: {
        "pageNum": pageNum,
        "pageSize": pageSize,
        "rankType": 3
      }
    });
  }

  /// 首页周排行
  Future<HttpResultContainer> indexWeekRank(int pageNum,
      [int pageSize = _pageSize]) {
    return _onCommonRequest(AppRequest.indexRank, {
      HttpPluginKey.BODY: {
        "pageNum": pageNum,
        "pageSize": pageSize,
        "rankType": 2
      }
    });
  }

  /// 首页搜索分页查询
  Future<HttpResultContainer> recommend(String keyword, int pageNum,
      [int pageSize = _pageSize]) {
    return _onCommonRequest(AppRequest.homeSearch, {
      HttpPluginKey.BODY: {
        "keyword": keyword,
        "pageNum": pageNum,
        "pageSize": pageSize
      }
    });
  }

  /// 心跳
  Future<HttpResultContainer> heartBeat(
      {required String userId,
      required String token,
      required String roomId,
      int? statusCode}) {
    return _onCommonRequest(
        AppRequest.heartBeat,
        {
          HttpPluginKey.CUSTOMURL:
              "https://liveroom.qcloud.com/weapp/live_room/anchor_heartbeat",
          HttpPluginKey.QUERYPARAMETER: {"userId": userId, "token": token},
          HttpPluginKey.HEADER: {"token": httpToken()},
          HttpPluginKey.BODY: {
            "roomID": roomId,
            "userId": userId,
            "roomStatusCode": statusCode ?? 0
          }
        },
        needToken: false);
  }

  /// 直播间信息
  Future<HttpResultContainer> liveRoomInfo({required String roomId}) {
    return _onCommonRequest(AppRequest.liveRoomInfo, {
      HttpPluginKey.BODY: {"roomId": roomId}
    });
  }

  /// 首页banner
  /// 1:开机屏幕 2:首页弹框 3:首页广告位
  Future<HttpResultContainer> homeBanner(int type) {
    return _onCommonRequest(AppRequest.banner, {
      HttpPluginKey.BODY: {"advertiseType": type}
    });
  }

  // /// 获取用户信息
  // Future<HttpResultContainer> getUserById(String id) {
  //   return _onCommonRequest(AppRequest.getUserById, {
  //     HttpPluginKey.BODY: {"anchorId": id}
  //   });
  // }

  /// 主播贡献榜
  Future<HttpResultContainer> anchorContributionList(String anchorId, int page,
      [int pageSize = _pageSize]) {
    return _onCommonRequest(AppRequest.anchorContributionList, {
      HttpPluginKey.BODY: {
        "anchorId": anchorId,
        "pageNum": page,
        "pageSize": pageSize
      }
    });
  }

  /// 砖石充值页面
  Future<HttpResultContainer> showConsPage() {
    return _onCommonRequest(AppRequest.showConsPage, {});
  }

  /// 砖石充值
  Future<HttpResultContainer> chargeDiamond(String id) {
    return _onCommonRequest(AppRequest.chargeDiamond, {
      HttpPluginKey.BODY: {"appConsMoneyId": id}
    });
  }

  /// 余额充值
  Future<HttpResultContainer> balanceRecharge(double balance) {
    return _onCommonRequest(AppRequest.balanceRecharge, {
      HttpPluginKey.BODY: {"money": balance}
    });
  }

  /// 主播标签
  Future<HttpResultContainer> anchorLabel() {
    return _onCommonRequest(AppRequest.anchorLabel, {
      HttpPluginKey.BODY: {"pageNum": 1, "pageSize": 99999}
    });
  }

  /// 直播间验证
  /// 进入门票房间状态（0:试看 1:正常）--门票房间必传
  Future<HttpResultContainer> verifyLiveRoom(
      {required String roomId,
      required String prevRoomId,
      void Function(int? token)? cancelToken}) {
    return _onCommonRequest(
        AppRequest.liveRoomVerify,
        {
          HttpPluginKey.BODY: {"roomId": roomId, "prevRoomId": prevRoomId}
        },
        cancelToken: cancelToken)
      ..then((value) {
        value.finalize(wrapper: WrapperModel(), success: (data) {});
      });
  }

  /// 计时收费
  Future<HttpResultContainer> timerLiveRoom(String id) {
    return _onCommonRequest(AppRequest.timerLiveRoom, {
      HttpPluginKey.BODY: {
        "anchorId": id,
      }
    })
      ..then((value) {
        value.finalize(wrapper: WrapperModel(), success: (data) {});
      });
  }

  /// 直播间禁言
  /// time：时长(分钟)
  Future<HttpResultContainer> banSpeak(
      String anchorId, String userId, int time) {
    return _onCommonRequest(AppRequest.banSpeak, {
      HttpPluginKey.BODY: {"anchorId": anchorId, "userId": userId, "time": time}
    });
  }

  /// 取消直播间禁言
  Future<HttpResultContainer> deleteBanSpeak(String id) {
    return _onCommonRequest(AppRequest.deleteBanSpeak, {
      HttpPluginKey.BODY: {"id": id}
    });
  }

  /// 禁言列表
  Future<HttpResultContainer> banSpeakList(String anchorId, int pageNum,
      [int pageSize = _pageSize]) {
    return _onCommonRequest(AppRequest.banSpeakList, {
      HttpPluginKey.BODY: {
        "anchorId": anchorId,
        "pageNum": pageNum,
        "pageSize": pageSize
      }
    });
  }

  /// 提现
  Future<HttpResultContainer> withdraw(double number) {
    return _onCommonRequest(AppRequest.withdraw, {
      HttpPluginKey.BODY: {"money": number}
    });
  }

  /// 下注
  Future<HttpResultContainer> bet(Map<String, dynamic> map) {
    return _onCommonRequest(AppRequest.bet, {HttpPluginKey.BODY: map})
      ..then((value) {
        value.finalize(wrapper: WrapperModel(), success: (data) {});
      });
  }

  /// 游戏配置
  Future<HttpResultContainer> gameConfig({String? gameName}) {
    return _onCommonRequest(AppRequest.gameConfig, {
      HttpPluginKey.BODY: {"gameName": gameName}
    });
  }

  /// 运行游戏
  Future<HttpResultContainer> runtimeGame({String? gameName}) {
    return _onCommonRequest(AppRequest.runtimeGame, {
      HttpPluginKey.BODY: {"gameName": gameName}
    });
  }

  /// 直播间推荐
  Future<HttpResultContainer> livingRoomRecommend(int page,
      {int pageSize: _pageSize}) {
    return _onCommonRequest(AppRequest.livingRoomRecommend, {
      HttpPluginKey.BODY: {
        "pageNum": page,
        "pageSize": _pageSize,
        // "anchorId": anchorId
      }
    });
  }

  /// 观众数量
  Future<HttpResultContainer> audienceNumber(String roomId) {
    return _onCommonRequest(AppRequest.audienceNumber, {
      HttpPluginKey.BODY: {"roomId": roomId}
    });
  }

  /// 开奖记录
  Future<HttpResultContainer> lotteryLog(int page,
      {String? gameName, int pageSize: _pageSize, required int created}) {
    return _onCommonRequest(AppRequest.lotteryLog, {
      HttpPluginKey.BODY: {
        "pageNum": page,
        "pageSize": pageSize,
        "gameName": gameName,
        "created": created
      }
    });
  }

  /// 下注记录
  Future<HttpResultContainer> betLog(int page,
      {String? gameName, int pageSize: _pageSize}) {
    return _onCommonRequest(AppRequest.betLog, {
      HttpPluginKey.BODY: {
        "pageNum": page,
        "pageSize": pageSize,
        "gameName": gameName
      }
    });
  }

  /// 展示银行卡
  Future<HttpResultContainer> showBank() {
    return _onCommonRequest(AppRequest.showBank, {});
  }

  ///    bindBankDelete: ()=> DeleteBindBank(),
//     bindBankInfo: ()=> UserBindBankInfo(),
//     userBindList: ()=> BindBankList(),
//     userBindBankModify: ()=> UserBindBankModify(),
//     systemBankList: ()=> SystemBankList()

  /// 删除用户绑定列表
  Future<HttpResultContainer> deleteBindBank(int id) {
    return _onCommonRequest(AppRequest.bindBankDelete, {
      HttpPluginKey.BODY: {"id": id}
    });
  }

  /// 单个绑定银行卡信息
  Future<HttpResultContainer> bindBankInfo(String id) {
    return _onCommonRequest(AppRequest.bindBankInfo, {
      HttpPluginKey.BODY: {"id": id}
    });
  }

  /// 绑定银行卡列表
  Future<HttpResultContainer> bindBankList() {
    return _onCommonRequest(AppRequest.userBindList, {});
  }

  ///用户已绑定钱包列表
  Future<HttpResultContainer> bindWalletList() {
    return _onCommonRequest(AppRequest.bindWalletList, {});
  }

  ///绑定银行卡 bankId:银行ID accountOpenBank:开户支行 bankname:银行名称 cardNumber:卡号 name:收款人 ,remark:备注
  Future<HttpResultContainer> bindBankModify(
      {String? bankId,
      required String accountOpenBank,
      required String name,
      required String bankname,
      required String cardNumber,
      required String remark}) {
    return _onCommonRequest(AppRequest.userBindBankModify, {
      HttpPluginKey.BODY: {
        "accountOpenBank": accountOpenBank,
        "bankId": bankId,
        "bankName": bankname,
        "cardNumber": cardNumber,
        "name": name,
        "remark": remark
      }
    });
  }

  /// 获取银行卡列表
  Future<HttpResultContainer> systemBankList() {
    return _onCommonRequest(AppRequest.systemBankList, {});
  }

  /// 创建订单
  Future<HttpResultContainer> createOrder(
      {int paymentType: 0,
      required double orderPrice,
      required String channelName,
      String? bizId,
      Map<String, dynamic>? arguments}) {
    return _onCommonRequest(AppRequest.createOrder, {
      HttpPluginKey.BODY: {
        "orderPrice": orderPrice,
        "paymentType": paymentType,
        "channelName": channelName,
        "bizId": bizId
      }..addAll(arguments ?? {})
    });
  }

  /// 查询支付结果
  Future<HttpResultContainer> payNotify() {
    return _onCommonRequest(AppRequest.payNotify, {});
  }

  /// 获取验证码图片
  Future<HttpResultContainer> securityCodeImage(
      {required String account,
      required String uid,
      required String verifyCode}) {
    return _onCommonRequest(AppRequest.sendVerificationCode, {
      HttpPluginKey.BODY: {
        "account": account,
        "uuid": uid,
        "captcha": verifyCode
      }
    });
  }

  /// 忘记密码
  Future<HttpResultContainer> forgetPassword(
      {required String account,
      required String password,
      required String rePassword,
      required String code}) {
    return _onCommonRequest(AppRequest.forgetPassword, {
      HttpPluginKey.BODY: {
        "account": account,
        "code": code,
        "newPassword": password,
        "reNewPassword": rePassword
      }
    });
  }

  /// 等级
  Future<HttpResultContainer> gradeList() {
    return _onCommonRequest(AppRequest.gradeList, {});
  }

  /// 主播榜     富豪榜
  /// dateType： 排行类型 1=日榜 2=周榜 3=月榜  rankType 1=主播榜 2=土豪榜
  Future<HttpResultContainer> anchorRank(
      {required int page,
      required int dateType,
      required int rankType,
      int pageSize = _pageSize}) {
    return _onCommonRequest(AppRequest.anchorRank, {
      HttpPluginKey.BODY: {
        "pageNum": page,
        "pageSize": pageSize,
        "rankType": rankType,
        "dateType": dateType
      }
    });
  }

  /// 粉丝列表
  Future<HttpResultContainer> fansPage(String userId, int page,
      [int pageSize = _pageSize]) {
    return _onCommonRequest(AppRequest.fansPage, {
      HttpPluginKey.BODY: {
        "userId": userId,
        "pageNum": page,
        "pageSize": pageSize,
      }
    });
  }

  /// 主播端观众人数
  Future<HttpResultContainer> anchorOnlineNumber(String roomId) {
    return _onCommonRequest(AppRequest.anchorOnlineNumber, {
      HttpPluginKey.BODY: {"roomId": roomId}
    });
  }

  /// 添加状态
  /// (1:设为管理员 2:添加禁言)
  Future<HttpResultContainer> livingAddStatus(
      {required String anchorId, required String userId, required int state}) {
    return _onCommonRequest(AppRequest.livingAddStatus, {
      HttpPluginKey.BODY: {
        "anchorId": anchorId,
        "userId": userId,
        "addState": state
      }
    });
  }

  /// 取消状态
  /// (1:取消管理员 2:取消禁言)
  Future<HttpResultContainer> livingCancelStatus(
      {required String anchorId, required String userId, required int state}) {
    return _onCommonRequest(AppRequest.livingCancelStatus, {
      HttpPluginKey.BODY: {
        "anchorId": anchorId,
        "userId": userId,
        "cancelState": state
      }
    });
  }

  /// 系统参数
  Future<HttpResultContainer> systemParamList() {
    return _onCommonRequest(AppRequest.systemParamList, {});
  }

  /// 提现记录
  Future<HttpResultContainer> withdrawInfo(
      {required int page, int pageSize: _pageSize}) {
    return _onCommonRequest(AppRequest.withdrawInfo, {
      HttpPluginKey.BODY: {
        "pageNum": page,
        "pageSize": pageSize,
        // "timeType": timeType,
        // "bizid": id
      }
    });
  }

  /// 收支明细
  Future<HttpResultContainer> accountDetail(
      {required int page,
      int pageSize: _pageSize,
      required int type,
      required String startTime,
      required String endTime}) {
    return _onCommonRequest(AppRequest.accountDetail, {
      HttpPluginKey.BODY: {
        "pageNum": page,
        "pageSize": pageSize,
        "type": type,
        "startTime": startTime,
        "endTime": endTime,
      }
    });
  }

  /// 下注记录
  Future<HttpResultContainer> betRecord(
      {required int page, int pageSize: _pageSize, int? timeType}) {
    return _onCommonRequest(AppRequest.betRecord, {
      HttpPluginKey.BODY: {
        "pageNum": page,
        "pageSize": pageSize,
        "timeType": timeType
      }
    });
  }

  /// 充值记录
  Future<HttpResultContainer> chargeRecord(
      {required int page, int pageSize: _pageSize}) {
    return _onCommonRequest(AppRequest.chargeRecord, {
      HttpPluginKey.BODY: {
        "pageNum": page,
        "pageSize": pageSize,
      }
    });
  }

  /// 礼物报表
  Future<HttpResultContainer> giftFormReport(
      {required int page, int pageSize: _pageSize, int? timeType}) {
    return _onCommonRequest(AppRequest.giftFormReport, {
      HttpPluginKey.BODY: {
        "pageNum": page,
        "pageSize": pageSize,
        "timeType": timeType
      }
    });
  }

  /// 直播时段
  Future<HttpResultContainer> livingTimeSlot(
      {required int page, int pageSize: _pageSize, int? timeType}) {
    return _onCommonRequest(AppRequest.livingTimeSlot, {
      HttpPluginKey.BODY: {
        "pageNum": page,
        "pageSize": pageSize,
        "timeType": timeType
      }
    });
  }

  /// 修改登录密码
  Future<HttpResultContainer> modifyLogInPassword(
      {String? oldPassword,
      required String newPassword,
      required String confirmNewPassword}) {
    return _onCommonRequest(AppRequest.modifyLogInPassword, {
      HttpPluginKey.BODY: {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
        "reNewPassword": confirmNewPassword
      }
    });
  }

  /// 修改提现密码
  Future<HttpResultContainer> modifyWithdrawPassword(
      {String? oldPassword,
      required String newPassword,
      required String confirmNewPassword}) {
    return _onCommonRequest(AppRequest.modifyWithdrawPassword, {
      HttpPluginKey.BODY: {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
        "newPasswordConfirm": confirmNewPassword
      }
    })
      ..then((value) {
        value.finalize(wrapper: WrapperModel(), success: (_) {});
      });
  }

  /// 主播反馈意见
  Future<HttpResultContainer> anchorFeedback(String content) {
    return _onCommonRequest(AppRequest.anchorFeedback, {
      HttpPluginKey.BODY: {"adviceContent": content}
    });
  }

  /// 直播间排行榜
  Future<HttpResultContainer> contributionListInLiving(int page,
      {int pageSize: _pageSize, required String anchorId}) {
    return _onCommonRequest(AppRequest.contributionListInLiving, {
      HttpPluginKey.BODY: {
        "pageNum": page,
        "pageSize": pageSize,
        "anchorId": anchorId
      }
    });
  }

  /// 更新版本
  Future<HttpResultContainer> upgradeVersion({required String version}) {
    return _onCommonRequest(AppRequest.upgradeVersion, {
      HttpPluginKey.BODY: {
        "versionName": version,
        "platform": Platform.isIOS ? "ios" : "android"
      }
    });
  }

  /// 下载apk
  Future<HttpResultContainer> downloadApk(String url,
      {void Function(int count, int amount)? process,
      required String savePath,
      void Function(int? cancelToken)? cancelToken}) {
    return HttpMidBuffer.buffer.downloadWithParameter(
        AppRequest.appDownload, {HttpPluginKey.CUSTOMURL: url}, savePath,
        process: process, cancelToken: cancelToken);
  }

  /// firebase token 提交
  Future<HttpResultContainer> firebaseSubmit(String token) {
    return _onCommonRequest(AppRequest.firebaseSubmit, {
      HttpPluginKey.BODY: {"firebaseToken": token}
    });
  }

  /// 服务列表
  Future<HttpResultContainer> customServicesList() {
    return _onCommonRequest(
        AppRequest.customService,
        {
          HttpPluginKey.HEADER: {"token": httpToken()},
        },
        needToken: false);
  }

  /// 坐骑列表
  Future<HttpResultContainer> carList() {
    return _onCommonRequest(AppRequest.carList, {});
  }

  /// 购买坐骑
  /// （0=月卡 1=季卡 2=年卡）
  Future<HttpResultContainer> carBuy({required int id, required int type}) {
    return _onCommonRequest(AppRequest.buyCar, {
      HttpPluginKey.BODY: {"id": id, "carPriceState": type}
    });
  }

  Future<HttpResultContainer> sendGiftBag(
      int giftTag, String? roomId, int useGiftNum) {
    return _onCommonRequest(AppRequest.sendGiftBag, {
      HttpPluginKey.BODY: {
        "giftTag": giftTag,
        "roomId": roomId,
        "useGiftNum": useGiftNum
      }
    });
  }

  /// 使用坐骑
  Future<HttpResultContainer> useCar({required int id}) {
    return _onCommonRequest(AppRequest.useCar, {
      HttpPluginKey.BODY: {"id": id}
    });
  }

  /// app 活动
  Future<HttpResultContainer> appActivity() {
    return _onCommonRequest(AppRequest.appActivity, {});
  }

  /// 按类型搜索分类
  Future<HttpResultContainer> searchAnchorOnType(int type,
      {required int page, int pageSize = _pageSize}) {
    return _onCommonRequest(AppRequest.searchAnchorType, {
      HttpPluginKey.BODY: {
        "pageNum": page,
        "pageSize": pageSize,
        "anchorType": type
      }
    });
  }

  /// 系统字典
  Future<HttpResultContainer> systemDictionary() {
    return _onCommonRequest(
        AppRequest.systemDictionary,
        {
          HttpPluginKey.HEADER: {"token": httpToken()},
        },
        needToken: false);
  }

  /// 获取游戏URL
  Future<HttpResultContainer> gameRoomEnter() {
    return _onCommonRequest(AppRequest.gameRoomEnter, {});
  }

  /// 直播间投注 followBetInfo用于直播间跟投
  Future<HttpResultContainer> gameRoomBetting(
      String roomId,
      int gameId,
      String issueId,
      String userId,
      String gameName,
      List<Map<String, dynamic>> odds,
      String followBetInfo) {
    return _onCommonRequest(AppRequest.gameRoomBetting, {
      HttpPluginKey.BODY: {
        "roomId": roomId,
        "gameId": gameId,
        "issueId": issueId,
        "betInfo": odds,
        "userId": userId,
        "gameName": gameName,
        "followBetInfo": followBetInfo
      }
    });
  }

  //开通(续费)贵族
  Future<HttpResultContainer> nobleOpenOrRenew(int type, {int roomId = 0}) {
    return _onCommonRequest(AppRequest.nobleOpenOrRenew, {
      HttpPluginKey.BODY: {"type": type, "roomId": roomId}
    });
  }

  //获取用户贵族等级
  Future<HttpResultContainer> userNobleLevel() {
    return _onCommonRequest(AppRequest.getUserNobleLevel, {});
  }

  //提现方式列表
  Future<HttpResultContainer> withdrawList() {
    return _onCommonRequest(AppRequest.withdrawList, {});
  }

  //获取钱包类型列表
  Future<HttpResultContainer> walletTypes() {
    return _onCommonRequest(AppRequest.walletTypes, {});
  }

// 绑定钱包地址
  Future<HttpResultContainer> bindWalletAddress(
      String walletAddress, String withTypeNo) {
    return _onCommonRequest(AppRequest.bindWalletAddress, {
      HttpPluginKey.BODY: {
        "walletAddress": walletAddress,
        "withTypeNo": withTypeNo
      }
    });
  }

  ///用户提交提现申请
  Future<HttpResultContainer> createWithdrawOrder(
      {String? bankId,
      String? walletType,
      String? withdrawPassword,
      String? withdrawType,
      int? withdrawMoney}) {
    return _onCommonRequest(AppRequest.createWithdrawOrder, {
      HttpPluginKey.BODY: {
        "bankId": bankId,
        "walletType": walletType,
        "withdrawMoney": withdrawMoney,
        "withdrawPassword": withdrawPassword,
        "withdrawType": withdrawType,
      }
    });
  }

  ///修改提现密码
  Future<HttpResultContainer> setWithdrawPassword(
      {
      String? oldPassword,
      String? newPassword,
      String? newPasswordConfirm,
      String? phone,
      String? verifyCode}) {
    return _onCommonRequest(AppRequest.setWithdrawPassword, {
      HttpPluginKey.BODY: {
        "newPassword": newPassword,
        "newPasswordConfirm": newPasswordConfirm,
        "oldPassword": oldPassword,
        "phone": phone,
        "code": verifyCode
      }
    });
  }

  ///删除钱包
  Future<HttpResultContainer> deleteWallet(int id) {
    return _onCommonRequest(AppRequest.deleteWallet, {
      HttpPluginKey.BODY: {
        "id": id,
      }
    });
  }

  /**
   *     remainPoints: ()=> UserRemainingRewardPoint(),
      exchangeGift: ()=> PointExchangeGift(),
      exchangeRecord: ()=> UserExchangeRecord(),
      exchangeGiftList: ()=> ExchangeGiftList()
   */

  /// 用户剩余积分
  Future<HttpResultContainer> userRemainPoints() {
    return _onCommonRequest(AppRequest.remainPoints, {});
  }

  /// 兑换礼物
  Future<HttpResultContainer> exchangeGift(
      {required int count, required String giftId}) {
    return _onCommonRequest(AppRequest.exchangeGift, {
      HttpPluginKey.BODY: {"exchangeQuantity": count, "giftId": giftId}
    });
  }

  /// 兑换记录
  Future<HttpResultContainer> exchangeRecord(
      {required int page, int pageSize: _pageSize}) {
    return _onCommonRequest(AppRequest.exchangeRecord, {
      HttpPluginKey.BODY: {"pageNum": page, "pageSize": pageSize}
    });
  }

  /// 可兑换礼物列表
  Future<HttpResultContainer> exchangeGiftList(
      {required int page, int pageSize: _pageSize}) {
    return _onCommonRequest(AppRequest.exchangeGiftList, {
      HttpPluginKey.BODY: {"pageNum": page, "pageSize": pageSize}
    });
  }

  /// 用户背包
  Future<HttpResultContainer> userPackageList() {
    return _onCommonRequest(AppRequest.userPackageList, {});
  }

  /// 背包道具使用
  Future<HttpResultContainer> bagUseItem(
      {required int itemTag, int? useItemNum, String? userName}) {
    return _onCommonRequest(AppRequest.bagUseItem, {
      HttpPluginKey.BODY: {
        "itemTag": itemTag,
        "useItemNum": useItemNum,
        "userName": userName
      }
    });
  }

  /// 发送弹幕消息
  Future<HttpResultContainer> sendScreenMsg(
      int hornTag, String? message, String? roomId) {
    return _onCommonRequest(AppRequest.sendScreenMsg, {
      HttpPluginKey.BODY: {
        "hornTag": hornTag,
        "message": message,
        "roomId": roomId
      }
    });
  }

  /// 首页TAB
  Future<HttpResultContainer> cateGoryLabel() {
    return _onCommonRequest(AppRequest.categoryLabel, {});
  }

  /// 首页直播风云榜
  Future<HttpResultContainer> homeRankFirst() {
    return _onCommonRequest(AppRequest.rankFirst, {});
  }

  /// 搜索请求
  Future<HttpResultContainer> homeSearchInfo({required String userIdOrName}) {
    return _onCommonRequest(AppRequest.homeSearchInfo, {
      HttpPluginKey.BODY: {"userIdOrName": userIdOrName}
    });
  }

  /// 广告Banner图片
  /// （1:开机屏幕 2:首页弹框 3:首页广告位）
  Future<HttpResultContainer> advertiseBanner({required int advertiseType}) {
    return _onCommonRequest(AppRequest.advertiseBanner, {
      HttpPluginKey.BODY: {"advertiseType": advertiseType}
    });
  }

  /// 获取游戏列表
  Future<HttpResultContainer> homeGameList() {
    return _onCommonRequest(AppRequest.homeGameList, {});
  }

  /// 站内信、消息
  /// type: 1.公告 2.站内信
  Future<HttpResultContainer> announcementList(int type) {
    return _onCommonRequest(AppRequest.announcementList, {
      HttpPluginKey.BODY: {"type": type}
    });
  }

  /// 获取环信账户信息
  Future<HttpResultContainer> chatRoomAccount(bool force) {
    return _onCommonRequest(AppRequest.chatRoomAccount, {
      HttpPluginKey.BODY: {"force": force}
    });
  }

  /// 获取验证码
  Future<HttpResultContainer> smsSend(
      {required String phone, String? countryCode}) {
    return _onCommonRequest(AppRequest.smsSend, {
      HttpPluginKey.BODY: {
        "phone": phone,
        'countryCode': countryCode,
      }
    });
  }

  /// 绑定手机号
  Future<HttpResultContainer> bindPhone(
      {required String phone,
      required String verifyCode,
    }) {
    return _onCommonRequest(AppRequest.bindPhone, {
      HttpPluginKey.BODY: {
        "phone": phone,
        "code": verifyCode,
      }
    });
  }

  /// 切换直播间
  Future<HttpResultContainer> changeRoom() {
    return _onCommonRequest(AppRequest.changeRoom, {});
  }

  /// 用户贡献榜
  Future<HttpResultContainer> contribute(
      {required String userId, required int dateType}) {
    return _onCommonRequest(AppRequest.contribute, {
      HttpPluginKey.BODY: {
        "userId": userId,
        "dateType": dateType,
      }
    });
  }

  /// 三方游戏列表
  Future<HttpResultContainer> gameList() {
    return _onCommonRequest(AppRequest.gameList, {HttpPluginKey.BODY: {}});
  }

  /// 三方游戏记录
  Future<HttpResultContainer> gameRecordList({required int type}) {
    return _onCommonRequest(AppRequest.gameRecordList, {
      HttpPluginKey.BODY: {"type": type}
    });
  }

  /// 三方游戏注单
  Future<HttpResultContainer> gameBetRecordList(
      {required int pageNum, required String companyId, required int type}) {
    return _onCommonRequest(AppRequest.gameBetRecordList, {
      HttpPluginKey.BODY: {
        "pageNum": pageNum,
        "pageSize": _pageSize,
        "companyId": companyId,
        "type": type,
      }
    });
  }

  /// 三方游戏地址
  Future<HttpResultContainer> gameUrl({required String gameId}) {
    return _onCommonRequest(AppRequest.gameUrl, {
      HttpPluginKey.BODY: {
        // 'gameCompanyId': gameCompanyId,
        'gameId': gameId,
      }
    });
  }

  /// 三方游戏上分
  Future<HttpResultContainer> transferIn({required String gameId}) {
    return _onCommonRequest(AppRequest.gameTransferIn, {
      HttpPluginKey.BODY: {
        // 'gameCompanyId': gameCompanyId,
        'gameId': gameId,
      }
    });
  }

  /// 三方游戏下分
  Future<HttpResultContainer> transferInOut({required String gameId}) {
    return _onCommonRequest(AppRequest.gameTransferOut, {
      HttpPluginKey.BODY: {
        // 'gameCompanyId': gameCompanyId,
        'gameId': gameId,
      }
    });
  }

  /// 三方游戏记录
  Future<HttpResultContainer> purseChannel() {
    return _onCommonRequest(AppRequest.purseChannel, {});
  }

  /// 客服列表
  Future<HttpResultContainer> customerServiceList() {
    return _onCommonRequest(AppRequest.customerServiceList, {});
  }

  //用户账户余额
  Future<HttpResultContainer> queryUserBalance() {
    return _onCommonRequest(AppRequest.queryUserBalance, {});
  }

// //用户提交提现申请
//   Future<HttpResultContainer> createWithdrawOrder(
//       {String? bankId,
//       String? withdrawMoney,
//       String? withdrawPassword,
//       String withdrawType = "bankPay"}) {
//     return _onCommonRequest(AppRequest.createWithdrawOrder, {
//       HttpPluginKey.BODY: {
//         "bankId": bankId,
//         "withdrawMoney": withdrawMoney,
//         "withdrawType": withdrawType,
//         "withdrawPassword": withdrawPassword,
//       }
//     });
//   }

  //用户账户余额
  Future<HttpResultContainer> queryChannelList() {
    return _onCommonRequest(AppRequest.queryChannelList, {});
  }

  Future<HttpResultContainer> createRechargeOrder(
      String channelId, String rechargeMoney) {
    return _onCommonRequest(AppRequest.createRechargeOrder, {
      HttpPluginKey.BODY: {
        "channelId": channelId,
        "rechargeMoney": rechargeMoney,
      }
    });
  }

  Future<HttpResultContainer> queryRechargeByOrderNo(String orderNo) {
    return _onCommonRequest(AppRequest.queryRechargeByOrderNo, {
      HttpPluginKey.BODY: {
        "orderNo": orderNo,
      }
    });
  }

  /// 兑换钻石套餐列表
  Future<HttpResultContainer> diamondList() {
    return _onCommonRequest(AppRequest.diamondList, {});
  }

  /// 余额兑换钻石
  Future<HttpResultContainer> diamondExchange(int packageId) {
    return _onCommonRequest(AppRequest.diamondExchange, {
      HttpPluginKey.BODY: {
        "packageId": packageId,
      }
    });
  }

  /// 获取账户余额以及钻石余额
  Future<HttpResultContainer> userBalance() {
    return _onCommonRequest(AppRequest.userBalance, {});
  }

  /// 直播间：守护列表
  Future<HttpResultContainer> getLiveRoomWatchList(String roomId) {
    return _onCommonRequest(AppRequest.getLiveRoomWatchList, {
      HttpPluginKey.BODY: {
        "roomId": roomId,
      }
    });
  }

  //主播端-主播收礼明细
  Future<HttpResultContainer> getGiftList(int pageNum) {
    return _onCommonRequest(AppRequest.getGiftList, {
      HttpPluginKey.BODY: {
        "pageNum": pageNum,
        "pageSize": _pageSize,
      }
    });
  }

  /// 开通(续费)守护
  Future<HttpResultContainer> openOrRenew(String roomId, int type) {
    return _onCommonRequest(AppRequest.openOrRenew, {
      HttpPluginKey.BODY: {
        "roomId": roomId,
        "type": type,
      }
    });
  }

  Future<HttpResultContainer> getNameCard(String roomId) {
    return _onCommonRequest(AppRequest.nameCard, {
      HttpPluginKey.BODY: {
        "roomId": roomId,
      }
    });
  }

  /// 系统消息列表
  Future<HttpResultContainer> messageSystemList({
    required int pageNum,
  }) {
    return _onCommonRequest(AppRequest.messageSystemList, {
      HttpPluginKey.BODY: {
        "pageNum": pageNum,
        "pageSize": _pageSize,
      }
    });
  }

  /// 未读消息数
  Future<HttpResultContainer> messageUnreadNum() {
    return _onCommonRequest(AppRequest.messageUnreadNum, {});
  }

  /// 阅读消息
  Future<HttpResultContainer> messageRead() {
    return _onCommonRequest(AppRequest.messageRead, {});
  }

  /// 修改昵称
  Future<HttpResultContainer> updateUsername({
    required String username,
  }) {
    return _onCommonRequest(AppRequest.updateUsername, {
      HttpPluginKey.BODY: {
        "username": username,
      }
    });
  }

  //主播登陆
  Future<HttpResultContainer> anchorLogin(String phone, String password,
      {String? type}) {
    return _onCommonRequest(
        AppRequest.anchorLogin,
        {
          HttpPluginKey.BODY: {
            "phone": phone,
            "device": 1,
            "password": password,
          }
        },
        needToken: false);
  }

  //直播间添加禁言
  Future<HttpResultContainer> liveRoomBanspeak(String userId) {
    return _onCommonRequest(AppRequest.liveRoomBanspeak, {
      HttpPluginKey.BODY: {
        "roomId": StorageService.to.getString("roomId"),
        "userId": userId
      }
    });
  }

  ///直播间取消禁言
  Future<HttpResultContainer> liveRoomBanspeakDelete(String id) {
    return _onCommonRequest(AppRequest.liveRoomBanspeakDelete, {
      HttpPluginKey.BODY: {"id": id}
    });
  }

  ///直播间禁言列表
  Future<HttpResultContainer> liveRoomBanspeakList(String roomId, int page,
      {int pageSize = _pageSize}) {
    return _onCommonRequest(AppRequest.liveRoomBanspeakList, {
      HttpPluginKey.BODY: {
        "pageNum": page,
        "pageSize": pageSize,
        "roomId": roomId
      }
    });
  }

  //直播间添加管理员
  Future<HttpResultContainer> liveRoomManagerAdd(String userId) {
    return _onCommonRequest(AppRequest.liveRoomManagerAdd, {
      HttpPluginKey.BODY: {
        "roomId": StorageService.to.getString("roomId"),
        "userId": userId
      }
    });
  }

  ///直播间取消管理员
  Future<HttpResultContainer> liveRoomManagerDelete(String userId) {
    return _onCommonRequest(AppRequest.liveRoomManagerDelete, {
      HttpPluginKey.BODY: {"userId": userId}
    });
  }

  ///直播间管理员列表
  Future<HttpResultContainer> liveRoomManagerList(String roomId, int page,
      {int pageSize = _pageSize}) {
    return _onCommonRequest(AppRequest.liveRoomManagerList, {
      HttpPluginKey.BODY: {
        "pageNum": page,
        "pageSize": pageSize,
        "roomId": roomId
      }
    });
  }

  ///主播端个人中心礼物报表
  Future<HttpResultContainer> giftFrom(
    int timeType,
    int page, {
    int pageSize = _pageSize,
    String? startTime,
    String? endTime,
  }) {
    return _onCommonRequest(AppRequest.giftForm, {
      HttpPluginKey.BODY: {
        "pageNum": page,
        "pageSize": pageSize,
        "timeType": timeType,
        "startTime": startTime,
        "endTime": endTime,
      }
    });
  }

  ///主播端个人中心直播时段
  Future<HttpResultContainer> periodList(
    int timeType,
    int page, {
    int pageSize = _pageSize,
    String? startTime,
    String? endTime,
  }) {
    return _onCommonRequest(AppRequest.periodList, {
      HttpPluginKey.BODY: {
        "pageNum": page,
        "pageSize": pageSize,
        "timeType": timeType,
        "startTime": startTime,
        "endTime": endTime,
      }
    });
  }

  ///主播端个人中心收益明细
  Future<HttpResultContainer> incomeList(
    int timeType,
    int page, {
    int pageSize = _pageSize,
    String? startTime,
    String? endTime,
  }) {
    return _onCommonRequest(AppRequest.incomeList, {
      HttpPluginKey.BODY: {
        "pageNum": page,
        "pageSize": pageSize,
        "timeType": timeType,
        "startTime": startTime,
        "endTime": endTime,
      }
    });
  }

  ///直播结束，查看本次开播数据
  Future<HttpResultContainer> periodDetail() {
    return _onCommonRequest(AppRequest.periodDetail, {});
  }

  ///获取用户守护等级
  Future<HttpResultContainer> getLiveRoomWatchUser(String roomId) {
    return _onCommonRequest(AppRequest.getLiveRoomWatchUser, {
      HttpPluginKey.BODY: {"roomId": roomId}
    });
  }

  ///主播开始收费
  Future<HttpResultContainer> beginCharging(String amount, int type) {
    return _onCommonRequest(AppRequest.beginCharging, {
      HttpPluginKey.BODY: {"amount": amount, "type": type}
    });
  }

  ///主播暂停或开始直播
  Future<HttpResultContainer> pauseRoom(String roomId, int state) {
    return _onCommonRequest(AppRequest.pauseRoom, {
      HttpPluginKey.BODY: {"roomId": roomId, "state": state}
    });
  }

  ///主播开启画面镜像功能
  Future<HttpResultContainer> liveRoomMirror(String roomId, int open) {
    return _onCommonRequest(AppRequest.liveRoomMirror, {
      HttpPluginKey.BODY: {"roomId": roomId, "open": open}
    });
  }

  ///主播端提现记录
  Future<HttpResultContainer> anchorWithdrawList(
    int timeType,
    int page, {
    int pageSize = _pageSize,
    String? startTime,
    String? endTime,
  }) {
    return _onCommonRequest(AppRequest.anchorWithdrawList, {
      HttpPluginKey.BODY: {
        "pageNum": page,
        "pageSize": pageSize,
        "timeType": timeType,
        "startTime": startTime,
        "endTime": endTime,
      }
    });
  }

  /// 观众-确认付费观看
  Future<HttpResultContainer> liveRoomPayWatch() {
    return _onCommonRequest(AppRequest.liveRoomPayWatch, {
      HttpPluginKey.BODY: {"roomId": StorageService.to.getString("roomId")}
    });
  }

  /// 主播端分享链接
  Future<HttpResultContainer> getShareUrl(int deviceType) {
    return _onCommonRequest(AppRequest.getShareUrl, {
      HttpPluginKey.BODY: {"deviceType": deviceType}
    });
  }

  /// 主播端分享链接
  Future<HttpResultContainer> checkVersion() {
    return _onCommonRequest(AppRequest.checkVersion, {});
  }

  /// 主播端分享链接
  Future<HttpResultContainer> userInfoReport() {
    return _onCommonRequest(AppRequest.userInfoReport, {});
  }

  /// 系统配置接口
  Future<HttpResultContainer> configInfo() {
    return _onCommonRequest(AppRequest.configInfo, {});
  }

  /// 域名获取
  Future<HttpResultContainer> domainList() {
    return _onCommonRequest(AppRequest.domainList, {
      HttpPluginKey.BODY: {
        "version": StorageService.to.getString("DOMAIN_VERSION")
      }
    });
  }

  /// 获取验证码
  Future<HttpResultContainer> getCode({required String phone}) {
    return _onCommonRequest(AppRequest.getCode, {
      HttpPluginKey.BODY: {"phone": phone}
    });
  }
}

// 分页数
const int _pageSize = 10;
