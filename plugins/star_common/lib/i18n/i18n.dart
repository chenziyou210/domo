/*
 *  Copyright (C), 2015-2021
 *  FileName: i18n
 *  Author: Tonight丶相拥
 *  Date: 2021/7/14
 *  Description: 
 **/

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppInternational extends WidgetsLocalizations {

  @override
  // TODO: implement textDirection
  TextDirection get textDirection => TextDirection.ltr;

  /// 当前
  static AppInternational current = $zh_CN();

  static const GeneratedLocalizationsDelegate delegate = GeneratedLocalizationsDelegate();

  static AppInternational of(BuildContext context) =>
      Localizations.of<AppInternational>(context, AppInternational)!;

  // 跟随系统
  String get autoBySystem => "Auto";
  String get period => "Period";
  String get autoGetBackHomePage => "Auto Get Back Home Page";
  String get dataEmpty => "Data Empty";
  String get noble => "Noble";
  String get grade => "Grade";
  String get redeem => "Points redemption";
  String get activity => "Activity";
  String get promote => "Promote";
  String get news => "News";
  String get list => "List";
  String get favoriteList => "Favorite List";
  String get fansList => "Fans List";
  String get billing => "Billing";
  String get game => "Game";
  String get openLiveNotify => "broadcast reminder";
  String get approve => "Approve";
  String get backpack => "Backpack";
  String get service => "service";
  String get setting => "Setting";
  String get pointsMall => "Points Mall";
  String get point => "Points";
  String congratulationOnGettingCoins(dynamic value) => "Congratulations on getting $value coins";
  String get useInstruction => "Instructions for use";
  String get givingCoinsInstruction => "1. The gold coins given can only be used for games and cannot be used for gifts. The running water is enough. Five times the amount of gold coins that can be withdrawn.";
  String get known => "Known";
  String get wallet => "Wallet";
  String get withdraw => "Withdraw";
  String get attention => "Attention";
  String get someOneMentionedMe => "Some one mentioned me";
  String get attentionSuccess => "Attention Success";
  String get attentionLivingRoom => "Attention Living Room";
  String get enterLivingRoom => "Enter Living Room";
  String get fans => "Fans";
  String get search => "Search";
  String get query => "Query";
  String get popular => "Popular";
  String get nearby => "Nearby";
  String get following => "Following";
  String get follow => "Follow";
  String get followed => "Followed";
  String get followers => "Followers";
  String get contributionList => "Contribution list";
  String get contribution => "Contribution";
  String get obtain => "Obtain";
  String get noGift => "No gift";
  String get gift => "Gift";
  String get givingSuccess => "giving success";
  String get price => "Price";
  String get personalInformation => "Personal information";
  String get chargeNotes => "转账时请填写正确的金额。存款金额范围 50,000 VND - 50,00,000 VND 输入号码钱并以 000 结尾";
  String get memberID => "Member ID";
  String get constellation => "Constellation";
  String get profession => "Profession";
  String get homeTown => "homeTown";
  String get feeling => "Feeling";
  String get signature => "Signature";
  String get otherInformation => "Other information";
  String get sendOut => "Send out";
  String get rogerThat => "Roger that";
  String get sayHi => "Say hi";
  String get message => "Message";
  String get invalidateMessage => "Invalidate arguments";
  String get messageCenter => "Message Center";
  String get edit => "Edit";
  String get editProfile => "EditProfile";
  String get avatar => "Avatar";
  String get name => "Name";
  String get quote => "Quote";
  String get signUpWith => "Sign Up With";
  String get invitationCode => "Invitation Code";
  String get exclusiveDownloadLine =>"Exclusive Download Line";
  String get your => "Your";
  String get copyExclusiveDownloadLine => "Copy the exclusive download link and download the app";
  String get yourExclusiveInvitationCode => "Your Exclusive Invitation Code";
  String get enterInvitationCodeForReward => "Enter Invitation Code For Reward";
  String get hotGame => "Hot Game";
  String get account => "Account";
  String get phoneNumber => "Phone Number";
  String get gender => "Gender";
  String get birthday => "Birthday";
  String get male => "Male";
  String get female => "Female";
  String get unknown => "Unknown";
  String get promotionOfTheAgent => "Promotion Of The Agent";
  String get year => "Year";
  String get month => "Month";
  String get day => "Day";
  String get daily => "Daily";
  String get monthly => "Monthly";
  String get weekly => "Weekly";
  String get accountSecurity => "Account security";
  String get protected => "Protected";
  String get blacklist => "Blacklist";
  String get appLock => "App lock";
  String get language => "Language";
  String get paymentPassword => "Payment password";
  String get stealthPrivilege => "Stealth privilege";
  String get checkForUpdates => "Check for updates";
  String get switchAccount => "Switch account";
  String get dropOut => "Drop out";
  String get recording => "recording";
  String get record => "record";
  String get exchangeRecord => "Exchange record";
  String get redeemGift => "Redeem gifts";
  String get consumePoints => "Consume points";
  String get exchangeTime => "Exchange time";
  String get platformGift => "platform gift";
  String get pointSpecial => "Points Special";
  String get lotteryCountDown => "lottery CD";
  String get lotteryRecord => "Lottery Record";
  String get isLogOut => "Is Log Out?";
  String get recharge => "Recharge";
  String get balance => "gold coin balance";
  String get myDiamond => "My diamond";
  String get exchange => "Exchange";
  String get changeLanguage => "Change Language";
  String get recommendYouToUseABackCardToPay => "Recommend you to use a bank card to pay";
  String get diamond => "Diamond";
  String get validateDate => "Validate Date";
  String get bindBankCard => "Bind bank card";
  String get amount => "Amount";
  String get amount100IsInteger => "Amount≥100,Is an integer";
  String get pleaseEnter => "Please enter";
  String get pleaseEnter1 => "please enter";
  String get submitFeedback => "Submit Feedback";
  String get submitSuccess => "Submit Success";
  String get submit => "Submit";
  String get pleaseEnterLivingTitle => "Please Enter Living Title";
  String get maximum => "maximum";
  String get codeAmount => "Code amount";
  String get confirm => "CONFIRM";
  String get confirm1 => "Confirm";
  String get wager=> "Wager";
  String get confirmWager => "Confirm Wager";
  String get withdrawInstructions => "Withdrawal instructions";
  String get gameInstruction => "Game Instruction";
  String get withdrawInstructionsContent => """
1.Withdraw cash from 100；
2.The handling fee is 1% of the exchange amount；
3.It is recommended to bind major banks and commercial 
banks；
4.After the withdrawal is successful, the arrival time is 1-15
minutes；
5.Withdrawal from 0-1 o'clock every day will be delayed。
  """;
  String get homeSearchHint => "Please input userId and nick ";
  String get withdrawTo => "Withdraw to";
  String get bind => "BIND";
  String get cardHolder => "cardholder";
  String get bankCardNumber => "Bank card number";
  String get bankName => "Bank Name";
  String get bankAccount => "Bank account";
  String get accountOpeningBranch => "Account opening branch";
  String get cannotBeModifiedAfterBinding => "Cannot be modified after binding";
  String get id => "ID";
  String get hitting => "Hitting";
  String get home => "Home";
  String get tab1 => "Game";
  String get tab2 => "Recharge";
  String get userMessage => "Msg";
  String get mine => "Mine";
  String get followTheAnchor => "Follow the anchor";
  String get starList => "Anchor list";
  String get richList => "Rich List";
  String get followAndExit => "Follow and exit";
  String get recommendYouToUseABankCardToPay => "Recommend you to use a bank card to pay";
  String get pleaseSelectPaymentChannel => "Please Select Payment Channel";
  String get bankTransfer => "Bank transfer";
  String get rechargeAmount => "Recharge amount";
  String get cardNumber => "Card number";
  String get payee => "Payee";
  String get payWay => "Pay Way";
  String get branch => "Branch";
  String get rechargeRewards => "Recharge rewards";
  String get remittance => "Remittance";
  String get contactCustomerService => "Contact Customer Service";
  String get confirmRecharge => "CONFIRM RECHARGE";
  String get customerServiceInsteadOfRecharge => "Customer service instead of recharge";
  String get customService => "Customer service";
  String get carList => "Car List";
  String get superCarMonthMember => "Super Car Month Member";
  String get superCarJiDuMember => "Super Car Three Month Member";
  String get superCarYearMember => "Super Car Year Member";
  String get customServiceGroup => "Customer Service Group";
  String get cs => "CS7*24";
  String get note => "Note";
  String get winPrize => "winPrize";
  String get waitingForPay => "Waiting For Pay";
  String get alreadyPay => "Already Pay";
  String get applying => "Applying";
  String get withdrawSuccess => "Withdraw Success";
  String get withdrawFailure => "Withdraw Failure";
  String get noteContent => """A text introduction, 
please fill in the correct amount, thank you!""";
  String get pleaseSelectTheRechargeAmount => "Please select the recharge amount";
  String get guard => "Guard";
  String get recommend => "Recommend";
  String get save => "Save";
  String get capricorn => "Capricorn";
  String get aquarius => "Aquarius";
  String get pisces => "Pisces";
  String get aries => "Aries";
  String get taurus => "Taurus";
  String get gemini => "Gemini";
  String get cancer => "Cancer";
  String get leo => "Leo";
  String get virgo => "Virgo";
  String get libra => "Libra";
  String get scorpio => "Scorpio";
  String get sagittarius => "Sagittarius";
  String get done => "Done";
  String get copySuccess => "Copy Success";
  String get success => "Success";
  String get distanceAnchor => "Distance Anchor";
  String get copy => "Copy";
  String get invitationDescription => "When others use your invitation code, you can get corresponding rewards, which can be used for betting in the live studio, giving gifts, and so on";
  String get forgetToSign => "Forgot to sign";
  String get remove => "Remove";
  String get live => "live";
  String get packageName => "YYlive";
  String get package => "Package";
  String get willMeetYouSoon => "Will Meet You Soon";
  String get scanCodeDownload => "Scan the code or copy the link to the browser to download the APP";
  String get pleaseEnterAmount => "Please Enter Amount";
  String get pleaseChooseOpeningBank => "please choose opening bank";
  String get pleaseChooseChannel => "please choose channel";
  String get nameEmptyPleaseCheck => "name empty, please check";
  String get onlineBankEmptyPleaseCheck => "onlineBankAccount empty, please check";
  String get confirmAccountEmptyPleaseCheck => "confirmAccount empty, please check";
  String get confirmAccountNotEqualOnlineBackAccount => "confirmAccount required equal onlineBankAccount";
  String get pleaseChooseBank => "please choose bank";
  String get pleaseEnterWithdrawMoney => "please enter withdraw amount";
  String get pleaseEnterWithdrawPassword => "please enter withdraw password";
  String get pleaseChoose => "please choose";
  String get living => "Living";
  String get offLine => "OffLine";
  String get $of => "Of";
  String get forbidden => "Forbidden";
  String get finish => "Finish";
  String get giving => "giving";
  String get logIn => "LogIn";
  String get forget => "Forget";
  String get forgetPassword => "Forget Password";
  String get retrievePassword => "Retrieve Password";
  String get register => "Register";
  String get pleaseInputAccount => "Please Input Phone";
  String get pleaseInputPassword => "Please Input Password";
  String get notice => "Notice";
  String get cancel => "Cancel";
  String get cancelFavorite => "Cancel Favorite";
  String get iKnowYourSoulBestAndWillMeetYouSoon => "I know your soul best and will meet you soon";
  String get logOut => "Log Out";
  String get isSwitchAccount => "Is Switch Account?";
  String get cover => "Cover";
  String get roomNameEmpty => "Room Name Empty";
  String get startLive => "Start Live";
  String get startTime => "Start Time";
  String get endTime => "End Time";
  String get pleaseEnterTitleGetMoreFans => "Please Enter Title Attract More Fans...";
  String get more => "More";
  String get beauty => "Beauty";
  String get virtualWaiting => "Virtual Waiting";
  String get pleaseEnterPassword => "Please Enter Password";
  String get pleaseEnterTimer => "Please Enter Timer";
  String get pleaseEnterTicket => "Please Enter Ticket";
  String get pleaseEnterGame => "Please Enter Game";
  String get chats => "Chats";
  String get givingLiverGift => "Giving Liver Gift Worth";
  String get followEachOtherToBecomeFriends => "Follow each other to become friends。";
  String get gallery => "gallery";
  String get camera => "Camera";
  String get liverNotOnLine => "Liver Not On Line";
  String get doublePasswordIsDiffer => "Double Input Password Is Differ";
  String get pleaseEnterChargeAmount => "Please Enter Charge Amount";
  String get rechargeSuccess => "Recharge Success";
  String get skip => "Skip";
  String get oneHour => "one Hour";
  String get oneMinute => "one minute";
  String get oneDay => "one Day";
  String get forever => "forever";
  String get mute => "mute";
  String get muting => "muting";
  String get betMustBigger200 => "Bet At Last 200";
  String get mutingList => "Muting List";
  String get modifyLoginPassword => "Modify login password";
  String get changePaymentPassword => "Change payment password";
  String get logInToTheDevice => "Log in to the device";
  String get oldPassword => "Old Password";
  String get newPassword => "New Password";
  String get buy => "Buy";
  String get originalPayPassword => "Original Pay Password";
  String get newPayPassword => "New Pay Password";
  String get setPayPassword => "Set Pay Password";
  String get originalLogInPassword => "Original LogIn Password";
  String get newLogInPassword => "New LogIn Password";
  String get confirmAgain => "Confirm Again";
  String get email => "Email";
  String get enter => "Enter";
  String get selectMagnification => "Select magnification";
  String get dn => "DN";
  String get chargeChannel => "Charge Channel";
  String get goToCharge => "Go To Charge";
  String get chargeAmount => "ChargeAmount";
  String get notes => "Notes";
  String get explain => "Explain";
  String get bindingBank => "Binding Bank";
  String get chooseBank => "Choose Bank";
  String get enterAccount => "Enter Account";
  String get confirmAccount => "Confirm Account";
  String get openingBank=> "Opening Bank";
  String get onlineBankAccount => "Online Bank Account";
  String get bindingNow => "Binding Now";
  String get nowPrice => "Now Price";
  String get orgPrice => "Original Price";
  String get jiDu => "Three Month";
  String get onlineManager => "Online Bank Manager";
  String get unBinding => "UnBinding";
  String get complete => "Complete";
  String get customMul => "Custom Mul";
  // String get newVersionPreemptiveExperience => "New version preemptive experience";
  String get newVersionPreemptiveExperience => "New Version";
  String get versionNumber => "Version Number";
  String get delete => "Delete";
  String get addNewBank => "Add New Online Bank";
  String get addBank => "Add Bank";
  String get changeAccount => "Change Account";
  String get amountMoney => "Amount money";
  String get money => "Money";
  String get enterWithdrawMoney => "Enter Withdraw Money";
  String get availableWithdrawMoney => "Available withdraw money";
  String get withdrawMoney => "Withdraw Money";
  String get all => "All";
  String get nobleStealthSwitch => "Noble Stealth Switch";
  String get enterIncognito => "Enter Incognito";
  String get giftEffectSwitch => "gift effect switch";
  String get carSpecialEffectSwitch => "car special effect switch";
  String get soundSwitch => "sound switch";
  String get smallWindowSwitch => "small window switch";
  String get livingClose => "Do you want to close the live stream?";
  String get pointDescription => "Points Description";
  String get pointDescriptionDetail => """
1. Points can only be obtained through diamond recharge, 1 diamond is equal to 1 point.

2. The points obtained can be exchanged for gifts in the points mall. After the redemption is successful, they will be placed in Backpack (gift in the live broadcast room), used to give gifts to the anchor.
  """;
  String get close => "Close";
  String get labelCategory => "Tags";
  String get rechargeReBate => "Recharge Rebate";
  String get doubleTheFirstCharge => "Double The First Charge";
  String get goToRecharge => "Go To Recharge";
  String get shareLink => "Share Link";
  String get pleaseAuthorizeSaveToPhoto => "Please authorize to save the image to the album";
  String get anchorNickname => "Anchor Nickname";
  String get hostRoomNumber => "Host Room Number";
  String get roomLink => "Room Link";
  String get copyRoomLink => "Copy Room Link";
  String get copyLink => "Copy Link";
  String get saveToLocal => "Save To Local";
  String get filter => "Filter";
  String get orderNumber => "Order Number";
  String get number => "Number";
  String get inAllOnesLife => "In All Ones Life";
  String get iLoveYou => "I Love You";
  String get wantToHug => "Want To Hug";
  String get sixSixLucky => "Lucky";
  String get perfect => "Perfect";
  String get undividedAttention => "Undivided Attention";
  String get preferential => "Preferential";
  String get withdrawPassword => "Withdraw password";
  String get accountDetail => "Account Detail";
  String get withdrawRecord => "Withdraw Record";
  String get betRecord => "Bet Record";
  String get betAmount => "Bet Amount";
  String get bet => "Bet";
  String get betSuccess => "Bet Success";
  String get settlementSuccess => "Settlement Success";
  String get downloading => "Downloading";
  String get downloadFailure => "Download Failure";
  String get downloadSuccess => "Download Success";
  String get gainAmount => "Gain Amount";
  String get gain => "Gain";
  String get chargeRecord => "Charge Record";
  String get contactService => "Contact Service";
  String get switchCircuit => "Switch Circuit";
  String get switchLanguage => "Switch Language";
  String get modifyPaymentPassword => "Modify Payment Password";
  String get modifyLogInPassword => "Modify LogIn PassWord";
  String get modifyPasswordSuccess => "Modify Password Success";
  String get pleaseEnterPhoneNumber => "Please Enter Phone Number";
  String get pleaseEnterVerificationCode => "Please Enter Verification Code";
  String get pleaseConfirmPassword => "Please Confirm Password";
  String get send => "Send";
  String get seconds => "Seconds";
  String get imageVerification => "Image Verification";
  String get refresh => "Refresh";
  String get freeWatchRemaining => "Free Watch Remaining";
  String get twoPasswordIsNotSame => "Two Password Is Not Same";
  String get verifyCode => "Verification Code";
  String get confirmPassword => "Confirm Password";
  String get newAnnouncement => "New Announcement";
  String get announcement => "Announcement";
  String get currentGrade => "Current Grade";
  String get experienceValue => "ExpValue";
  String get rangeUpgradeDifference => "RUDiff";
  String get gradeRank => "Grade Rank";
  String get gradeIcon => "Grade Icon";
  String get gradeExperience => "Grade Experience";
  String get pleaseSettingWatchVipGrade => "Please Set Up Watch Vip Grade";
  String get pleaseEnterExpenseDiamondNumber => "Expense Diamond Number";
  String get pleaseEnterTimerMinute => "Free Watch Timer/S";
  String get liveCoverIsUploading => "Live Cover Is Uploading";
  String get pleaseUploadLiveCover => "Please Upload Live Cover";
  String get rank => "Rank";
  String get onlineAudienceNumber => "Online Number";
  String get setLivingManager => "Set Living Manager";
  String get isMuting => "Is Muting";
  String get low => "Low";
  String get normal => "Normal";
  String get high => "High";
  String get lighteningContrastLevel => "Lightening Contrast Level";
  String get lighteningLevel => "Lightening Level";
  String get smoothnessLevel => "Smoothness Level";
  String get rednessLevel => "Redness Level";
  String get giftReport => "Gift Report";
  String get livingTimeSlot => "Living Time Slot";
  String get aboutUS => "About US";
  String get helpAndFeedback => "Help And Feedback";
  String get clean => "Clean";
  String get betLimit => "Bet Limit";
  String get totalAssets => "Total Assets";
  String get totalConsumption => "Gift Total Consumption";
  String get totalWithdraw => "Total Withdraw";
  String get totalCharge => "Total Charge";
  String get getTogether => "GetTogether";
  String get state => "State";
  String get anchorOffline => "Anchor Offline";
  String get enterRoomFailurePleaseCheckBalanceOrNetworkOrCircuit => "Enter Room Failure Please Check Balance、Network、Circuit And So On";
  String get time => "Time";
  String get giftGainAmount => "Gift Gain Amount";
  String get updateContent => "Update Content";
  String get update => "Update";
  String get notNow => "Not Now";
  String get standInsideLetter => "Stand Inside Letter";
  String get welcomeTo => "Welcome to";
  String get initializeMessage => """
  recharge now Send 500K to get vip3 to chat with Idol. 1. Online recharge channels lead to unstable recharge, so it is recommended to pass Recharge by bank transfer. If you have any questions, please contact customer service.""";
  String get livingRoom => "Living room";
  String get initializeMessage1 => "system";
  String get gameStart => "They're already betting. Let's do it Note!!!!";
  String get gameStart1 => "gameStart";
  String get congratulation => "Congratulation";
  String get at => "At";
  String get inThePlay => "In The Play";
  String get user => "User";
  String get use => "Use";
  String get using => "Using";
  String get alreadyBet => "Already Bet";
  String get switchWay => "Switch Way";
  String get delay => "Delay";
  String get circuit => "Circuit";
  String get commonRoom => "Common Room";
  String get gameRoom => "Game Room";
  String get timerRoom => "Timer Room";
  String get ticketRoom => "Ticket Room";
  String get vip => "Vip";
  String get enterRoom => "Enter Room";


  String get rechargeCentre => "Recharge centre";
  String get information => "Information:";
  String get redeemDiamonds => "Redeem diamonds";
  String get changeDiamonds => "change ";
  String get selectPaymentChannel=> "Please select a payment channel";
  String get selectRechargeAmount=> "Please select the recharge amount";
  String get selectLoginMethod=> "Please select a login method";
  String get selectDetailsLogin=> "Registered members, please select mobile phone to log in\n"
      "For account security, it is recommended to use a mobile phone to register";
  String get guestLogin=> "Guest login";
  String get mobileLoginRegistration=> "Mobile login/registration";
  String get exitApp=> "Press again to exit";

  String get activityCenter => "Activity Center";
  String get activityCenterAdvert => "more activities and discounts";
  String get promotionAdvert => "Million monthly income";
  String get phoneVerify => "PhoneVerify";
  String get myBag => "MyBag";
  String get customerService => "CustomerService";
  String get balanceDetail => "BalanceDetail";
  String get gameRecord => "GameRecord";
  String get bobiWallet => "bobiWallet";

  String get deposit => "deposit";
  String get discount => "discount";
  String get recommended => "Recommended for you";

  String get firepower => "firepower";

  String get dailyList => "Daily list";
  String get weeklyList => "Weekly list";
  String get monthlyList => "Monthly list";
  String get overallList => "Overall list";
  String get privilege => "privilege";

  String ticketLivingRoom(String coins){
    return "Anchor Open Ticket Living Room, $coins Coins/Every Living, Is Get Into?";
  }
  String timerLivingRoom(String coins){
    return "Anchor Open Timer Living Room, $coins Coins/Minutes, Is Get Into?";
  }
}

