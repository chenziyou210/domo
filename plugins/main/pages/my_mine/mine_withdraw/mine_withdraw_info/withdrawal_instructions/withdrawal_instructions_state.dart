/// @description:
/// @author
/// @date: 2022-07-23 16:22:49
class WithdrawalInstructionsState {
  WithdrawalInstructionsState() {
    ///Initialize variables
  }
  String content = """1.提现时需绑定您有效的收款信息，请核实您的填写的信息无误。
2.提现条件：打码量为0时，可进行提现行为，打码量不为0时，不可以进行提现。

打码量指在平台消费的金额，可以为游戏中的有效投注金额数及直播消费金额数
列如：您充值了100元，需要您游戏娱乐投注100元或以上金额，也可以兑换为钻石进行消费，当消费金额满足时，方可提现。
因存在系统结算时间，请以当前打码量为准。

备注：禁止在本平台进行洗黑钱，恶意套利等行为，如发现将永久封号处理。""";
}
