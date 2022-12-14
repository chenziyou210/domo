// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import '/generated/account_detail_entity.dart';
import '/generated/json/account_detail_entity.g.dart';
import '/generated/anchor_gift_report_entity.dart';
import '/generated/json/anchor_gift_report_entity.g.dart';
import '/generated/anchor_label_entity.dart';
import '/generated/json/anchor_label_entity.g.dart';
import '/generated/anchor_list_entity.dart';
import '/generated/json/anchor_list_entity.g.dart';
import '/generated/anchor_list_model_entity.dart';
import '/generated/json/anchor_list_model_entity.g.dart';
import '/generated/announcement_entity.dart';
import '/generated/json/announcement_entity.g.dart';
import '/generated/app_activity_entity.dart';
import '/generated/json/app_activity_entity.g.dart';
import '/generated/audience_online_entity.dart';
import '/generated/json/audience_online_entity.g.dart';
import '/generated/bank_list_entity.dart';
import '/generated/json/bank_list_entity.g.dart';
import '/generated/banner_entity.dart';
import '/generated/json/banner_entity.g.dart';
import '/generated/bet_record_entity.dart';
import '/generated/json/bet_record_entity.g.dart';
import '/generated/car_list_entity.dart';
import '/generated/json/car_list_entity.g.dart';
import '/generated/channel_list_entity.dart';
import '/generated/json/channel_list_entity.g.dart';
import '/generated/charge_record_entity.dart';
import '/generated/json/charge_record_entity.g.dart';
import '/generated/diamond_charge_entity.dart';
import '/generated/json/diamond_charge_entity.g.dart';
import '/generated/exchange_gift_list_entity.dart';
import '/generated/favorite_entity.dart';
import '/generated/json/favorite_entity.g.dart';
import '/generated/favorite_new_entity.dart';
import '/generated/json/favorite_new_entity.g.dart';
import '/generated/gift_entity.dart';
import '/generated/json/gift_entity.g.dart';
import '/generated/index_rank_entity.dart';
import '/generated/json/index_rank_entity.g.dart';
import '/generated/live_room_info_entity.dart';
import '/generated/living_audience_entity.dart';
import '/generated/json/living_audience_entity.g.dart';
import '/generated/living_room_lottery_entity.dart';
import '/generated/json/living_room_lottery_entity.g.dart';
import '/generated/living_time_slot_entity.dart';
import '/generated/json/living_time_slot_entity.g.dart';
import '/generated/lottery_record_entity.dart';
import '/generated/json/lottery_record_entity.g.dart';
import '/generated/package_gift_entity.dart';
import '/generated/json/package_gift_entity.g.dart';
import '/generated/points_redemption_entity.dart';
import '/generated/json/points_redemption_entity.g.dart';
import '/generated/rank_new_entity.dart';
import '/generated/json/rank_new_entity.g.dart';
import '/generated/sample_user_info_entity.dart';
import '/generated/json/sample_user_info_entity.g.dart';
import '/generated/share_app_link_entity.dart';
import '/generated/json/share_app_link_entity.g.dart';
import '/generated/system_bank_entity.dart';
import '/generated/json/system_bank_entity.g.dart';
import '/generated/upgrade_entity.dart';
import '/generated/json/upgrade_entity.g.dart';
import '/generated/user_grade_entity.dart';
import '/generated/json/user_grade_entity.g.dart';
import '/generated/user_info_entity.dart';
import '/generated/json/user_info_entity.g.dart';
import '/generated/user_message_entity.dart';
import '/generated/json/user_message_entity.g.dart';
import '/generated/withdraw_record_entity.dart';
import '/generated/json/withdraw_record_entity.g.dart';

JsonConvert jsonConvert = JsonConvert();

class JsonConvert {

