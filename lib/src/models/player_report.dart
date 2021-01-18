import 'player.dart';
import 'player_report_profile_nested_profile.dart';

class PlayerReport {
	String uri;
	String reportUri;
	Player player;
	double rating;
	String description;
	String status;
	List<NestedProfile> profiles;

	PlayerReport({String uri, String report, Player player, int rating, String description, String status}) :
		uri = uri ?? '',
		reportUri = report ?? '',
		player = player,
		rating = rating ?? 0,
		description = description ?? '',
		status = status ?? '';

	PlayerReport.fromJson(Map<String, dynamic> parsedJson) :
		uri = parsedJson['url'] ?? '',
    reportUri = parsedJson['report'] ?? '',
		player = Player.fromJson(parsedJson['player']) ?? Player(),
   	rating = parsedJson['score'] ?? 0,
   	description = parsedJson['description'] ?? '',
   	status = parsedJson['status'] ?? ''  {
			profiles = _jsonToProfileList(parsedJson['profiles']);
		}

	List<NestedProfile> _jsonToProfileList(List json) {
		List<NestedProfile> list = [];
		if (json == null)
			return list;

		json.forEach((i) {
			list.add(NestedProfile.fromJson(i));
		});
		return list;
	}


	toJson() {
		return <String, dynamic> {
			'url' : uri,
			'report' : reportUri,
			'player' : player.uri,
			'rating' : rating,
			'description' : description,
			'status' : status,
			'profiles': profiles.map((i) => i.toJson()).toList()
		};
	}

	Map<String, dynamic> toPost() {
		Map map = toJson();
		map.remove('url');
		print(map.toString());
		return map;
	}
}

