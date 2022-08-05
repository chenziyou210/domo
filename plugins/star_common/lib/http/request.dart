/*
 *  Copyright (C), 2015-2021
 *  FileName: request
 *  Author: Tonight丶相拥
 *  Date: 2021/3/11
 *  Description: 
 **/

import 'package:get/instance_manager.dart';
import 'package:httpplugin/http_container/http_container.dart';
import 'package:httpplugin/httpplugin.dart';

class WeChatAuth extends HttpTickContainer {
  @override
  String? get customUrl => "https://api.weixin.qq.com/sns/oauth2/access_token";

  @override
  String get method => GET;
}

class Register extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/enter/registered.no";
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/app/registered";

  @override
  // TODO: implement method
  String get method => POST;
}

class Login extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/enter/login.no";
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/app/login";

  @override
  // TODO: implement method
  String get method => POST;
}

class GuestLogin extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/enter/guestLogin";
  // @override
  // // TODO: implement url

  @override
  // TODO: implement method
  String get method => POST;
}

// class LiveToken extends HttpTickContainer {
//   @override
//   // TODO: implement url
//   String get url => "/agora-0.0.1-SNAPSHOT/token/getToken";
//
//   @override
//   // TODO: implement method
//   String get method => GET;
// }

class UploadImage extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/data/image";
  @override
  // TODO: implement url
  String get url => "/api/app/data/image";

  @override
  // TODO: implement method
  String get method => POST;

  @override
  // TODO: implement isFile
  bool get isFile => true;
}

class UserInfo extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/myCenter/info";
  @override
  // TODO: implement url
  String get url => "/api/app/user/info";

  @override
  // TODO: implement method
  String get method => POST;
}

class EditUserInfo extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/myCenter/info/edit";
  // @override
  // // TODO: implement url
  // String get url => "/api/app/myCenter/info/edit";
  @override
  // TODO: implement url
  String get url => "/api/app/user/info/edit";

  @override
  // TODO: implement method
  String get method => POST;
}

class SettingInfo extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/myCenter/settingInfo";
  @override
  // TODO: implement url
  String get url => "/api/app/myCenter/settingInfo";

  @override
  // TODO: implement method
  String get method => POST;
}

class SystemParameterList extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/api/app/system/sysParamList";
  @override
  // TODO: implement url
  String get url => "/api/app/system/sysParamMap.no";

  @override
  // TODO: implement method
  String get method => POST;

  @override
  // TODO: implement retryTimes
  int? get retryTimes => 3;
}

class SettingUpdate extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/myCenter/settingInfo/update";
  @override
  // TODO: implement url
  String get url => "/api/app/myCenter/settingInfo/update";

  @override
  // TODO: implement method
  String get method => POST;
}

class BlackList extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/myCenter/settingInfo/showBlackList";
  @override
  // TODO: implement url
  String get url => "/api/app/myCenter/blackList/show";

  @override
  // TODO: implement method
  String get method => POST;
}

class DeleteBlackList extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/myCenter/settingInfo/deleteBlackList";
  @override
  // TODO: implement url
  String get url => "/api/app/myCenter/BlackList/delete";

  @override
  // TODO: implement method
  String get method => POST;
}

class InsertBlackList extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/myCenter/settingInfo/insertBlackList";
  @override
  // TODO: implement url
  String get url => "/api/app/myCenter/blackList/insert";

  @override
  // TODO: implement method
  String get method => POST;
}

class FavoritePaging extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/myCenter/myAttention/page";
  // @override
  // // TODO: implement url
  // String get url => "/api/app/myCenter/myAttention/page";
  @override
  // TODO: implement url
  String get url => "/api/app/follow/list";

  @override
  // TODO: implement method
  String get method => POST;
}

class FavoriteInsert extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/myCenter/myAttention/insert";
  // @override
  // // TODO: implement url
  // String get url => "/api/app/myCenter/myAttention/insert";
  @override
  // TODO: implement url
  // String get url => "/api/app/appmyattentionuser/insert";
  String get url => "/api/app/follow/insert";

  @override
  // TODO: implement method
  String get method => POST;
}

class FavoriteDelete extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/myCenter/myAttention/delete";
  // @override
  // // TODO: implement url
  // String get url => "/api/app/myCenter/myAttention/delete";
  @override
  // TODO: implement url
  // String get url => "/api/app/appmyattentionuser/delete";
  String get url => "/api/app/follow/delete";

  @override
  // TODO: implement method
  String get method => POST;
}

