import 'statistic.dart';

class PlayerReport {
	String uri;
	String report;
	Map<String, dynamic> _player;
	int rating;
	String description;
	String status;
	List<Statistic> statistics = [];

	String get player => _player['name'];

	PlayerReport({String uri, String report, Map<String, dynamic> player, int rating, String description, String status}) :
		uri = uri ?? '',
		report = report ?? '',
		_player = player ?? '',
		rating = rating ?? 0,
		description = description ?? '',
		status = status ?? '';

	PlayerReport.fromJson(Map<String, dynamic> parsedJson) :
		uri         = parsedJson['url'] ?? '',
    report      = parsedJson['report'] ?? '',
		_player     = parsedJson['player'] ?? '',
   	rating      = parsedJson['rating'] ?? 0,
   	description = parsedJson['description'] ?? '',
   	status      = parsedJson['status'] ?? '' {
		parsedJson['statistics'].forEach(
			(i) {
				statistics.add(Statistic(name: i['name'], value: i['value'] ?? 0));
			}
		);
	}

	toJson() {
		return <String, dynamic> {
			'url' : uri,
			'report' : report,
			'player' : _player['url'],
			'rating' : rating,
			'description' : description,
			'status' : status,
			'statistics' : statistics.map((i) {return i.toJson();}).toList()
		};
	}

	Map<String, dynamic> toPost() {
		Map map = toJson();
		map.remove('url');
		print(map.toString());
		return map;
	}
}
