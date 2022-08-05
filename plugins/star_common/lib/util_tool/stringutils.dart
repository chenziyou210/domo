class StringUtils {
  //超过1万转
  static String showNmberOver10k(int? number) {

    int? tempNumber = number;
    var key ;
    if(tempNumber == null){
      key = "";

    }else{
      if (tempNumber >= 999999999){
        key = "9999.9w";
      }else{
        key = tempNumber >= 10000
            ? "${(tempNumber / 10000).toStringAsFixed(1)}w"
            : "$tempNumber";
      }
    }
    return key;
  }
}