class $en extends AppInternational {
  $en();
}

class $zh_CN extends AppInternational {
  $zh_CN();

  @override
  TextDirection get textDirection => TextDirection.ltr;
  String get changeDiamonds => "兑换";
  String get homeSearchHint => "输入主播ID或昵称";
  String get autoBySystem => "跟随系统";
  String get noble => "贵族";
  String get grade => "等级";
  String get activity => "活动";
  String get promote => "推销";
  String get news => "新闻";
  String get list => "排行";
  String get billing => "账单";
  String get game => "游戏";
  String get openLiveNotify => "开播提醒";
  String get redeem => "积分兑换";
  String get approve => "许可";
  String get backpack => "空间";
  String get service => "服务";
  String get setting => "设置";
  String get pointsMall => "积分商城";
  String get point => "积分";
  String congratulationOnGettingCoins(dynamic value) => "恭喜您获得 $value 金币";
  String get useInstruction => "使用说明";
  String get givingCoinsInstruction => """1. 赠送的金币 只能用于游戏 不能刷礼物 流水打够五倍才能提现赠送的金币.""";
  String get known => "已知晓";
  String get wallet => "钱包";
  String get withdraw => "提现";
  String get fans => "粉丝";
  String get attention => "关注";
  String get someOneMentionedMe => "有人提到我";
  String get search => "搜索";
  String get popular => "推荐";
  String get nowPrice => "现价";
  String get orgPrice => "原价";
  String get jiDu => "季";
  String get quote => "引用";
  String get exclusiveDownloadLine =>"专属下载链接";
  String get your => "你的";
  String get copyExclusiveDownloadLine => "复制专属下载链接，下载APP";
  String get nearby => "附近";
  String get following => "关注";
  String get followers => "追随者";
  String get contributionList => "贡献榜";
  String get noGift => "还未收到礼物";
  String get personalInformation => "个人信息";
  String get memberID => "成员ID";
  String get constellation => "星座";
  String get profession => "职业";
  String get confirm1 => "确认";
  String get homeTown => "家乡";
  String get feeling => "情感";
  String get signature => "签名";
  String get otherInformation => "其他信息";
  String get sendOut => "送出";
  String get rogerThat => "收到";
  String get sayHi => "说点好听的";
  String get message => "发消息";
  String get edit => "编辑";
  String get editProfile => "编辑资料";
  String get avatar => "头像";
  String get account => "账号";
  String get name => "姓名";
  String get signUpWith => "使用三方登录";
  String get gender => "性别";
  String get birthday => "生日";
  String get male => "男";
  String get female => "女";
  String get unknown => "未知";
  String get year => "年";
  String get month => "月";
  String get day => "日";
  String get followed => "已关注";
  String get daily => "每日";
  String get monthly => "每月";
  String get weekly => "每周";
  String get accountSecurity => "账户安全";
  String get protected => "保护中";
  String get blacklist => "黑名单";
  String get appLock => "app锁定";
  String get winPrize => "中奖";
  String get language => "语言";
  String get paymentPassword => "支付密码";
  String get stealthPrivilege => "隐私特权";
  String get checkForUpdates => "检查更新";
  String get switchAccount => "切换账号";
  String get dropOut => "离开";
  String get recording => "记录";
  String get recharge => "充值";
  String get balance => "金币余额";
  String get myDiamond => "我的钻石";
  String get exchange => "兑换";
  String get recommendYouToUseABackCardToPay => "建议您使用银行卡支付";
  String get diamond => "钻石";
  String get bindBankCard => "绑定银行卡";
  String get amount => "金额";
  String get roomNameEmpty => "房间名为空";
  String get amount100IsInteger => "金额大于100为整数";
  String get pleaseEnter => "请输入";
  String get pleaseEnter1 => "请输入";
  String get maximum => "全部";
  String get codeAmount => "总数";
  String get confirm => "确认";
  String get carList => "坐骑列表";
  String get withdrawInstructions => "提现说明";
  String get gameInstruction => "游戏说明";
  String get withdrawTo => "提现到";
  String get bind => "绑定";
  String get cardHolder => "持卡人";
  String get bankCardNumber => "银行卡号";
  String get bankAccount => "银行账户";
  String get accountOpeningBranch => "开户行分行";
  String get cannotBeModifiedAfterBinding => "绑定后无法修改";
  String get hitting => "点击数";
  String get home => "首页";
  String get tab1 => "游戏";
  String get validateDate => "有效期";
  String get tab2 => "充值";
  String get userMessage => "消息";
  String get mine => "我的";
  String get followTheAnchor => "关注主播不迷路~";
  String get followAndExit => "关注并退出";
  String get recommendYouToUseABankCardToPay => "推荐使用银行卡支付";
  String get pleaseSelectPaymentChannel => "请选择支付方式";
  String get bankTransfer => "银行卡转账";
  String get rechargeAmount => "充值范围";
  String get cardNumber => "卡号";
  String get payee => "收款人";
  String get branch => "支行";
  String get rechargeRewards => "充值奖励";
  String get remittance => "汇款";
  String get contactCustomerService => "联系客服";
  String get confirmRecharge => "确认充值";
  String get customerServiceInsteadOfRecharge => "客服代充";
  String get customService => "客服";
  String get customServiceGroup => "客服群组";
  String get note => "注意";
  String get noteContent => "请填写正确的金额，谢谢！";
  String get pleaseSelectTheRechargeAmount => "请选择充值金额";
  String get guard => "守护";
  String get recommend => "推荐";
  String get save => "保存";
  String get capricorn => "摩羯座";
  String get aquarius => "水瓶座";
  String get pisces => "双鱼座";
  String get aries => "白羊座";
  String get taurus => "金牛座";
  String get gemini => "双子座";
  String get cancer => "巨蟹座";
  String get leo => "狮子座";
  String get virgo => "处女座";
  String get pleaseEnterAmount => "请输入金额";
  String get pleaseChooseOpeningBank => "选择开户行";
  String get pleaseChooseChannel => "请选择渠道";
  String get nameEmptyPleaseCheck => "姓名为空，请检查";
  String get onlineBankEmptyPleaseCheck => "网银为空，请检查";
  String get confirmAccountEmptyPleaseCheck => "确认账号为空，请检查";
  String get confirmAccountNotEqualOnlineBackAccount => "两次输入账号不一致";
  String get pleaseChooseBank => "请选银行";
  String get pleaseEnterWithdrawMoney => "请输入取款金额";
  String get pleaseEnterWithdrawPassword => "请输入提现密码";
  String get pleaseChoose => "请选择";
  String get attentionSuccess => "关注成功";
  String get libra => "天秤座";
  String get chargeNotes => "转账时请填写正确的金额。存款金额范围 50,000 VND - 50,00,000 VND 输入号码钱并以 000 结尾";
  String get scorpio => "天蝎座";
  String get sagittarius => "射手座";
  String get done => "完成";
  String get copySuccess => "复制成功";
  String get success => "成功";
  String get distanceAnchor => "距离主播";
  String get forgetToSign => "忘记签名";
  String get remove => "移除";
  String get live => "开始直播";
  String get package => "背包";
  String get willMeetYouSoon => "即将与你相遇";
  String get scanCodeDownload => "扫码或复制链接到浏览器都可 下载APP";
  String get giving => "赠送";
  String get logIn => "登录";
  String get forget => "忘记密码";
  String get register => "注册";
  String get pleaseInputAccount => "请输入手机号";
  String get pleaseInputPassword => "请输入密码";
  String get notice => "提示";
  String get cancel => "取消";
  String get isSwitchAccount => "是否切换账号?";
  String get cover => "封面";
  String get startLive => "开始直播";
  String get pleaseEnterTitleGetMoreFans => "请输入标题更吸引粉丝哦...";
  String get beauty => "美化";
  String get virtualWaiting => "虚拟待位";
  String get pleaseEnterPassword => "请输入密码";
  String get pleaseEnterTimer => "请输入分时收费";
  String get pleaseEnterTicket => "请输入门票";
  String get pleaseEnterGame => "请输入游戏";
  String get chats => "聊天";
  String get followEachOtherToBecomeFriends => "相互关注成为朋友吧";
  String get follow => "关注";
  String get gallery => "相册";
  String get more => "更多";
  String get $of => "的";
  String get camera => "相机";
  String get liverNotOnLine => "主播暂不在线~~";
  String get doublePasswordIsDiffer => "两次输入密码不一致";
  String get pleaseEnterChargeAmount => "请输入充值金额";
  String get rechargeSuccess => "充值成功";
  String get skip => "跳过";
  String get oneHour => "一小时";
  String get oneMinute => "一分钟";
  String get oneDay => "一天";
  String get use => "使用";
  String get using => "使用中";
  String get enterInvitationCodeForReward => "填写邀请码得奖励";
  String get forever => "永久";
  String get mute => "禁言";
  String get muting => "禁言中";
  String get mutingList => "禁言列表";
  String get modifyLoginPassword => "修改登录密码";
  String get changePaymentPassword => "修改支付密码";
  String get logInToTheDevice => "当前登录设备";
  String get oldPassword => "旧密码";
  String get newPassword => "新密码";
  String get confirmAgain => "确认新密码";
  String get email => "邮箱";
  String get enter => "输入";
  String get enterRoom => "进入房间";
  String get betMustBigger200 => "每注至少200";
  String get record => "记录";
  String get exchangeRecord => "兑换记录";
  String get redeemGift => "兑换礼物";
  String get consumePoints => "消耗积分";
  String get exchangeTime => "兑换时间";
  String get platformGift => "平台好礼";
  String get pointSpecial => "积分特惠";
  String get lotteryCountDown => "开奖倒计时";
  String get selectMagnification => "选择倍率";
  String get dn => "期号";
  String get chargeChannel => "充值渠道";
  String get goToCharge => "前往充值";
  String get chargeAmount => "充值金额";
  String get notes => "注意";
  String get explain => "说明";
  String get bindingBank => "绑定网银账号";
  String get chooseBank => "选择银行";
  String get enterAccount => "请输入账号";
  String get confirmAccount => "请确认账号";
  String get openingBank=> "开户行";
  String get onlineBankAccount => "网银账号";
  String get bindingNow => "立即绑定";
  String get onlineManager => "网银管理";
  String get unBinding => "解绑";
  String get complete => "完成";
  String get delete => "删除";
  String get addNewBank => "添加新网银";
  String get addBank => "添加账号";
  String get amountMoney => "总余额";
  String get availableWithdrawMoney => "可提现余额";
  String get changeAccount => "更换账号";
  String get withdrawMoney => "提现金额";
  String get all => "全部";
  String get nobleStealthSwitch => "贵族隐身开关";
  String get enterIncognito => "入场隐身";
  String get giftEffectSwitch => "礼物特效开关";
  String get carSpecialEffectSwitch => "座驾特效开关";
  String get soundSwitch => "音效开关";
  String get smallWindowSwitch => "小窗口开关";
  String get livingClose => "是否要关闭直播?";
  String get pointDescription => "积分说明";
  String get invalidateMessage => "非法参数";
  String get pointDescriptionDetail => """
1.积分获取方式只能通过钻石充值，1个钻石等于1积分。

2.所获得的积分可在积分商城兑换礼物，兑换成功后会放入背包(直播间礼物处)，用于给主播刷礼物。
  """;
  String get close => "关闭";
  String get labelCategory => "标签分类";
  String get rechargeReBate => "充值返利";
  String get doubleTheFirstCharge => "首充得双倍";
  String get goToRecharge => "前往充值";
  String get withdrawPassword => "取款密码";
  String get accountDetail => "账户明细";
  String get withdrawRecord => "提现记录";
  String get betRecord => "投注记录";
  String get chargeRecord => "充值记录";
  String get logOut => "退出";
  String get contactService => "联系客服";
  String get forgetPassword => "忘记密码";
  String get changeLanguage => "语言切换";
  String get switchCircuit => "切换线路";
  String get circuit => "线路";
  String get switchLanguage => "语言切换";
  String get gameStart1 => "游戏开始";
  String get modifyPaymentPassword => "修改支付密码";
  String get modifyLogInPassword => "修改登录密码";
  String get pleaseEnterPhoneNumber => "请输入手机号";
  String get pleaseEnterVerificationCode => "请输入6位验证码";
  String get pleaseConfirmPassword => "请确认密码";
  String get send => "发送";
  String get imageVerification => "图片验证";
  String get refresh => "刷新";
  String get twoPasswordIsNotSame => "两次输入的密码不一致";
  String get retrievePassword => "找回密码";
  String get phoneNumber => "手机号";
  String get verifyCode => "验证码";
  String get confirmPassword => "确认密码";
  String get newAnnouncement => "最新公告";
  String get currentGrade => "目前等级";
  String get experienceValue => "经验值";
  String get rangeUpgradeDifference => "距离升级差";
  String get gradeRank => "等级排名";
  String get gradeIcon => "等级图标";
  String get gradeExperience => "等级经验";
  String get contribution => "贡献";
  String get obtain => "获得";
  String get pleaseEnterLivingTitle => "请输入直播标题";
  String get pleaseSettingWatchVipGrade => "请设置观看vip等级";
  String get pleaseEnterExpenseDiamondNumber => "请输入消费钻石数量";
  String get pleaseEnterTimerMinute => "请输入试看时间/秒";
  String get liveCoverIsUploading => "直播封面上传中";
  String get pleaseUploadLiveCover => "请上传直播封面图";
  String get rank => "排行榜";
  String get onlineAudienceNumber => "在线人数";
  String get setLivingManager => "设为管理员";
  String get isMuting => "是否禁言";
  String get low => "低";
  String get normal => "正常";
  String get high => "高";
  String get lighteningContrastLevel => "美白程度";
  String get lighteningLevel => "美白";
  String get smoothnessLevel => "光滑";
  String get rednessLevel => "红润";
  String get giftReport => "礼物报表";
  String get superCarMonthMember => "超级座驾会员月卡";
  String get superCarJiDuMember => "超级座驾会员季卡";
  String get superCarYearMember => "超级座驾会员年卡";
  String get livingTimeSlot => "直播时段";
  String get aboutUS => "关于我们";
  String get helpAndFeedback => "帮助反馈";
  String get clean => "清除缓存";
  String get betLimit => "下注限额";
  String get totalAssets => "总资产";
  String get getTogether => "跟投";
  String get filter => "筛选";
  String get orderNumber => "订单号";
  String get query => "查询";
  String get state => "状态";
  String get bankName => "银行名称";
  String get copy => "复制";
  String get time => "时间";
  String get payWay => "支付方式";
  String get money => "金额";
  String get preferential => "优惠";
  String get betAmount => "下注总额";
  String get gainAmount => "收益总额";
  String get bet => "下注";
  String get gain => "损益";
  String get giftGainAmount => "礼物总收益";
  String get promotionOfTheAgent => "推广代理";
  String get gift => "礼物";
  String get price => "价格";
  String get number => "数量";
  String get startTime => "开始时间";
  String get endTime => "结束时间";
  String get buy => "购买";
  String get goingOn => "进行中";
  String get finish => "结束";
  String get cancelFavorite => "取消关注";
  String get favoriteList => "关注列表";
  String get fansList => "粉丝列表";
  String get originalPayPassword => "原支付密码";
  String get newPayPassword => "新支付密码";
  String get originalLogInPassword => "原登录密码";
  String get newLogInPassword => "新登录密码";
  String get applying => "申请中";
  String get withdrawSuccess => "提现成功";
  String get withdrawFailure => "提现失败";
  String get waitingForPay => "未支付";
  String get alreadyPay => "已支付";
  String get submitFeedback => "提交反馈";
  String get updateContent => "更新内容";
  String get messageCenter => "消息中心";
  String get announcement => "公告";
  String get standInsideLetter => "站内信";
  String get submit => "提交";
  String get welcomeTo => "欢迎来到";
  String get livingRoom => "直播间";
  String get initializeMessage => """
  立即充值送500k获得vip3与idol聊天，温馨提示：1、线上充值渠道导致充值不稳定，建议通过银行转账充值。有任何疑问请联系客服。""";
  String get attentionLivingRoom => "关注了主播";
  String get enterLivingRoom => "来了";
  String get gameStart => "已经开始下注了，赶紧投注吧!!!!";
  String get congratulation => "恭喜";
  String get at => "在";
  String get inThePlay => "玩法中";
  String get user => "用户";
  String get alreadyBet => "已成功下注";
  String get switchWay => "切换线路";
  String get delay => "延迟";
  String get inAllOnesLife => "一生一世";
  String get iLoveYou => "我爱你";
  String get wantToHug => "要抱抱";
  String get sixSixLucky => "六六大顺";
  String get perfect => "十全十美";
  String get undividedAttention => "一心一意";
  String get downloading => "下载中";
  String get commonRoom => "普通房间";
  String get gameRoom => "游戏房间";
  String get timerRoom => "计时收费房间";
  String get ticketRoom => "门票房间";
  String get setPayPassword => "设置支付密码";
  String get enterWithdrawMoney => "输入提现金额";
  String get anchorOffline => "主播离线";
  String get enterRoomFailurePleaseCheckBalanceOrNetworkOrCircuit => "进入房间失败，请检查余额、网络、线路等";
  String get seconds => "秒";
  String get autoGetBackHomePage => "自动返回首页";
  String get dataEmpty => "暂无数据";
  String get givingSuccess => "赠送成功";
  String get period => "期";
  String get wager=> "下注";
  String get confirmWager => "确认下注";
  String get lotteryRecord => "开奖记录";
  String get isLogOut => "是否要退出?";
  String get betSuccess => "下注成功";
  String get starList => "主播榜";
  String get richList => "土豪榜";
  String get newVersionPreemptiveExperience => "新版本抢先体验";
  String get versionNumber => "版本号";
  String get update => "更新";
  String get notNow => "暂不";
  String get downloadFailure => "下载失败";
  String get downloadSuccess => "下载成功";
  String get iKnowYourSoulBestAndWillMeetYouSoon => "最懂你的灵魂，即将与你相遇";
  String get customMul => "自定义倍率";
  String get hotGame => "热门游戏";
  String get givingLiverGift => "赠送主播价值";
  String get vip => "会员";
  String get invitationCode => "邀请码";
  String get yourExclusiveInvitationCode => "你的专属邀请码";
  String get invitationDescription => "当别人使用您的邀请码后，您可获得相应的奖励，可用 于直播间下注、送礼物等";
  String get modifyPasswordSuccess => "密码修改成功";
  String get submitSuccess => "提交成功";
  String get shareLink => "分享连接";
  String get pleaseAuthorizeSaveToPhoto => "请授权保存图像至相册";
  String get anchorNickname => "主播昵称";
  String get hostRoomNumber => "主播房间号";
  String get roomLink => "房间链接";
  String get copyRoomLink => "复制房间链接";
  String get copyLink => "复制连接";
  String get saveToLocal => "保存到本地";
  String get initializeMessage1 => "系统";
  String ticketLivingRoom(String coins){
    return "主播开启了门票房间, $coins 个币/场, 是否进入?";
  }
  String timerLivingRoom(String coins){
    return "主播开启了计时房间, $coins 个币/分钟, 是否进入?";
  }
  String get settlementSuccess => "结算成功";
  String get totalConsumption => "礼物总消费";
  String get totalWithdraw => "总提现";
  String get totalCharge => "总充值";
  String get freeWatchRemaining => "剩余免费观看时间";

