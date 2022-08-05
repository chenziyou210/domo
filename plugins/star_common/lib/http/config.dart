/*
 *  Copyright (C), 2015-2021
 *  FileName: config
 *  Author: Tonight丶相拥
 *  Date: 2021/7/26
 *  Description: 
 **/
/// 开发环境
// const String baseUrl = "https://liveapi.starops.work";
/// 测试环境
const String baseUrl = "https://liveapi-test.gopay00201.com";

const List<String> prepareUrls = [
  "https://liveapi-test.gopay00201.com",
];
// const String baseUrl = "http://192.168.0.18:9531"; //盖盖本地
//const String baseUrl = "http://192.168.0.189:9531"; // 土豆本地

// /api/app/enter/login.no
const String port = "";
// const String baseUrl = "http://192.168.0.52"; //测试服
// const String port = "9531";
///开发服mqtt链接地址
// const String baseMqtt = "47.242.250.147";
///测试服mqtt链接地址
const String baseMqtt = "47.242.175.11";

// 商户号
const String channelNo = "official_0";

// mqtt商户号
const String mqttChannelNo = "8979206";

// 加密用固定拼接字符串
const String encryptSplice = "Msb\$sd";
// 是否加密 0不加密 1加密
const String isEncrypt = "0";