  T? convert<T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return asT<T>(value);
  }

  List<T?>? convertList<T>(List<dynamic>? value) {
    if (value == null) {
      return null;
    }
    try {
      return value.map((dynamic e) => asT<T>(e)).toList();
    } catch (e, stackTrace) {
      print('asT<$T> $e $stackTrace');
      return <T>[];
    }
  }

  List<T>? convertListNotNull<T>(dynamic value) {
    if (value == null) {
      return null;
    }
    try {
      return (value as List<dynamic>).map((dynamic e) => asT<T>(e)!).toList();
    } catch (e, stackTrace) {
      print('asT<$T> $e $stackTrace');
      return <T>[];
    }
  }
  T? asT<T extends Object?>(dynamic value) {
    if (value is T) {
      return value;
    }
		final String type = T.toString();
    try {
      final String valueS = value.toString();
      if (type == "String") {
        return valueS as T;
      } else if (type == "int") {
        final int? intValue = int.tryParse(valueS);
        if (intValue == null) {
          return double.tryParse(valueS)?.toInt() as T?;
        } else {
          return intValue as T;
        }      } else if (type == "double") {
        return double.parse(valueS) as T;
      } else if (type ==  "DateTime") {
        return DateTime.parse(valueS) as T;
      } else if (type ==  "bool") {
        if (valueS == '0' || valueS == '1') {
          return (valueS == '1') as T;
        }
        return (valueS == 'true') as T;
      } else {
        return JsonConvert.fromJsonAsT<T>(value);
      }
    } catch (e, stackTrace) {
      print('asT<$T> $e $stackTrace');
      return null;
    }
  } 
	//Go back to a single instance by type
	static M? _fromJsonSingle<M>(Map<String, dynamic> json) {
		final String type = M.toString();
		if(type == (AccountDetailEntity).toString()){
			return AccountDetailEntity.fromJson(json) as M;
		}
		if(type == (AnchorGiftReportEntity).toString()){
			return AnchorGiftReportEntity.fromJson(json) as M;
		}
		if(type == (AnchorLabelEntity).toString()){
			return AnchorLabelEntity.fromJson(json) as M;
		}
		if(type == (AnchorListEntity).toString()){
			return AnchorListEntity.fromJson(json) as M;
		}
		if(type == (AnchorListModelEntity).toString()){
			return AnchorListModelEntity.fromJson(json) as M;
		}
		if(type == (AnnouncementEntity).toString()){
			return AnnouncementEntity.fromJson(json) as M;
		}
		if(type == (AppActivityEntity).toString()){
			return AppActivityEntity.fromJson(json) as M;
		}
		if(type == (AudienceOnlineEntity).toString()){
			return AudienceOnlineEntity.fromJson(json) as M;
		}
		if(type == (BankListEntity).toString()){
			return BankListEntity.fromJson(json) as M;
		}
		if(type == (BannerEntity).toString()){
			return BannerEntity.fromJson(json) as M;
		}
		if(type == (BetRecordEntity).toString()){
			return BetRecordEntity.fromJson(json) as M;
		}
		if(type == (CarListEntity).toString()){
			return CarListEntity.fromJson(json) as M;
		}
		if(type == (ChannelListEntity).toString()){
			return ChannelListEntity.fromJson(json) as M;
		}
		if(type == (ChannelListDate).toString()){
			return ChannelListDate.fromJson(json) as M;
		}
		if(type == (ChargeRecordEntity).toString()){
			return ChargeRecordEntity.fromJson(json) as M;
		}
		if(type == (DiamondChargeEntity).toString()){
			return DiamondChargeEntity.fromJson(json) as M;
		}
		if(type == (ExchangeGiftListEntity).toString()){
			return ExchangeGiftListEntity.fromJson(json) as M;
		}
		if(type == (FavoriteEntity).toString()){
			return FavoriteEntity.fromJson(json) as M;
		}
		if(type == (FavoriteNewEntity).toString()){
			return FavoriteNewEntity.fromJson(json) as M;
		}
		if(type == (GiftEntity).toString()){
			return GiftEntity.fromJson(json) as M;
		}
		if(type == (IndexRankEntity).toString()){
			return IndexRankEntity.fromJson(json) as M;
		}

		if(type == (LivingAudienceEntity).toString()){
			return LivingAudienceEntity.fromJson(json) as M;
		}
		if(type == (LivingRoomLotteryEntity).toString()){
			return LivingRoomLotteryEntity.fromJson(json) as M;
		}
		if(type == (LivingTimeSlotEntity).toString()){
			return LivingTimeSlotEntity.fromJson(json) as M;
		}
		if(type == (LotteryRecordEntity).toString()){
			return LotteryRecordEntity.fromJson(json) as M;
		}
		if(type == (PackageGiftEntity).toString()){
			return PackageGiftEntity.fromJson(json) as M;
		}
		if(type == (PointsRedemptionEntity).toString()){
			return PointsRedemptionEntity.fromJson(json) as M;
		}
		if(type == (RankNewEntity).toString()){
			return RankNewEntity.fromJson(json) as M;
		}
		if(type == (SampleUserInfoEntity).toString()){
			return SampleUserInfoEntity.fromJson(json) as M;
		}
		if(type == (ShareAppLinkEntity).toString()){
			return ShareAppLinkEntity.fromJson(json) as M;
		}
		if(type == (SystemBankEntity).toString()){
			return SystemBankEntity.fromJson(json) as M;
		}
		if(type == (UpgradeEntity).toString()){
			return UpgradeEntity.fromJson(json) as M;
		}
		if(type == (UserGradeEntity).toString()){
			return UserGradeEntity.fromJson(json) as M;
		}
		if(type == (UserGradeLevelLst).toString()){
			return UserGradeLevelLst.fromJson(json) as M;
		}
		if(type == (UserInfoEntity).toString()){
			return UserInfoEntity.fromJson(json) as M;
		}
		if(type == (UserMessageEntity).toString()){
			return UserMessageEntity.fromJson(json) as M;
		}
		if(type == (WithdrawRecordEntity).toString()){
			return WithdrawRecordEntity.fromJson(json) as M;
		}

		print("$type not found");
	
		return null;
}

  //list is returned by type
	static M? _getListChildType<M>(List<Map<String, dynamic>> data) {
		if(<AccountDetailEntity>[] is M){
			return data.map<AccountDetailEntity>((Map<String, dynamic> e) => AccountDetailEntity.fromJson(e)).toList() as M;
		}
		if(<AnchorGiftReportEntity>[] is M){
			return data.map<AnchorGiftReportEntity>((Map<String, dynamic> e) => AnchorGiftReportEntity.fromJson(e)).toList() as M;
		}
		if(<AnchorLabelEntity>[] is M){
			return data.map<AnchorLabelEntity>((Map<String, dynamic> e) => AnchorLabelEntity.fromJson(e)).toList() as M;
		}
		if(<AnchorListEntity>[] is M){
			return data.map<AnchorListEntity>((Map<String, dynamic> e) => AnchorListEntity.fromJson(e)).toList() as M;
		}
		if(<AnchorListModelEntity>[] is M){
			return data.map<AnchorListModelEntity>((Map<String, dynamic> e) => AnchorListModelEntity.fromJson(e)).toList() as M;
		}
		if(<AnnouncementEntity>[] is M){
			return data.map<AnnouncementEntity>((Map<String, dynamic> e) => AnnouncementEntity.fromJson(e)).toList() as M;
		}
		if(<AppActivityEntity>[] is M){
			return data.map<AppActivityEntity>((Map<String, dynamic> e) => AppActivityEntity.fromJson(e)).toList() as M;
		}
		if(<AudienceOnlineEntity>[] is M){
			return data.map<AudienceOnlineEntity>((Map<String, dynamic> e) => AudienceOnlineEntity.fromJson(e)).toList() as M;
		}
		if(<BankListEntity>[] is M){
			return data.map<BankListEntity>((Map<String, dynamic> e) => BankListEntity.fromJson(e)).toList() as M;
		}
		if(<BannerEntity>[] is M){
			return data.map<BannerEntity>((Map<String, dynamic> e) => BannerEntity.fromJson(e)).toList() as M;
		}
		if(<BetRecordEntity>[] is M){
			return data.map<BetRecordEntity>((Map<String, dynamic> e) => BetRecordEntity.fromJson(e)).toList() as M;
		}
		if(<CarListEntity>[] is M){
			return data.map<CarListEntity>((Map<String, dynamic> e) => CarListEntity.fromJson(e)).toList() as M;
		}
		if(<ChannelListEntity>[] is M){
			return data.map<ChannelListEntity>((Map<String, dynamic> e) => ChannelListEntity.fromJson(e)).toList() as M;
		}
		if(<ChannelListDate>[] is M){
			return data.map<ChannelListDate>((Map<String, dynamic> e) => ChannelListDate.fromJson(e)).toList() as M;
		}
		if(<ChargeRecordEntity>[] is M){
			return data.map<ChargeRecordEntity>((Map<String, dynamic> e) => ChargeRecordEntity.fromJson(e)).toList() as M;
		}
		if(<DiamondChargeEntity>[] is M){
			return data.map<DiamondChargeEntity>((Map<String, dynamic> e) => DiamondChargeEntity.fromJson(e)).toList() as M;
		}
		if(<ExchangeGiftListEntity>[] is M){
			return data.map<ExchangeGiftListEntity>((Map<String, dynamic> e) => ExchangeGiftListEntity.fromJson(e)).toList() as M;
		}
		if(<FavoriteEntity>[] is M){
			return data.map<FavoriteEntity>((Map<String, dynamic> e) => FavoriteEntity.fromJson(e)).toList() as M;
		}
		if(<FavoriteNewEntity>[] is M){
			return data.map<FavoriteNewEntity>((Map<String, dynamic> e) => FavoriteNewEntity.fromJson(e)).toList() as M;
		}
		if(<GiftEntity>[] is M){
			return data.map<GiftEntity>((Map<String, dynamic> e) => GiftEntity.fromJson(e)).toList() as M;
		}
		if(<IndexRankEntity>[] is M){
			return data.map<IndexRankEntity>((Map<String, dynamic> e) => IndexRankEntity.fromJson(e)).toList() as M;
		}
		if(<LivingAudienceEntity>[] is M){
			return data.map<LivingAudienceEntity>((Map<String, dynamic> e) => LivingAudienceEntity.fromJson(e)).toList() as M;
		}
		if(<LivingRoomLotteryEntity>[] is M){
			return data.map<LivingRoomLotteryEntity>((Map<String, dynamic> e) => LivingRoomLotteryEntity.fromJson(e)).toList() as M;
		}
		if(<LivingTimeSlotEntity>[] is M){
			return data.map<LivingTimeSlotEntity>((Map<String, dynamic> e) => LivingTimeSlotEntity.fromJson(e)).toList() as M;
		}
		if(<LotteryRecordEntity>[] is M){
			return data.map<LotteryRecordEntity>((Map<String, dynamic> e) => LotteryRecordEntity.fromJson(e)).toList() as M;
		}
		if(<PackageGiftEntity>[] is M){
			return data.map<PackageGiftEntity>((Map<String, dynamic> e) => PackageGiftEntity.fromJson(e)).toList() as M;
		}
		if(<PointsRedemptionEntity>[] is M){
			return data.map<PointsRedemptionEntity>((Map<String, dynamic> e) => PointsRedemptionEntity.fromJson(e)).toList() as M;
		}
		if(<RankNewEntity>[] is M){
			return data.map<RankNewEntity>((Map<String, dynamic> e) => RankNewEntity.fromJson(e)).toList() as M;
		}
		if(<SampleUserInfoEntity>[] is M){
			return data.map<SampleUserInfoEntity>((Map<String, dynamic> e) => SampleUserInfoEntity.fromJson(e)).toList() as M;
		}
		if(<ShareAppLinkEntity>[] is M){
			return data.map<ShareAppLinkEntity>((Map<String, dynamic> e) => ShareAppLinkEntity.fromJson(e)).toList() as M;
		}
		if(<SystemBankEntity>[] is M){
			return data.map<SystemBankEntity>((Map<String, dynamic> e) => SystemBankEntity.fromJson(e)).toList() as M;
		}
		if(<UpgradeEntity>[] is M){
			return data.map<UpgradeEntity>((Map<String, dynamic> e) => UpgradeEntity.fromJson(e)).toList() as M;
		}
		if(<UserGradeEntity>[] is M){
			return data.map<UserGradeEntity>((Map<String, dynamic> e) => UserGradeEntity.fromJson(e)).toList() as M;
		}
		if(<UserGradeLevelLst>[] is M){
			return data.map<UserGradeLevelLst>((Map<String, dynamic> e) => UserGradeLevelLst.fromJson(e)).toList() as M;
		}
		if(<UserInfoEntity>[] is M){
			return data.map<UserInfoEntity>((Map<String, dynamic> e) => UserInfoEntity.fromJson(e)).toList() as M;
		}
		if(<UserMessageEntity>[] is M){
			return data.map<UserMessageEntity>((Map<String, dynamic> e) => UserMessageEntity.fromJson(e)).toList() as M;
		}
		if(<WithdrawRecordEntity>[] is M){
			return data.map<WithdrawRecordEntity>((Map<String, dynamic> e) => WithdrawRecordEntity.fromJson(e)).toList() as M;
		}

		print("${M.toString()} not found");
	
		return null;
}

  static M? fromJsonAsT<M>(dynamic json) {
		if(json == null){
			return null;
		}		if (json is List) {
			return _getListChildType<M>(json.map((e) => e as Map<String, dynamic>).toList());
		} else {
			return _fromJsonSingle<M>(json as Map<String, dynamic>);
		}
	}
}