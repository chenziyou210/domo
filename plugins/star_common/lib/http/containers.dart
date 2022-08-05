/*
 *  Copyright (C), 2015-2021
 *  FileName: containers
 *  Author: Tonight丶相拥
 *  Date: 2021/3/11
 *  Description: 
 **/

import 'package:httpplugin/httpplugin.dart' show HttpTickContainer;
import 'package:url_launcher/link.dart';
import 'request.dart';

class AppRequest {
  /// 微信获取token
  static const String userWeChatAccessToken = "oauth2/access_token";

  static const String heartBeat = "live_room/anchor_heartbeat";

  /// 那主播类型搜索
  static const String searchAnchorType = "anchor/showPageByAnchorType";

  /// 系统字典
  static const String systemDictionary = "system/sysDictionaryList.no";

  // 注册
  static const String registered = "index/registered";

  // 登录
  static const String logIn = "index/login";

  // 游客登录
  static const String guestlogIn = "index/guestLogin";

  // // 获取token
  // static const String liveToken = "token/getToken";

  // 上传文件
  static const String uploadImage = "data/image";

  // 用户信息
  static const String userInfo = "myCenter/Info";

  // 用户信息编辑
  static const String editUserInfo = "info/edit";

  // 设置信息
  static const String settingInfo = "myCenter/settingInfo";

  // 更新设置
  static const String settingUpdate = "settingInfo/update";

  // 黑名单
  static const String blackList = "settingInfo/showBlackList";

  // 删除黑名单
  static const String deleteBlackList = "settingInfo/deleteBlackList";

  // 加入黑名单
  static const String insertBlackList = "settingInfo/insertBlackList";

  /// 我的关注
  static const String favoritePaging = "follow/list";

  /// 添加关注
  static const String favoriteInsert = "myAttention/insert";

  /// 取消关注
  static const String favoriteDelete = "myAttention/delete";

  /// 退出登录
  static const String logOut = "app/logout";

  /// firebase 上传
  static const String firebaseSubmit = "userfirebasetoken/save";

  /// 主播列表
  static const String anchorList = "index/showAnchorByLable";

  /// 关注主播列表
  static const String followAnchorList = "api/app/liveRoom/followAnchor";

  /// 创建普通直播间
  static const String createCommonRoom = "MLVBLiveRoom/createCommonRoom";

  // ///  创建游戏直播间
  // static const String createGameRoom = "MLVBLiveRoom/createGameRoom";
  //
  // /// 创建门票房间
  // static const String createTickerAmountRoom = "MLVBLiveRoom/createTicketAmountRoom";
  //
  // /// 创建计时房间
  // static const String createTimeDeductionRoom = "MLVBLiveRoom/createTimeDeductionRoom";
  //
  // /// 创建密码房间
  // static const String createPasswordRoom = "MLVBLiveRoom/createPassWordRoom";

  // /// 主播退出直播间
  // static const String anchorExitRoom = "MLVBLiveRoom/deleteAnchor";

  /// 销毁直播间
  static const String destroyRoom = "MLVBLiveRoom/destroyRoom";
  static const String checkRecharge = "MLVBLiveRoom/checkRecharge";

  /// 刷礼物
  static const String brushGift = "LiveingRoom/brushGift";

  /// 观众退出直播间
  static const String audienceExitRoom = "LiveingRoom/deleteAudience";

  // /// 退出并关注
  // static const String audienceExitAndAttention = "LiveingRoom/deleteAudienceAndAttiontion";

  // /// 获取直播间关键人数
  // static const String audienceCount = "LiveingRoom/getAudiences";

  /// 日排行榜
  static const String liveRoomRank = "getLiveRoomRank/daily";
  //
  // /// 月排行榜
  // static const String monthRank = "getLiveRoomRank/month";
  //
  // /// 周排行
  // static const String weekRank = "getLiveRoomRank/week";

