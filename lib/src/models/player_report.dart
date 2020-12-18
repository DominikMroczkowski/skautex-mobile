import 'player.dart';
import 'player_report_profile_nested_profile.dart';

class PlayerReport {
	String uri;
	String reportUri;
	Player player;
	int rating;
	String description;
	String status;
	List<PlayerReportNestedProfile> profiles;

	PlayerReport({String uri, String report, Player player, int rating, String description, String status}) :
		uri = uri ?? '',
		reportUri = report ?? '',
		player = player,
		rating = rating ?? 0,
		description = description ?? '',
		status = status ?? '';

	PlayerReport.fromJson(Map<String, dynamic> parsedJson) :
		uri         = parsedJson['url'] ?? '',
    reportUri      = parsedJson['report'] ?? '',
		player     = parsedJson['player'] ?? '',
   	rating      = parsedJson['rating'] ?? 0,
   	description = parsedJson['description'] ?? '',
		profiles = parsedJson['profiles'].map((i) {
			return PlayerReportNestedProfile.fromJson(i);
		}).asList(),
   	status      = parsedJson['status'] ?? '' ;


	toJson() {
		return <String, dynamic> {
			'url' : uri,
			'report' : reportUri,
			'player' : player.toJson(),
			'rating' : rating,
			'description' : description,
			'status' : status,
		};
	}

	Map<String, dynamic> toPost() {
		Map map = toJson();
		map.remove('url');
		print(map.toString());
		return map;
	}
}