class LogOut extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/app/logout";
  @override
  // TODO: implement url
  String get url => "/api/app/enter/logout";

  @override
  // TODO: implement method
  String get method => POST;
}

class AnchorList extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/index/showAnchorByLable";
  // @override
  // // TODO: implement url
  // String get url => "/api/app/index/showAnchorByLable";

  @override
  // TODO: implement url
  String get url => "/api/app/liveRoom/roomList";

  @override
  // TODO: implement method
  String get method => POST;
}

class CreateLiveRoom extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/MLVBLiveRoom/createCommonRoom";
  @override
  // TODO: implement url
  // String get url => "/api/app/anchor/createLiveRoom";
  String get url => "/api/app/liveRoom/openRoom";

  @override
  // TODO: implement method
  String get method => POST;
}

// class CreateGameRoom extends HttpTickContainer {
//   @override
//   // TODO: implement url
//   String get url => "/agora-0.0.1-SNAPSHOT/MLVBLiveRoom/createGameRoom";
//
//   @override
//   // TODO: implement method
//   String get method => POST;
// }
//
// class CreatePasswordRoom extends HttpTickContainer {
//   @override
//   // TODO: implement url
//   String get url => "/agora-0.0.1-SNAPSHOT/MLVBLiveRoom/createPassWordRoom";
//
//   @override
//   // TODO: implement method
//   String get method => POST;
// }
//
// class CreateTicketAmountRoom extends HttpTickContainer {
//   @override
//   // TODO: implement url
//   String get url => "/agora-0.0.1-SNAPSHOT/MLVBLiveRoom/createTicketAmountRoom";
//
//   @override
//   // TODO: implement method
//   String get method => POST;
// }
//
// class CreateTimeDeductionRoom extends HttpTickContainer {
//   @override
//   // TODO: implement url
//   String get url => "/agora-0.0.1-SNAPSHOT/MLVBLiveRoom/createTimeDeductionRoom";
//
//   @override
//   // TODO: implement method
//   String get method => POST;
// }

// class AnchorExitRoom extends HttpTickContainer {
//   @override
//   // TODO: implement url
//   String get url => "/agora-0.0.1-SNAPSHOT/MLVBLiveRoom/deleteAnchor";
//
//   @override
//   // TODO: implement method
//   String get method => POST;
// }

class DestroyRoom extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/MLVBLiveRoom/destroyRoom";
  // @override
  // // TODO: implement url
  // String get url => "/api/app/MLVBLiveRoom/destroyRoom";
  @override
  // TODO: implement url
  // String get url => "/api/app/anchor/destroyRoom";
  String get url => "/api/app/liveRoom/closeRoom";

  @override
  // TODO: implement method
  String get method => POST;
}

class CheckRecharge extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/MLVBLiveRoom/destroyRoom";
  // @override
  // // TODO: implement url
  // String get url => "/api/app/MLVBLiveRoom/destroyRoom";
  @override
  // TODO: implement url
  // String get url => "/api/app/anchor/destroyRoom";
  String get url => "/api/app/activity/isFirstRecharge";

  @override
  // TODO: implement method
  String get method => POST;
}

class BrushGift extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/LiveingRoom/brushGift";
  @override
  // TODO: implement url
  String get url => "/api/app/giftsend/brushGift";

  @override
  // TODO: implement method
  String get method => POST;
}

class AudienceExitRoom extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/LiveingRoom/deleteAudience";
  // @override
  // // TODO: implement url
  // String get url => "/api/app/liveingRoom/deleteAudience";
  @override
  // TODO: implement url
  // String get url => "/api/app/anchor/deleteAudience";
  String get url => "/api/app/liveRoom/exitRoom";

  @override
  // TODO: implement method
  String get method => POST;
}

// class AudienceExitAndAttention extends HttpTickContainer {
//   @override
//   // TODO: implement url
//   String get url => "/agora-0.0.1-SNAPSHOT/LiveingRoom/deleteAudienceAndAttiontion";
//
//   @override
//   // TODO: implement method
//   String get method => POST;
// }

// class AudienceCount extends HttpTickContainer {
//
//   @override
//   // TODO: implement url
//   String get url => "/agora-0.0.1-SNAPSHOT/LiveingRoom/getAudiences";
//
//   @override
//   // TODO: implement method
//   String get method => POST;
// }
@deprecated
class LiveRoomRank extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/LiveingRoom/getLiveRoomRank/daily";
  @override
  // TODO: implement url
  String get url => "/api/app/liveingRoom/getLiveRoom/rank";

  @override
  // TODO: implement method
  String get method => POST;
}

