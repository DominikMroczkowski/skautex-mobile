import 'player_report_profile_nested_statistics.dart';
import 'player_report_profile_nested_statistics_group.dart';

class PlayerReportNestedProfile {
	String name;
	String description;
	List<PlayerReportProfileNestedStatistics> statistics;
	List<PlayerReportProfileNestedStatisticsGroup> group;

	PlayerReportNestedProfile.fromJson(Map<String, dynamic> parsedJson) :
		name = parsedJson['name'],
		description = parsedJson['description'],
		statistics = parsedJson['statistics'].map((i) {
			return PlayerReportProfileNestedStatistics.fromJson(i);
		}).asList(),
		group = parsedJson['statistics'].map((i) {
			return PlayerReportProfileNestedStatisticsGroup.fromJson(i);
		}).asList();

	toJson() {
		return <String, dynamic> {
			'name' : name,
			'description' : description,
			'statistics' : statistics.map( (i) => i.toJson()).toList(),
			'group' : group.map( (i) => i.toJson()).toList(),
		};
	}

	Map<String, dynamic> toPost() {
		Map map = toJson();
		return map;
	}
}
