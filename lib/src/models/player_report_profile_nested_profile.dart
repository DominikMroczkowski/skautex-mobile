import 'player_report_profile_nested_statistics.dart';
import 'player_report_profile_nested_statistics_group.dart';

class NestedProfile {
	String name;
	String description;
	List<Statistic> statistics;
	List<StatisticGroup> group;

	NestedProfile.fromJson(Map<String, dynamic> parsedJson) :
		name = parsedJson['name'],
		description = parsedJson['description'] {
		statistics = _jsonToStatisticsList(parsedJson['statistics']);
		group = _jsonToGroupList(parsedJson['groups']);
		}

	List<Statistic> _jsonToStatisticsList(List json) {
		List<Statistic> list = [];
		if (json == null)
			return list;

		json.forEach((i) {
			list.add(Statistic.fromJson(i));
		});
		return list;
	}

	List<StatisticGroup> _jsonToGroupList(List json) {
		List<StatisticGroup> list = [];
		if (json == null)
			return list;

		json.forEach((i) {
			list.add(StatisticGroup.fromJson(i));
		});
		return list;
	}

	toJson() {
		return <String, dynamic> {
			'name' : name,
			'description' : description,
			'statistics' : statistics.map( (i) => i.toJson()).toList(),
			'groups' : group.map( (i) => i.toJson()).toList(),
		};
	}

	Map<String, dynamic> toPost() {
		Map map = toJson();
		return map;
	}
}