// class MonthRank extends HttpTickContainer {
//   @override
//   // TODO: implement url
//   String get url => "/agora-0.0.1-SNAPSHOT/LiveingRoom/getLiveRoomRank/month";
//
//   @override
//   // TODO: implement method
//   String get method => POST;
// }
//
// class WeekRank extends HttpTickContainer {
//
//   @override
//   // TODO: implement url
//   String get url => "/agora-0.0.1-SNAPSHOT/LiveingRoom/getLiveRoomRank/week";
//
//   @override
//   // TODO: implement method
//   String get method => POST;
// }

class GetUserInfo extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/LiveingRoom/getUserInfo";
  // @override
  // // TODO: implement url
  // String get url => "/api/app/liveingRoom/getUserInfo";

  @override
  // TODO: implement url
  String get url => "/api/app/user/getUserInfo";

  @override
  // TODO: implement method
  String get method => POST;
}

class GetAward extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/activity/first/recharge/reward";

  @override
  // TODO: implement method
  String get method => POST;
}

class GetRoomGiftList extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/LiveingRoom/gitLiveRoomGift";
  // @override
  // // TODO: implement url
  // String get url => "/api/app/liveingRoom/gift/getList";
  @override
  // TODO: implement url
  String get url => "/api/app/giftsend/getGiftList";

  @override
  // TODO: implement method
  String get method => POST;
}

class AddAudience extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/index/addAudience";
  // @override
  // // TODO: implement url
  // String get url => "/api/app/MLVBLiveRoom/addAudience";

  @override
  // TODO: implement url
  // String get url => "/api/app/anchor/addAudience";
  String get url => "/api/app/liveRoom/joinRoom";

  @override
  // TODO: implement method
  String get method => POST;
}

class NearAnchor extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/agora-0.0.1-SNAPSHOT/index/geo/near";

  @override
  // TODO: implement method
  String get method => POST;
}

class LocationSave extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/agora-0.0.1-SNAPSHOT/index/geo/sava";

  @override
  // TODO: implement method
  String get method => POST;
}

// class GetAnchor extends HttpTickContainer {
//   @override
//   // TODO: implement url
//   String get url => "/agora-0.0.1-SNAPSHOT/index/getAnchors";
//
//   @override
//   // TODO: implement method
//   String get method => POST;
// }

// class IndexDailyRank extends HttpTickContainer {
//   @override
//   // TODO: implement url
//   String get url => "/agora-0.0.1-SNAPSHOT/index/getIndexRank/daily";
//
//   @override
//   // TODO: implement method
//   String get method => POST;
// }
//
// class IndexMonthRank extends HttpTickContainer {
//   @override
//   // TODO: implement url
//   String get url => "/agora-0.0.1-SNAPSHOT/index/getIndexRank/month";
//
//   @override
//   // TODO: implement method
//   String get method => POST;
// }

class IndexRank extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/index/getIndexRank";

  @override
  // TODO: implement method
  String get method => POST;
}

class TencentHeartBeat extends HttpTickContainer {
  @override
  // TODO: implement method
  String get method => POST;

  @override
  // TODO: implement needJoinQueryParameterBySelf
  bool get needJoinQueryParameterBySelf => true;
}

class LiveRoomInfo extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/LiveingRoom/getLiveingRoomInfo";
  //
  // @override
  // // TODO: implement url
  // String get url => "/api/app/liveingRoom/getLiveingRoomInfo";
  @override
  // TODO: implement url
  String get url => "/api/app/liveRoom/getLiveRoomInfo";

  @override
  // TODO: implement method
  String get method => POST;
}

class HomeBanner extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/global/showAdvertise";

  // @override
  // // TODO: implement url
  // String get url => "/api/app/global/showAdvertise";
  @override
  // TODO: implement url
  String get url => "/api/app/advertise/showAdvertise";

  @override
  // TODO: implement method
  String get method => POST;
}

// class HomeSearch extends HttpTickContainer {
//   // @override
//   // // TODO: implement url
//   // String get url => "/agora-0.0.1-SNAPSHOT/index/recommend";
//   // /agora-0.0.1-SNAPSHOT/app/index/recommend
//   //
//   // @override
//   // // TODO: implement url
//   // String get url => "/api/app/index/recommend";
//   @override
//   // TODO: implement url
//   String get url => "/api/app/anchor/recommend";
//
//   @override
//   // TODO: implement method
//   String get method => POST;
// }