  ///其他用户 -> 获取用户信息
  static const String getUserInfo = "LiveingRoom/getUserInfo";
  /// 直播间点击头像获取用户信息(精简接口是包含直播间底部用户信息弹框内容)
  static const String getLiveRoomUserInfo = "user/getLiveRoomUserInfo";
  static const String getNobelHideStatus = "noble/getSpecialProperties";
  static const String setNobelHideStatus = "noble/setNobelHideStatus";

  static const String getRewardInfo = "recharge/reward";

  /// 获取直播间礼物列表
  static const String roomGiftList = "LiveingRoom/gitLiveRoomGift";

  /// 进入直播间成为观众
  static const String addAudience = "index/addAudience";

  /// 获取附近主播
  static const String nearAnchor = "geo/near";

  /// 上传地理位置
  static const String locationSave = "geo/sava";
  // /// 获取房间信息
  // static const String getAnchors = "index/getAnchors";
  // /// 首页-日排行榜
  // static const String indexDailyRank = "getIndexRank/daily";
  // /// 首页-月排行榜
  // static const String indexMonthRank = "getIndexRank/month";
  /// 首页-周排行榜
  static const String indexRank = "getIndexRank/week";

  /// 直播间信息
  static const String liveRoomInfo = "liveRoom/getLiveRoomInfo";

  /// 首页banner
  static const String banner = "global/showAdvertise";

  /// 首页搜索
  static const String homeSearch = "index/recommend";

  // /// 获取其他人信息
  // static const String getUserById = "LiveingRoom/getAnchorHomePageInfo";

  /// 主播贡献榜
  static const String anchorContributionList =
      "LiveingRoom/getAnchorContributionList";

  /// 砖石充值页面
  static const String showConsPage = "MoneyrRelated/showConsPage";

  /// 砖石充值
  static const String chargeDiamond = "showConsPage/recharge";

  /// 余额充值
  static const String balanceRecharge = "MoneyrRelated/balanceRecharge";

  /// 主播标签
  static const String anchorLabel = "MLVBLiveRoom/selectAnchorLable";

  /// 直播间进入验证
  static const String liveRoomVerify = "MLVBLiveRoom/addAudience";

  /// 计时性直播间
  static const String timerLiveRoom =
      "LiveingRoom/timeDeductionRoomToDeductionTo";

  /// 直播间禁言
  static const String banSpeak = "banSpeak/add";

  /// 取消禁言
  static const String deleteBanSpeak = "banSpeak/delete";

  /// 禁言列表
  static const String banSpeakList = "banSpeak/list";

  /// 系统参数列表
  static const String systemParameter = "system/sysParamMap";

  /// 提现
  static const String withdraw = "moneyrRelated/moneyWithdraw";

  /// 下注
  static const String bet = "game/bottomPour";

  /// 游戏配置
  static const String gameConfig = "game/getGameConfig";

  /// 进入直播间拉取游戏
  static const String runtimeGame = "game/getRuntimeGame";

  /// 直播间推荐
  static const String livingRoomRecommend = "liveingRoom/recommend";

  /// 观众人数
  static const String audienceNumber = "liveingRoom/audienceNumber";

  /// 开奖记录
  static const String lotteryLog = "game/getLotteryLog";

  /// 下注记录
  static const String betLog = "game/getBottomPourLog";

  /// 银行展示
  static const String showBank = "moneyrRelated/showBank.no";

  /// 删除绑定银行卡
  static const String bindBankDelete = "userbindbank/delete";

  /// 单挑绑定银行卡信息
  static const String bindBankInfo = "userbindbank/info";

  /// 用户已绑定列表
  static const String userBindList = "user/bindbank/list";

  ///用户已绑定钱包列表
  static const bindWalletList = "api/app/user/bindWallet/list";

  /// 银行卡信息修改
  static const String userBindBankModify = "user/bindBank/saveOrUpdate";

