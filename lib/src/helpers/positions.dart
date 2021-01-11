List<String> positions = [
  "goalkeeper",
	"side defender",
  "central defender",
  "defensive help",
  "middle help 8",
  "middle help 10",
  "side help 10",
  "attacker"
];

String getPolishPosition(String position) {
	if (!positions.contains(position))
		return position;
	final pl = [
		'Bramkarz',
		"Pomoc Boczna",
		'Pomoc Środkowa',
		'Obrona Boczna',
		'Środkowa Pomoc 8',
		'Środkowy Pomoc 10',
		'Boczna Pomoc 10',
		'Napastnik'
	];
	return pl[positions.indexOf(position)];
}