class UserInfoById extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/LiveingRoom/getAnchorHomePageInfo";

  // @override
  // // TODO: implement url
  // String get url => "/api/app/liveingRoom/getAnchorHomePageInfo";
  @override
  // TODO: implement url
  String get url => "/api/app/anchor/getAnchorHomePageInfo";

  @override
  // TODO: implement method
  String get method => POST;
}

class AnchorContributionList extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/LiveingRoom/getAnchorContributionList";

  @override
  // TODO: implement url
  String get url => "/api/app/liveingRoom/getAnchorContribution/List";

  @override
  // TODO: implement method
  String get method => POST;
}

class ShowConsPage extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/MoneyrRelated/showConsPage";
  @override
  // TODO: implement url
  String get url => "/api/app/moneyrRelated/showConsPage";

  @override
  // TODO: implement method
  String get method => POST;
}

class ChargeDiamond extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/MoneyrRelated/showConsPage/recharge";
  @override
  // TODO: implement url
  String get url => "/api/app/moneyrRelated/showConsPage/recharge";

  @override
  // TODO: implement method
  String get method => POST;
}

class BalanceRecharge extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/MoneyrRelated/balanceRecharge";
  @override
  // TODO: implement url
  String get url => "/api/app/moneyrRelated/balanceRecharge";

  @override
  // TODO: implement method
  String get method => POST;
}

class AnchorLabel extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/MLVBLiveRoom/selectAnchorLable";

  @override
  // TODO: implement url
  String get url => "/api/app/MLVBLiveRoom/selectAnchorLable";

  @override
  // TODO: implement method
  String get method => POST;
}

class VerifyRoom extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/MLVBLiveRoom/addAudience";

  // @override
  // // TODO: implement url
  // String get url => "/api/app/MLVBLiveRoom/addAudience";

  @override
  // TODO: implement url
  // String get url => "/api/app/anchor/addAudience";
  String get url => "/api/app/liveRoom/joinRoom";

  @override
  // TODO: implement method
  String get method => POST;
}

class TimerLiveRoom extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/api/app/liveingRoom/liveroomDeduction";

  @override
  // TODO: implement url
  String get url => "/api/app/anchor/liveroomDeduction";

  @override
  // TODO: implement method
  String get method => POST;
}

class BanSpeak extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/LiveingRoom/banSpeak/add";
  @override
  // TODO: implement url
  String get url => "/api/app/liveingRoom/banSpeak/add";

  @override
  // TODO: implement method
  String get method => POST;
}

class DeleteBanSpeak extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/LiveingRoom/banSpeak/delete";
  @override
  // TODO: implement url
  String get url => "/api/app/liveingRoom/banSpeak/delete";

  @override
  // TODO: implement method
  String get method => POST;
}

class BanSpeakList extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/LiveingRoom/banSpeak/list";
  @override
  // TODO: implement url
  String get url => "/api/app/liveingRoom/banSpeak/list";

  @override
  // TODO: implement method
  String get method => POST;
}

class Withdraw extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/moneyrRelated/moneyWithdraw";

  @override
  // TODO: implement method
  String get method => POST;
}

class GetNobelHideStatus extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/live/room/noble/getSpecialProperties";

  @override
  // TODO: implement method
  String get method => POST;
}

class SetNobelHideStatus extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/live/room/noble/setSpecialProperties";

  @override
  // TODO: implement method
  String get method => POST;
}

class GameConfig extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/game/getGameConfig";

  @override
  // TODO: implement method
  String get method => POST;

  @override
  // TODO: implement retryTimes
  int? get retryTimes => 3;
}

class Bet extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/game/bottomPour";

  @override
  // TODO: implement method
  String get method => POST;
}

class RuntimeGame extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/game/getRuntimeGame";

  @override
  // TODO: implement method
  String get method => POST;

  @override
  // TODO: implement retryTimes
  int? get retryTimes => 3;
}

class AudienceNumber extends HttpTickContainer {
  // @override
  // // TODO: implement url
  // String get url => "/api/app/liveingRoom/audienceNumber";

  @override
  // TODO: implement url
  // String get url => "/api/app/anchor/audienceNumber";
  String get url => "/api/app/liveRoom/audience/count";