  /// 系统支持银行卡列表
  static const String systemBankList = "bindBank/sysBankList";

  /// 创建订单
  static const String createOrder = "orderpayment/createOrder";

  /// 支付结果
  static const String payNotify = "orderpayment/payNotifyUrl.no";

  /// 新提现接口
  static const String createWithdrawOrder = "userwithdraw/createWithdrawOrder";

  /// 发送验证码
  static const String sendVerificationCode = "enter/code.no";

  /// 忘记密码
  static const String forgetPassword = "enter/forgetPassword.no";

  /// 等级列表
  static const String gradeList = "level/info";

  /// 富豪榜
  static const String userGiftRank = "rank/user";

  /// 主播榜
  static const String anchorRank = "rank/anchor";

  /// 粉丝列表
  static const String fansPage = "follow/fanList";

  /// 主播端：在线人数
  static const String anchorOnlineNumber = "anchor/anchorNumber";

  /// 取消状态
  static const String livingCancelStatus = "anchor/cancelAnchorAdmin";

  /// 添加状态
  static const String livingAddStatus = "anchor/addAnchorAdmin";

  /// 系统参数列表
  static const String systemParamList = "system/sysParamList";

  /// 提现记录
  static const String withdrawInfo = "withdraw/record/list";

  /// 收支明细
  static const String accountDetail = "coinFlow/recordList";

  /// 下注记录
  static const String betRecord = "gamebottompourlog/list";

  /// 充值记录
  static const String chargeRecord = "recharge/record/list";

  /// 礼物报表
  static const String giftFormReport = "giftsend/giftForm";

  ///  直播时段
  static const String livingTimeSlot = "anchor/getLiveTime";

  /// 修改提现密码
  static const String modifyWithdrawPassword = "user/setWithdrawPassword";

  /// 修改支付密码
  static const String modifyLogInPassword = "user/updeteLoginPassword";

  /// 主播反馈
  static const String anchorFeedback = "anchoradvice/save";

  /// 直播间贡献榜
  static const String contributionListInLiving = "anchor/ContributionList";

  /// 更新版本信息
  static const String upgradeVersion = "appversion/list";

  /// app 下载
  static const String appDownload = "app/download";

  /// 客服列表
  static const String customService = "customerservice/list.no";

  /// 使用坐骑
  static const String useCar = "car/use";

  /// 坐骑列表
  static const String carList = "car/carList";

  /// 购买坐骑
  static const String buyCar = "car/buyCar";
  static const String sendGiftBag = "sendGiftBag";

  /// app 活动
  static const String appActivity = "appactivity/list";

  /// 查询可积分兑换的礼物列表
  static const String exchangeGiftList = "bagpack/listExchangeGift";

  /// 兑换记录
  static const String exchangeRecord = "exchange/listUserExchangeRecord";

  /// 积分兑换礼物
  static const String exchangeGift = "exchange/exchangeGift";

  /// 用户背包礼物
  static const String userPackageList = "bag/getUserBagList";

  /// 用户背包道具使用
  static const String bagUseItem = "bag/useItem";

  /// 发送弹幕
  static const String sendScreenMsg = "liveRoom/sendScreenMessage";

  /// 查询剩余可用积分
  static const String remainPoints = "account/getUserRemainingRewardPoint";

  /// 分类和标签接口
  static const String categoryLabel = "liveRoom/categoryLabel";

  /// 首页Banner
  static const String advertiseBanner = "advertise/showAdvertise";

  /// 首页风云榜
  static const String rankFirst = "giftsend/rank/first";

  /// 站内信、消息
  static const String announcementList = "announcement/list";

  /// 游戏列表
  static const String homeGameList = "liveRoom/game/list";

  /// 搜索
  static const String homeSearchInfo = "home/search";

  /// 关注列表
  static const String followList = "user/info";

  /// IM信息
  static const String chatRoomAccount = "user/chatRoomAccount";

