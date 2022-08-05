import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._();

  /// tab
  static const String tab = "/tab";

  // 榜单
  static const String listPage = "/listPage";

  // 设置页面
  static const String setting = "/setting";
  static const String settingNew = "/settingNew";

  // 积分兑换
  static const String pointsRedemption = "/pointsRedemption";

  /// 积分兑换记录
  static const String pointsRedemptionRecord = "/pointsRedemptionRecord";

  // 我的关注
  static const String favorite = "/favorite";

  // 直播间
  static const String liveRoom = "/liveRoom";

  // 黑名单
  static const String blackList = "/blackList";

  /// 预览
  static const String preview = "/preview";

  /// 聊天
  static const String conversation = "/conversation";

  /// 聊天列表
  static const String conversationList = "/conversationList";

  /// 用户信息页面
  static const String userById = "/userById";

  /// 总排行榜
  static const String totalList = "/totalList";

  /// 注册页面
  static const String register = "/registerPage";

  /// 余额充值
  static const String balanceRecharge = "/balanceRecharget";

  /// 广告
  static const String advertising = "/advertisingPage";

  /// 首页web
  static const String homeWebPage = "/homeWebPage";

  /// 首页搜索
  static const String homeSearchPage = "/homeSearchPage";

  /// 禁言列表
  static const String mutingList = "/mutingList";

  /// 账号安全
  static const String accountSecurity = "/accountSecurity";

  /// 修改登录密码
  static const String changeLogInPassword = "/changeLogInPassword";

  /// 修改支付密码
  static const String changePaymentPassword = "/changePaymentPassword";

  /// 充值页面
  static const String chargePage = "/chargePage";

  /// 绑定银行卡
  static const String bindBank = "/bindBank";

  /// 绑定银行卡管理
  // static const String bindBankManger = "/bindBankManager";

  /// 充值url页面
  static const String urlPage = "/urlPage";

  /// 提现新页面
  // static const String withdrawNew = "/withdrawNew";

  /// 新登录页面
  static const String logInNew = "/logInNewPage";

  /// 新注册页面
  static const String registerNew = "/registerNewPage";

  /// 忘记密码
  static const String forgetPassword = "/forgetPassword";

  /// 主播等级
  static const String anchorRank = "/anchorRank";

  /// 用户排行
  static const String userRank = "/userRank";

  /// 预览页
  static const String livingPreviewNew = "/livingPreviewNew";

  /// 观众
  static const String audiencePage = "/audiencePage";

  /// 观众
  static const String audiencePageHero = "/audiencePageHero";

  /// 主播页面
  static const String anchorPage = "/anchorPage";

  /// 提现记录页面
  // static const String withdrawRecord = "/withdrawRecord";

  /// 账户明细
  static const String accountDetail = "/accountDetail";

  /// 下注记录
  static const String betRecord = "/betRecord";

  /// 下注记录
  static const String chargeRecord = "/chargeRecord";

  /// 礼物报表
  static const String anchorGiftFormReport = "/anchorGiftFormReport";

  /// 直播时段
  static const String livingTimeSlot = "/livingTimeSlot";

  /// 粉丝列表
  static const String fansList = "/fansList";

  /// 关注列表
  static const String favoriteNewList = "/favoriteNewList";

  /// 修改登录密码
  static const String modifyLogInPassword = "/modifyLogInPassword";

  /// 修改支付密码
  static const String modifyPayPassword = "/modifyPayPassword";

  /// 关于我们
  static const String aboutUS = "/aboutUS";
  static const String CityListPage = "/CityListPage";

  /// 反馈
  static const String anchorFeedback = "/anchorFeedback";

  /// 站内信、公告
  static const String announcementList = "/announcementList";

  /// 切换线路
  static const String switchWay = "/switchWay";

  /// 联系客服
  static const String contactServicePage = "/contactServicePage";

  /// 用户直播间排行榜
  static const String userRankInLiving = "/userRankInLiving";

  /// 直播间贡献榜
  static const String contributionInLiving = "/contributionInLiving";

  /// 排行榜集成
  static const String rankIntegration = "/rankIntegration";

  /// 邀请码
  static const String invitationCode = "/invitationCode";

  /// 客服列表
  static const String customListService = "/customListService";

  /// 坐骑列表
  static const String carList = "/carList";

  /// 图片展示
  static const String imageUrlDisplay = "/imageUrlDisplay";

  /// app分享
  static const String appShare = "/appShare";

  /// 兑换钻石
  static const String redeemDiamonds = "/redeemDiamonds";

  /// 设置
  static const String mineSetting = "/my_mine/my_mine_setting";


  //关注粉丝
  static const String mineFloowAndFans = "/my_mine/my_fans";

  //钱包
  static const String mineWallet = "/my_mine/mine_wallet";

  /// 我的/手机认证
  static const String minePhoneApprovePage = "/minePhoneApprovePage";

  /// 我的/手机认证/账号安全
  static const String minePhoneBindPage = "/minePhoneBindPage";

  /// 我的/编辑个人资料
  static const String mineEditInfo = "/mineEditInfo";

  /// 我的/我的背包
  static const String mineBackpackPage = "/mineBackpackPage";

  /// 我的/编辑资料/编辑签名
  static const String mineEditSignaturePage = "/mineEditSignaturePage";

  /// 我的/编辑资料/编辑昵称
  static const String mineEditNicknamePage = "/mineEditNicknamePage";

  /// 我的/我的等级
  static const String mineMyLevelPage = "/mineMyLevelPage";

  /// 我的/游戏记录
  static const String mineGameRecordPage = "/mineGameRecordPage";

  /// 我的/游戏记录/游戏注单
  static const String mineGameBetPage = "/mineGameBetPage";

  /// 我的/收支明细
  static const String mineIncomeExpenditureDetailsPage =
      "/mineIncomeExpenditureDetailsPage";

  /// 我的/我的等级/用户等级规则
  static const String mineLevelRegulationPage = "/mineLevelRegulationPage";

  /// 我的/我的等级/特权详情
  static const String mineLevelPrivilegePage = "/mineLevelPrivilegePage";

  /// 消息/系统消息
  static const String messageSystemPage = "/messageSystemPage";

  // 充值提现
  static const String mineChargeAndWithdraw =
      "/my_mine/mine_wallet/mine_charge_and_withdraw";

  // 活动
  static const String mineActive = "/my_mine/mine_active";

  // 支付密码
  // static const String minePamentPassword =
  //     "$mineSetting/my_mine_pament_password";

  // 提现列表
  static const String mineWithdraw = "/my_mine/mine_withdraw";

  ///贵族
  static const String mineNoble = "/my_mine/mine_noble_page";
  // 提现详情
  static const String mineWithdrawInfo =
      "/my_mine/mine_withdraw/mine_withdraw_info";
  // 添加提现方式
  // static const String minaddBank = "/my_mine/mine_add_bank";
  // 提现成功
  static const String withdrawSucceed =
      "$mineWithdraw/mine_withdraw_info/withdraw_succeed";
  // 充值  RechargeManagerPage
  static const String mineCharge = "/recharge/recharge";
  static const String webviewGame = "/game/webviewGame";
}

homeWebPage(BuildContext context, Map arguments) {
  print("点的是这里吗");
  Get.toNamed(AppRoutes.homeWebPage,arguments: arguments);
}