  @override
  // TODO: implement method
  String get method => POST;
}

class LivingRoomRecommend extends HttpTickContainer {
  @override
  // TODO: implement url
  // String get url => "/api/app/anchor/recommend";
  String get url => "/api/app/liveRoom/roomSideRecommend";

  @override
  // TODO: implement method
  String get method => POST;
}

class LotteryLog extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/game/getLotteryLog";

  @override
  // TODO: implement method
  String get method => POST;
}

class BetLog extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/game/getBottomPourLog";

  @override
  // TODO: implement method
  String get method => POST;
}

class ShowBank extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/pursechannel/list.no";

  @override
  // TODO: implement method
  String get method => POST;
}

class SystemBankList extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/user/bindBank/sysBankList";

  @override
  // TODO: implement method
  String get method => POST;
}

class BindBankList extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/user/bindBank/list";

  @override
  // TODO: implement method
  String get method => POST;
}

class UserBindBankInfo extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/userbindbank/info";

  @override
  // TODO: implement method
  String get method => POST;
}

class UserBindBankModify extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/user/bindBank/saveOrUpdate";

  @override
  // TODO: implement method
  String get method => POST;
}

class CreateOrder extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/orderpayment/createOrder";

  @override
  // TODO: implement method
  String get method => POST;
}

class PayNotifyUrl extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/orderpayment/payNotifyUrl.no";

  @override
  // TODO: implement method
  String get method => POST;
}

// class WithdrawNew extends HttpTickContainer {
//   @override
//   // TODO: implement url
//   String get url => "/api/app/userwithdraw/saveOrUpdate";

//   @override
//   // TODO: implement method
//   String get method => POST;
// }

class SendVerificationCode extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/enter/code.no";

  @override
  // TODO: implement method
  String get method => POST;
}

class ForgetPassword extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/enter/forgetPassword.no";

  @override
  // TODO: implement method
  String get method => POST;
}

class GradeList extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/level/info";

  @override
  // TODO: implement method
  String get method => POST;
}

class AnchorRank extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/giftsend/rank/total";

  @override
  // TODO: implement method
  String get method => POST;
}

class FansPage extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/follow/fanList";

  @override
  // TODO: implement method
  String get method => POST;
}

class AnchorOnlineNumber extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/anchor/anchorNumber";

  @override
  // TODO: implement method
  String get method => POST;
}

class LivingAddStatus extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/anchor/addAnchorAdmin";

  @override
  // TODO: implement method
  String get method => POST;
}

class LivingCancelStatus extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/anchor/cancelAnchorAdmin";

  @override
  // TODO: implement method
  String get method => POST;
}

class SysParamMap extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/system/sysParamList";

  @override
  // TODO: implement method
  String get method => POST;
}

class WithdrawInfo extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/withdraw/record/list";

  @override
  // TODO: implement method
  String get method => POST;
}

class AccountDetail extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/coinFlow/recordList";

  @override
  // TODO: implement method
  String get method => POST;
}

class BetRecord extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/gamebottompourlog/list";

  @override
  // TODO: implement method
  String get method => POST;
}

class ChargeRecord extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/recharge/record/list";

  @override
  // TODO: implement method
  String get method => POST;
}

class AnchorGiftFormReport extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/giftsend/giftForm";

  @override
  // TODO: implement method
  String get method => POST;
}

class LivingTimeSlot extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/anchor/getLiveTime";

  @override
  // TODO: implement method
  String get method => POST;
}

class ModifyWithdrawPassword extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/user/setWithdrawPassword";

  @override
  // TODO: implement method
  String get method => POST;
}

class ModifyLogInPassword extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/user/updeteLoginPassword";

  @override
  // TODO: implement method
  String get method => POST;
}

class AnchorFeedback extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/anchoradvice/save";

  @override
  // TODO: implement method
  String get method => POST;
}

class ContributionListInLiving extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/giftsend/anchor/ContributionList";

  @override
  // TODO: implement method
  String get method => POST;
}

class UpgradeVersion extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/appversion/list";

  @override
  // TODO: implement method
  String get method => POST;
}

class AppDownload extends HttpTickContainer {
  @override
  // TODO: implement method
  String get method => GET;
}

class FireBaseTokenSubmit extends HttpTickContainer {
  @override
  // TODO: implement method
  String get method => POST;