  /// 获取验证码
  static const String smsSend = "captcha/sms/send";

  /// 绑定手机号
  static const String bindPhone = "user/bindPhone";

  /// 切换直播间
  static const String changeRoom = "change/room";

  /// 用户贡献榜
  static const String contribute = "rank/contribute";

  /// 三方游戏列表
  static const String gameList = "game/gameList";

  /// 三方游戏记录
  static const String gameRecordList = "game/gameRecordList";

  /// 三方游戏链接地址
  static const String gameUrl = "game/getGameUrl";

  /// 三方游戏下分
  static const String gameTransferIn = "game/transfer/in";

  /// 三方游戏上分
  static const String gameTransferOut = "game/transfer/out";

  /// 三方游戏注单
  static const String gameBetRecordList = "game/getBetRecordList";

  /// 获取游戏URL
  static const String gameRoomEnter = "api/app/liveRoom/game/enter";

  ///投注
  static const String gameRoomBetting = "api/app/liveRoom/game/bet";

  /// 钻石兑换列表
  static const String purseChannel = "/api/app/pursechannel/list";

  /// 兑换钻石套餐列表
  static const String diamondList = "diamond/package/list";

  /// 余额兑换钻石
  static const String diamondExchange = "diamond/exchange";

  /// 获取账户余额以及钻石余额
  static const String userBalance = "user/balance";

  /// 守护列表
  static const String getLiveRoomWatchList = "room/getLiveRoomWatchList";
  static const String getGiftList = "room/getGiftList";

  /// 守护列表
  static const String openOrRenew = "watch/openOrRenew";

  /// 开通(续费)守护
  static const String customerServiceList = "customer/service/list";

  /// 用户账户余额
  static const String queryUserBalance = "/api/app/withdraw/queryUserBalance";
//用户提交提现申请
  static const String saveOrUpdate = "/api/app/userwithdraw/saveOrUpdate";

  // 支付通道
  static const String queryChannelList = "/api/app/recharge/queryChannelList";
//生成充值订单
  static const String createRechargeOrder =
      "/api/app/recharge/createRechargeOrder";
  // 查询订单
  static const String queryRechargeByOrderNo =
      "/api/app/recharge/queryRechargeByOrderNo";

  ///开通(续费)贵族
  static const String nobleOpenOrRenew = "/api/live/room/noble/openOrRenew";

  ///获取用户贵族等级
  static const String getUserNobleLevel =
      "/api/live/room/noble/getUserNobleLevel";

  ///提现方式列表
  static const String withdrawList = "/api/app/withdraw/queryTypeList";

  ///获取钱包类型列表
  static const String walletTypes = "/api/app/user/wallet/typeList";

  ///绑定钱包地址
  static const String bindWalletAddress = "/api/app/user/bindWalletAddress";

  ///我的 : 修改提现密码
  static const String setWithdrawPassword = "/api/app/user/setWithdrawPassword";

  ///删除钱包
  static const String deleteWallet = "/api/app/user/bindWallet/delete";

  ///系统消息
  static const String messageSystemList = "/api/app/message/list";
  static const String nameCard = "/api/live/room/getNameCard";

  ///未读消息数
  static const String messageUnreadNum = "/api/app/message/getUnreadNum";

  ///阅读消息
  static const String messageRead = "/api/app/message/read";

  ///修改昵称
  static const String updateUsername = "/api/app/user/updateUsername";

  //主播登录
  static const String anchorLogin = "enter/anchor/login";

  /// 直播间：添加禁言
  static const String liveRoomBanspeak = "/api/app/liveroombanspeak/add";
  ////// 直播间：取消禁言
  static const String liveRoomBanspeakDelete =
      "api/app/liveroombanspeak/delete";

  ///直播间：禁言列表
  static const String liveRoomBanspeakList = "api/app/liveroombanspeak/list";

