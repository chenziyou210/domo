import '/generated/json/base/json_convert_content.dart';
import '/generated/upgrade_entity.dart';

UpgradeEntity $UpgradeEntityFromJson(Map<String, dynamic> json) {
	final UpgradeEntity upgradeEntity = UpgradeEntity();
	final String? createTime = jsonConvert.convert<String>(json['createTime']);
	if (createTime != null) {
		upgradeEntity.createTime = createTime;
	}
	final int? flag = jsonConvert.convert<int>(json['flag']);
	if (flag != null) {
		upgradeEntity.flag = flag;
	}
	final int? forceUpgrade = jsonConvert.convert<int>(json['forceUpgrade']);
	if (forceUpgrade != null) {
		upgradeEntity.forceUpgrade = forceUpgrade;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		upgradeEntity.id = id;
	}
	final String? lastforceVersionName = jsonConvert.convert<String>(json['lastforceVersionName']);
	if (lastforceVersionName != null) {
		upgradeEntity.lastforceVersionName = lastforceVersionName;
	}
	final String? platform = jsonConvert.convert<String>(json['platform']);
	if (platform != null) {
		upgradeEntity.platform = platform;
	}
	final String? releaseNotes = jsonConvert.convert<String>(json['releaseNotes']);
	if (releaseNotes != null) {
		upgradeEntity.releaseNotes = releaseNotes;
	}
	final String? updateTime = jsonConvert.convert<String>(json['updateTime']);
	if (updateTime != null) {
		upgradeEntity.updateTime = updateTime;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		upgradeEntity.url = url;
	}
	final String? versionName = jsonConvert.convert<String>(json['versionName']);
	if (versionName != null) {
		upgradeEntity.versionName = versionName;
	}
	final int? versionNameInt = jsonConvert.convert<int>(json['versionNameInt']);
	if (versionNameInt != null) {
		upgradeEntity.versionNameInt = versionNameInt;
	}
	return upgradeEntity;
}

Map<String, dynamic> $UpgradeEntityToJson(UpgradeEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['createTime'] = entity.createTime;
	data['flag'] = entity.flag;
	data['forceUpgrade'] = entity.forceUpgrade;
	data['id'] = entity.id;
	data['lastforceVersionName'] = entity.lastforceVersionName;
	data['platform'] = entity.platform;
	data['releaseNotes'] = entity.releaseNotes;
	data['updateTime'] = entity.updateTime;
	data['url'] = entity.url;
	data['versionName'] = entity.versionName;
	data['versionNameInt'] = entity.versionNameInt;
	return data;
}