  @override
  // TODO: implement url
  String get url => "/api/app/userfirebasetoken/save";
}

class CustomServicesList extends HttpTickContainer {
  @override
  // TODO: implement method
  String get method => POST;

  @override
  // TODO: implement url
  String get url => "/api/app/customerservice/list.no";
}

class CarBuy extends HttpTickContainer {
  @override
  // TODO: implement method
  String get method => POST;

  @override
  // TODO: implement url
  String get url => "/api/app/car/buy";
}

class SendGiftBag extends HttpTickContainer {
  @override
  // TODO: implement method
  String get method => POST;

  @override
  // TODO: implement url
  String get url => "/api/user/bag/sendGiftBag";
}

class CarList extends HttpTickContainer {
  @override
  // TODO: implement method
  String get method => POST;

  @override
  // TODO: implement url
  String get url => "/api/app/car/list";
}

class UseCar extends HttpTickContainer {
  @override
  // TODO: implement method
  String get method => POST;

  @override
  // TODO: implement url
  String get url => "/api/app/car/use";
}

class AppActivity extends HttpTickContainer {
  @override
  // TODO: implement method
  String get method => POST;

  @override
  // TODO: implement retryTimes
  // int? get retryTimes => 2;

  @override
  // TODO: implement url
  String get url => "/api/app/activity/list";
}

class SearchAnchorOnType extends HttpTickContainer {
  @override
  // TODO: implement method
  String get method => POST;

  @override
  // TODO: implement url
  String get url => "/api/app/anchor/showPageByAnchorType";
}

class SystemDictionary extends HttpTickContainer {
  @override
  // TODO: implement method
  String get method => POST;

  @override
  // TODO: implement retryTimes
  int? get retryTimes => 2;

  @override
  // TODO: implement url
  String get url => "/api/app/system/sysDictionaryList.no";
}

class UserRemainingRewardPoint extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/account/getUserRemainingRewardPoint";

  @override
  // TODO: implement method
  String get method => POST;
}

class PointExchangeGift extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/point/exchange/exchangeGift";

  @override
  // TODO: implement method
  String get method => POST;
}

class UserExchangeRecord extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/point/exchange/listUserExchangeRecord";

  @override
  // TODO: implement method
  String get method => POST;
}

class ExchangeGiftList extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/bagpack/listExchangeGift";

  @override
  // TODO: implement method
  String get method => POST;
}

class UserPackageList extends HttpTickContainer {
  @override
  // TODO: implement method
  String get method => POST;

  @override
  // TODO: implement url
  String get url => "/api/user/bag/getUserBagList";
}

class CateGoryLabel extends HttpTickContainer {
  @override
  // TODO: implement method
  String get method => POST;

  @override
  // TODO: implement url
  String get url => "/api/app/liveRoom/categoryLabel";
}

class FollowAnchorListLabel extends HttpTickContainer {
  @override
  // TODO: implement method
  String get method => POST;

  @override
  // TODO: implement url
  String get url => "/api/app/liveRoom/followAnchor";
}

class AdvertiseBanner extends HttpTickContainer {
  @override
  // TODO: implement method
  String get method => POST;

  @override
  // TODO: implement url
  String get url => "/api/app/advertise/showAdvertise";
}

class HomeRankFirst extends HttpTickContainer {
  @override
  // TODO: implement method
  String get method => POST;

  @override
  // TODO: implement url
  String get url => "/api/app/giftsend/rank/first";
}

class HomeSearchInfo extends HttpTickContainer {
  @override
  // TODO: implement method
  String get method => POST;

  @override
  // TODO: implement url
  String get url => "/api/app/liveRoom/search";
}

class AnnouncementList extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/announcement/list";

  @override
  // TODO: implement method
  String get method => POST;
}

class FollowList extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/follow/list";

  @override
  // TODO: implement method
  String get method => POST;
}

class ChatRoomAccount extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/user/chatRoomAccount";

  @override
  // TODO: implement method
  String get method => POST;
}

class SmsSend extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/captcha/sms/send";

  @override
  // TODO: implement method
  String get method => POST;
}

class BindPhone extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/user/bindPhone";

  @override
  // TODO: implement method
  String get method => POST;
}

class ChangeRoom extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/liveRoom/switchRoom";

  @override
  // TODO: implement method
  String get method => POST;
}

class Contribute extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/giftsend/rank/contribute";

  @override
  // TODO: implement method
  String get method => POST;
}

