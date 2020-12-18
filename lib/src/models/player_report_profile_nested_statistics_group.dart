import 'player_report_profile_nested_statistics.dart';

class PlayerReportProfileNestedStatisticsGroup {
	String name;
	List<PlayerReportProfileNestedStatistics> statistics;

	PlayerReportProfileNestedStatisticsGroup.fromJson(Map<String, dynamic> parsedJson) :
		name = parsedJson['name'],
		statistics = parsedJson['statistics'].map((i) {
			return PlayerReportProfileNestedStatistics.fromJson(i);
		}).asList();

	toJson() {
		return {
			'name' : name,
			'statistics' : statistics.map( (i) => i.toJson()).toList(),
		};
	}
}