  /// 直播间：添加管理员
  static const String liveRoomManagerAdd = "liveroom/manager/add";
  ////// 直播间：取消管理员
  static const String liveRoomManagerDelete = "liveroom/manager/delete";

  ///直播间：管理员列表
  static const String liveRoomManagerList = "liveroom/manager/list";

  /// 主播端/个人中心/礼物报表
  static const String giftForm = "/api/app/giftsend/giftForm";

  /// 主播端/个人中心/直播时段
  static const String periodList = "/api/app/liveRoom/period/list";

  /// 主播端/个人中心/收益明细
  static const String incomeList = "/api/app/liveRoom/income/list";

  /// 查看本次开播数据
  static const String periodDetail = "period/detail";

  /// 获取用户守护等级
  static const String getLiveRoomWatchUser = "watch/getLiveRoomWatchUser";

  /// 主播开始收费
  static const String beginCharging = "liveRoom/beginCharging";

  /// 主播端暂停
  static const String pauseRoom = "liveRoom/pauseRoom";

  /// 主播端镜像功能
  static const String liveRoomMirror = "liveRoom/mirror";

  /// 主播端提现记录
  static const String anchorWithdrawList = "/api/app/user/anchor/withdraw/list";

  /// 观众-确认付费观看
  static const String liveRoomPayWatch = "liveRoom/payWatch";

  /// 观众-确认付费观看
  static const String getShareUrl = "share/getShareUrl";

  /// 版本检查
  static const String checkVersion = "/api/app/version/list";

  /// 系统参数配置
  static const String configInfo = "config/info";

  /// 用户日活信息上报
  static const String userInfoReport = "/api/app/userInfoReport/save";

  /// 域名获取
  static const String domainList = "/api/domain/list";

  /// 获取验证码
  static const String getCode = "captcha/get/code";