class GameList extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/game/gameList";

  @override
  // TODO: implement method
  String get method => POST;
}

class GameRecordList extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/game/gameRecordList";

  @override
  // TODO: implement method
  String get method => POST;
}

class GameBetRecordList extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/game/getBetRecordList";

  @override
  // TODO: implement method
  String get method => POST;
}

class GameUrl extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/game/getGameUrl";

  @override
  // TODO: implement method
  String get method => POST;
}

class GameTransferIn extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/game/transfer/in";

  @override
  // TODO: implement method
  String get method => POST;
}

class GameTransferOut extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/game/transfer/out";

  @override
  // TODO: implement method
  String get method => POST;
}

///获取游戏URL
class GameRoomEnter extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/liveRoom/game/enter";

  @override
  // TODO: implement method
  String get method => POST;
}

class GameRoomBetting extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/liveRoom/game/bet";

  @override
  // TODO: implement method
  String get method => POST;
}

class PurseChannel extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/pursechannel/list.no";
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/app/registered";

  @override
  // TODO: implement method
  String get method => POST;
}

class CreateWithdrawOrder extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/withdraw/createWithdrawOrder";

  @override
  // TODO: implement method
  String get method => POST;
}

class QueryUserBalance extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/withdraw/queryUserBalance";
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/app/registered";

  @override
  // TODO: implement method
  String get method => POST;
}

class QueryChannelList extends HttpTickContainer {
  @override
  String get url => "/api/app/recharge/queryChannelList";
  @override
  String get method => GET;
}

class CreateRechargeOrder extends HttpTickContainer {
  @override
  String get url => "/api/app/recharge/createRechargeOrder";
  @override
  String get method => POST;
}

class QueryRechargeByOrderNo extends HttpTickContainer {
  @override
  String get url => "/api/app/recharge/queryRechargeByOrderNo";
  @override
  String get method => POST;
}

class DiamondList extends HttpTickContainer {
  @override
  String get url => "/api/app/user/diamond/package/list";
  @override
  String get method => POST;
}

class DiamondExchange extends HttpTickContainer {
  @override
  String get url => "/api/app/user/diamond/exchange";
  @override
  String get method => POST;
}

class UserBalance extends HttpTickContainer {
  @override
  String get url => "/api/app/user/balance";
  @override
  String get method => POST;
}

class HomeGameList extends HttpTickContainer {
  @override
  String get url => "/api/app/liveRoom/game/list";
  @override
  String get method => POST;
}

class NobleOpenOrRenew extends HttpTickContainer {
  @override
  String get url => "/api/live/room/noble/openOrRenew";
  @override
  String get method => POST;
}

class UserNobleLevel extends HttpTickContainer {
  @override
  String get url => "/api/live/room/noble/getUserNobleLevel";
  @override
  String get method => POST;
}

class BindWalletList extends HttpTickContainer {
  @override
  String get url => "/api/app/user/bindWallet/list";
  @override
  String get method => POST;
}

class CustomerServiceList extends HttpTickContainer {
  @override
  String get url => "/api/app/customer/service/list";

  @override
  String get method => POST;
}

class WithdrawList extends HttpTickContainer {
  @override
  String get url => "/api/app/withdraw/queryTypeList";

  @override
  String get method => GET;
}

class WalletTypes extends HttpTickContainer {
  @override
  String get url => "/api/app/user/wallet/typeList";
  @override
  String get method => POST;
}

class GetLiveRoomWatchList extends HttpTickContainer {
  @override
  String get url => "/api/app/room/watch/getLiveRoomWatchList";

  @override
  String get method => POST;
}

class BindWalletAddress extends HttpTickContainer {
  @override
  String get url => "/api/app/user/bindWalletAddress";
  @override
  String get method => POST;
}

class OpenOrRenew extends HttpTickContainer {
  @override
  String get url => "/api/app/room/watch/openOrRenew";

  @override
  String get method => POST;
}

class BagUseItem extends HttpTickContainer {
  @override
  String get url => "/api/user/bag/useItem";

  @override
  String get method => POST;
}

class SendScreenMsg extends HttpTickContainer {
  @override
  String get url => "/api/app/liveRoom/sendScreenMessage";

  @override
  String get method => POST;
}

class SetWithdrawPassword extends HttpTickContainer {
  @override
  String get url => "/api/app/user/setWithdrawPassword";

  @override
  String get method => POST;
}

