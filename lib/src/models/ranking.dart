import 'package:skautex_mobile/src/models/player.dart';

class Ranking{
	double score;
	Player player;

	Ranking({this.player, this.score});

	Ranking.fromJson(Map<String, dynamic> parsedJson):
		score = parsedJson['score'],
		player = Player.fromJson(parsedJson['player']);

	Map<String, dynamic> toJson() {
		var map = <String, dynamic> {
			'score': score,
			'player': player?.uri,
		};
		return map;
	}

	Map<String, dynamic> toPost() => toJson();
}
