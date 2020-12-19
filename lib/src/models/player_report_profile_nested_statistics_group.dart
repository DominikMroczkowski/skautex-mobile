import 'player_report_profile_nested_statistics.dart';

class StatisticGroup {
	String name;
	List<Statistic> statistics;

	StatisticGroup.fromJson(Map<String, dynamic> parsedJson) :
		name = parsedJson['name'] {
		statistics = _jsonToStatisticsList(parsedJson['statistics']);
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

	toJson() {
		return {
			'name' : name,
			'statistics' : statistics.map( (i) => i.toJson()).toList(),
		};
	}
}