  String get rechargeCentre => "充值中心";
  String get information => "消息:";
  String get redeemDiamonds => "兑换钻石";
  String get selectPaymentChannel=> "充值方式";
  String get selectRechargeAmount=> "存款金额";
  String get selectLoginMethod=> "请选择登录方式";
  String get selectDetailsLogin=> "已注册的会员，请选择手机登录\n"
      "为了账户安全，建议使用手机注册";
  String get guestLogin=> "游客登录";
  String get mobileLoginRegistration=> "手机登录/注册";
  String get exitApp=> "再按一次退出";

  String get activityCenter => "活动中心";
  String get activityCenterAdvert => "活动多多，优惠多多";
  String get promotionAdvert => "月入百万不是梦";
  String get phoneVerify => "手机认证";
  String get myBag => "我的背包";
  String get customerService => "专属客服";
  String get balanceDetail => "收支明细";
  String get gameRecord => "游戏记录";
  String get bobiWallet => "波币钱包";

  String get deposit => "存款";
  String get discount => "优惠";
  String get recommended => "为您推荐";

  String get firepower => "火力";

  String get dailyList => "日榜";
  String get weeklyList => "周榜";
  String get monthlyList => "月榜";
  String get overallList => "总榜";
  String get privilege => "特权";



}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<AppInternational> {

  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("zh", "CN"),
      Locale("en", "US"),
    ];
  }

  LocaleListResolutionCallback listResolution({Locale? fallback, bool withCountry = true}) {
    return (List<Locale>? locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported, withCountry);
      }
    };
  }

  LocaleResolutionCallback resolution({required Locale fallback, bool withCountry = true}) {
    return (Locale? locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported, withCountry);
    };
  }

  @override
  Future<AppInternational> load(Locale locale) {
    final String? lang = getLang(locale);
    if (lang != null) {
      switch (lang) {
        case "en":
          AppInternational.current = $en();
          return SynchronousFuture<AppInternational>(AppInternational.current);
        case "zh_CN":
          AppInternational.current = $zh_CN();
          return SynchronousFuture<AppInternational>(AppInternational.current);
        default:
        // NO-OP.
      }
    }
    AppInternational.current = AppInternational();
    return SynchronousFuture<AppInternational>(AppInternational.current);
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale, true);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) {
    return false;
  }

  ///
  /// Internal method to resolve a locale from a list of locales.
  ///
  Locale _resolve(Locale? locale, Locale? fallback, Iterable<Locale> supported, bool withCountry) {
    if (locale == null || !_isSupported(locale, withCountry)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  ///
  /// Returns true if the specified locale is supported, false otherwise.
  ///
  bool _isSupported(Locale? locale, bool withCountry) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        // Language must always match both locales.
        if (supportedLocale.languageCode != locale.languageCode) {
          continue;
        }

        // If country code matches, return this locale.
        if (supportedLocale.countryCode == locale.countryCode) {
          return true;
        }

        // If no country requirement is requested, check if this locale has no country.
        if (true != withCountry && (supportedLocale.countryCode == null || supportedLocale.countryCode!.isEmpty)) {
          return true;
        }
      }
    }
    return false;
  }
}

String? getLang(Locale? l) => l == null
    ? null
    : l.countryCode != null && l.countryCode!.isEmpty
    ? l.languageCode
    : l.toString();