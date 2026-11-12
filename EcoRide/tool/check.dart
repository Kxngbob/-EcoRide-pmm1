import 'package:ecoride/models/user.dart';
import 'package:ecoride/models/scooter.dart';
import 'package:ecoride/models/car.dart';

void check(bool condition, String message) {
  if (!condition) throw StateError(message);
}

void rejects(void Function() action) {
  try {
    action();
  } on ArgumentError {
    return;
  }
  throw StateError('Expected ArgumentError');
}

void main() {
  final user = User.nou(id: 'U', nom: 'Test', correu: 'test@example.com');
  check(user.balance == 0 && !user.esVIP, 'New-user defaults');
  user.rechargeBalance(20);
  for (final amount in [-10.0, 0.0, double.nan, double.infinity]) {
    rejects(() => user.rechargeBalance(amount));
  }
  check(user.balance == 20, 'Invalid recharge changed balance');
  final scooter = Scooter(id: 'S', batteryPercentage: 0, preuPerMinut: 0.2);
  for (final (battery, status) in [
    (0, 'Critical (Requires loading)'),
    (19, 'Critical (Requires loading)'),
    (20, 'Average'),
    (79, 'Average'),
    (80, 'High'),
    (100, 'High'),
  ]) {
    scooter.batteryPercentage = battery;
    check(scooter.batteryStat == status, 'Battery boundary $battery');
  }
  rejects(() => scooter.batteryPercentage = -1);
  rejects(() => scooter.batteryPercentage = 101);
  check(scooter.calcularCostReserva(15) == 3, 'Normal price');
  user.esVIP = true;
  check((scooter.calcularCostReserva(15, usuari: user) - 2.7).abs() < 1e-9,
      'VIP price');
  final car = Car(id: 'C', batteryPercentage: 95, preuPerMinut: 0.5, places: 5);
  check(car.calcularCostReserva(15, usuari: user) == 9.5, 'Car surcharge');
  rejects(() => car.calcularCostReserva(0));
  scooter.actualitzarUbicacio(39.58, 2.66);
  var (lat, lng) = scooter.getCoordinates();
  check(lat == 39.58 && lng == 2.66, 'GPS record');
  final fleet = [
    scooter,
    car,
    Scooter(id: 'boundary', batteryPercentage: 20, preuPerMinut: 0.2),
    Scooter(id: 'busy', batteryPercentage: 90, preuPerMinut: 0.2, enUs: true)
  ];
  check(fleet.where((v) => v.batteryPercentage > 20 && !v.enUs).length == 2,
      'Availability filter');
  print('All checks passed.');
}