  /// 所有请求
  static Map<String, HttpTickContainer Function()> request = {
    guestlogIn: () => GuestLogin(),
    userWeChatAccessToken: () => WeChatAuth(),
    registered: () => Register(),
    logIn: () => Login(),
    // liveToken: ()=> LiveToken(),
    uploadImage: () => UploadImage(),
    userInfo: () => UserInfo(),
    editUserInfo: () => EditUserInfo(),
    settingInfo: () => SettingInfo(),
    settingUpdate: () => SettingUpdate(),
    blackList: () => BlackList(),
    deleteBlackList: () => DeleteBlackList(),
    insertBlackList: () => InsertBlackList(),
    favoritePaging: () => FavoritePaging(),
    favoriteInsert: () => FavoriteInsert(),
    favoriteDelete: () => FavoriteDelete(),
    logOut: () => LogOut(),
    anchorList: () => AnchorList(),
    createCommonRoom: () => CreateLiveRoom(),
    // createGameRoom: ()=> CreateGameRoom(),
    // createTickerAmountRoom: ()=> CreateTicketAmountRoom(),
    // createTimeDeductionRoom: ()=> CreateTimeDeductionRoom(),
    // anchorExitRoom: ()=> AnchorExitRoom(),
    destroyRoom: () => DestroyRoom(),
    checkRecharge: () => CheckRecharge(),
    brushGift: () => BrushGift(),
    audienceExitRoom: () => AudienceExitRoom(),
    // audienceExitAndAttention: ()=> AudienceExitAndAttention(),
    // audienceCount: ()=> AudienceCount(),
    liveRoomRank: () => LiveRoomRank(),
    // monthRank: ()=> MonthRank(),
    // weekRank: ()=> WeekRank(),
    getUserInfo: () => GetUserInfo(),
    getRewardInfo: () => GetAward(),
    roomGiftList: () => GetRoomGiftList(),
    addAudience: () => AddAudience(),
    nearAnchor: () => NearAnchor(),
    locationSave: () => LocationSave(),
    // getAnchors: () => GetAnchor(),
    // indexDailyRank: () => IndexDailyRank(),
    // indexMonthRank: () => IndexMonthRank(),
    indexRank: () => IndexRank(),
    heartBeat: () => TencentHeartBeat(),
    // createPasswordRoom: ()=> CreatePasswordRoom(),
    banner: () => HomeBanner(),
    liveRoomInfo: () => LiveRoomInfo(),
    // homeSearch: ()=> HomeSearch(),
    // getUserById: () => UserInfoById(),
    anchorContributionList: () => AnchorContributionList(),
    showConsPage: () => ShowConsPage(),
    chargeDiamond: () => ChargeDiamond(),
    balanceRecharge: () => BalanceRecharge(),
    anchorLabel: () => AnchorLabel(),
    liveRoomVerify: () => VerifyRoom(),
    timerLiveRoom: () => TimerLiveRoom(),
    banSpeak: () => BanSpeak(),
    deleteBanSpeak: () => DeleteBanSpeak(),
    banSpeakList: () => BanSpeakList(),
    systemParameter: () => SystemParameterList(),
    withdraw: () => Withdraw(),
    getNobelHideStatus: () => GetNobelHideStatus(),
    setNobelHideStatus: () => SetNobelHideStatus(),
    bet: () => Bet(),
    gameConfig: () => GameConfig(),
    runtimeGame: () => RuntimeGame(),
    audienceNumber: () => AudienceNumber(),
    livingRoomRecommend: () => LivingRoomRecommend(),
    lotteryLog: () => LotteryLog(),
    betLog: () => BetLog(),
    showBank: () => ShowBank(),
    bindBankDelete: () => DeleteBankCard(),
    bindBankInfo: () => UserBindBankInfo(),
    userBindList: () => BindBankList(),
    userBindBankModify: () => UserBindBankModify(),
    systemBankList: () => SystemBankList(),
    createOrder: () => CreateOrder(),
    payNotify: () => PayNotifyUrl(),
    // withdrawNew: () => WithdrawNew(),
    sendVerificationCode: () => SendVerificationCode(),
    forgetPassword: () => ForgetPassword(),
    gradeList: () => GradeList(),
    anchorRank: () => AnchorRank(),
    fansPage: () => FansPage(),
    anchorOnlineNumber: () => AnchorOnlineNumber(),
    livingAddStatus: () => LivingAddStatus(),
    livingCancelStatus: () => LivingCancelStatus(),
    systemParamList: () => SysParamMap(),
    withdrawInfo: () => WithdrawInfo(),
    accountDetail: () => AccountDetail(),
    betRecord: () => BetRecord(),
    chargeRecord: () => ChargeRecord(),
    giftFormReport: () => AnchorGiftFormReport(),
    livingTimeSlot: () => LivingTimeSlot(),
    modifyLogInPassword: () => ModifyLogInPassword(),
    modifyWithdrawPassword: () => ModifyWithdrawPassword(),
    anchorFeedback: () => AnchorFeedback(),
    contributionListInLiving: () => ContributionListInLiving(),
    upgradeVersion: () => UpgradeVersion(),
    appDownload: () => AppDownload(),
    firebaseSubmit: () => FireBaseTokenSubmit(),
    customService: () => CustomServicesList(),
    useCar: () => UseCar(),
    carList: () => CarList(),
    buyCar: () => CarBuy(),
    sendGiftBag: () => SendGiftBag(),
    appActivity: () => AppActivity(),
    searchAnchorType: () => SearchAnchorOnType(),
    systemDictionary: () => SystemDictionary(),
    remainPoints: () => UserRemainingRewardPoint(),
    exchangeGift: () => PointExchangeGift(),
    exchangeRecord: () => UserExchangeRecord(),
    exchangeGiftList: () => ExchangeGiftList(),
    userPackageList: () => UserPackageList(),
    homeGameList: () => HomeGameList(),
    homeSearchInfo: () => HomeSearchInfo(),
    categoryLabel: () => CateGoryLabel(),
    followAnchorList: () => FollowAnchorListLabel(),
    advertiseBanner: () => AdvertiseBanner(),
    rankFirst: () => HomeRankFirst(),
    announcementList: () => AnnouncementList(),
    followList: () => FollowList(),
    chatRoomAccount: () => ChatRoomAccount(),
    smsSend: () => SmsSend(),
    bindPhone: () => BindPhone(),
    changeRoom: () => ChangeRoom(),
    contribute: () => Contribute(),
    gameList: () => GameList(),
    gameUrl: () => GameUrl(),
    gameTransferIn: () => GameTransferIn(),
    gameTransferOut: () => GameTransferOut(),
    gameRecordList: () => GameRecordList(),
    gameBetRecordList: () => GameBetRecordList(),
    gameRoomEnter: () => GameRoomEnter(),
    gameRoomBetting: () => GameRoomBetting(),
    purseChannel: () => PurseChannel(),
    queryUserBalance: () => QueryUserBalance(),
    createWithdrawOrder: () => CreateWithdrawOrder(),
    queryChannelList: () => QueryChannelList(),
    createRechargeOrder: () => CreateRechargeOrder(),
    queryRechargeByOrderNo: () => QueryRechargeByOrderNo(),
    diamondList: () => DiamondList(),
    diamondExchange: () => DiamondExchange(),
    userBalance: () => UserBalance(),
    nobleOpenOrRenew: () => NobleOpenOrRenew(),
    getUserNobleLevel: () => UserNobleLevel(),
    bindWalletList: () => BindWalletList(),
    customerServiceList: () => CustomerServiceList(),
    withdrawList: () => WithdrawList(),
    walletTypes: () => WalletTypes(),
    bindWalletAddress: () => BindWalletAddress(),
    getLiveRoomWatchList: () => GetLiveRoomWatchList(),
    openOrRenew: () => OpenOrRenew(),
    bagUseItem: () => BagUseItem(),
    sendScreenMsg: () => SendScreenMsg(),
    setWithdrawPassword: () => SetWithdrawPassword(),
    deleteWallet: () => DeleteWallet(),
    messageSystemList: () => MessageSystemList(),
    nameCard: () => NameCard(),
    messageUnreadNum: () => MessageUnreadNum(),
    messageRead: () => MessageRead(),
    updateUsername: () => UpdateUsername(),
    anchorLogin: () => AnchorLogin(),
    liveRoomBanspeak: () => LiveRoomBanspeak(),
    liveRoomBanspeakDelete: () => LiveRoomBanspeakDelete(),
    liveRoomBanspeakList: () => LiveRoomBanspeakList(),
    liveRoomManagerAdd: () => LiveRoomManagerAdd(),
    liveRoomManagerDelete: () => LiveRoomManagerDelete(),
    liveRoomManagerList: () => LiveRoomManagerList(),
    getGiftList: () => GetGiftList(),
    giftForm: () => GiftForm(),
    periodList: () => PeriodList(),
    periodDetail: () => PeriodDetail(),
    getLiveRoomWatchUser: () => GetLiveRoomWatchUser(),
    incomeList: () => IncomeList(),
    beginCharging: () => BeginCharging(),
    pauseRoom: () => PauseRoom(),
    liveRoomMirror: () => LiveRoomMirror(),
    anchorWithdrawList: () => AnchorWithdrawList(),
    liveRoomPayWatch: () => LiveRoomPayWatch(),
    getShareUrl: () => GetShareUrl(),
    checkVersion: () => CheckVersion(),
    configInfo: () => ConfigInfo(),
    userInfoReport: () => UserInfoReport(),
    domainList: () => DomainList(),
    getLiveRoomUserInfo: () => GetLiveRoomUserInfo(),
    getCode: () => GetUserCode(),
  };
}