class DeleteWallet extends HttpTickContainer {
  @override
  String get url => "/api/app/user/bindWallet/delete";

  @override
  String get method => POST;
}

class DeleteBankCard extends HttpTickContainer {
  @override
  String get url => "/api/app/user/bindBank/delete";

  @override
  String get method => POST;
}

class MessageSystemList extends HttpTickContainer {
  @override
  String get url => "/api/app/message/list";

  @override
  String get method => POST;
}

class NameCard extends HttpTickContainer {
  @override
  String get url => "/api/live/room/getNameCard";

  @override
  String get method => POST;
}

class MessageUnreadNum extends HttpTickContainer {
  @override
  String get url => "/api/app/message/getUnreadNum";

  @override
  String get method => POST;
}

class MessageRead extends HttpTickContainer {
  @override
  String get url => "/api/app/message/read";

  @override
  String get method => POST;
}

class UpdateUsername extends HttpTickContainer {
  @override
  String get url => "/api/app/user/updateUsername";

  @override
  String get method => POST;
}

class AnchorLogin extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/enter/anchor/login";
  // @override
  // // TODO: implement url
  // String get url => "/agora-0.0.1-SNAPSHOT/app/login";

  @override
  // TODO: implement method
  String get method => POST;
}

///直播间添加禁言
class LiveRoomBanspeak extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/liveroombanspeak/add";

  @override
  // TODO: implement method
  String get method => POST;
}

///直播间取消禁言
class LiveRoomBanspeakDelete extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/liveroombanspeak/delete";

  @override
  // TODO: implement method
  String get method => POST;
}

class LiveRoomBanspeakList extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/liveroombanspeak/list";

  @override
  // TODO: implement method
  String get method => POST;
}

class LiveRoomManagerAdd extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/liveroom/manager/add";

  @override
  // TODO: implement method
  String get method => POST;
}

class LiveRoomManagerDelete extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/liveroom/manager/delete";

  @override
  // TODO: implement method
  String get method => POST;
}

class LiveRoomManagerList extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/liveroom/manager/list";

  @override
  // TODO: implement method
  String get method => POST;
}

class GetGiftList extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/giftsend/receiveGiftList";

  @override
  // TODO: implement method
  String get method => POST;
}

class GiftForm extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/giftsend/giftForm";

  @override
  // TODO: implement method
  String get method => POST;
}

class PeriodList extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/liveRoom/period/list";

  @override
  // TODO: implement method
  String get method => POST;
}

class PeriodDetail extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/liveRoom/period/detail";

  @override
  // TODO: implement method
  String get method => POST;
}

class GetLiveRoomWatchUser extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/room/watch/getLiveRoomWatchUser";

  @override
  // TODO: implement method
  String get method => POST;
}

class IncomeList extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/liveRoom/income/list";

  @override
  // TODO: implement method
  String get method => POST;
}

class BeginCharging extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/liveRoom/beginCharging";

  @override
  // TODO: implement method
  String get method => POST;
}

class PauseRoom extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/liveRoom/pauseRoom";

  @override
  // TODO: implement method
  String get method => POST;
}

class LiveRoomMirror extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/liveRoom/mirror";

  @override
  // TODO: implement method
  String get method => POST;
}

class AnchorWithdrawList extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/user/anchor/withdraw/list";

  @override
  // TODO: implement method
  String get method => POST;
}

class GetShareUrl extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/share/getShareUrl";

  @override
  // TODO: implement method
  String get method => POST;
}

class LiveRoomPayWatch extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/liveRoom/payWatch";

  @override
  // TODO: implement method
  String get method => POST;
}

class CheckVersion extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/version/list";

  @override
  // TODO: implement method
  String get method => POST;
}

class ConfigInfo extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/config/info";

  @override
  // TODO: implement method
  String get method => POST;
}

class UserInfoReport extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/userInfoReport/save";

  @override
  // TODO: implement method
  String get method => POST;
}

class DomainList extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/domain/list";

  @override
  // TODO: implement method
  String get method => POST;
}

class GetLiveRoomUserInfo extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/user/getLiveRoomUserInfo";

  @override
  // TODO: implement method
  String get method => POST;
}
///仅开发用接口，查看手机验证码
class GetUserCode extends HttpTickContainer {
  @override
  // TODO: implement url
  String get url => "/api/app/captcha/sms/tool";

  @override
  // TODO: implement method
  String get method => POST;
}
