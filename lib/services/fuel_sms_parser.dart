final RegExp fuelSmsRegex = RegExp(
  r'(?:Fuel Pass|Ceypetco):?\s*Pumped\s*(?<liters>\d+(?:\.\d+)?)\s*L.*?'
  r'(?:LKR|Rs\.?)\s*(?<cost>\d+(?:\,\d+)*(?:\.\d+)?).*?'
  r'(?:Bal|Balance):?\s*(?<balance>\d+(?:\.\d+)?)\s*L',
  caseSensitive: false,
);

class FuelSms {
  const FuelSms({
    required this.liters,
    required this.cost,
    required this.balance,
  });

  final double liters;
  final double cost;
  final double balance;
}

FuelSms? parseFuelSms(String message) {
  final match = fuelSmsRegex.firstMatch(message);
  if (match == null) return null;

  return FuelSms(
    liters: double.parse(match.namedGroup('liters')!),
    cost: double.parse(match.namedGroup('cost')!.replaceAll(',', '')),
    balance: double.parse(match.namedGroup('balance')!),
  );
}
