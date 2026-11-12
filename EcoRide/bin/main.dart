import 'package:ecoride/models/car.dart';
import 'package:ecoride/models/scooter.dart';
import 'package:ecoride/models/user.dart';
import 'package:ecoride/models/vehicle.dart';

void main() {
  final nouUsuari = User.nou(
    id: 'U001',
    nom: 'Fortune Ihedioha',
    correu: 'fortune@example.com',
  );
  final vip = User(
    id: 'U002',
    nom: 'Usuario VIP',
    mail: 'vip@example.com',
    balance: 10.0,
    esVIP: true,
  );
  nouUsuari.rechargeBalance(20.0);
  print('Usuario ${nouUsuari.id}: ${nouUsuari.nomComplet}; '
      'saldo: ${nouUsuari.balance.toStringAsFixed(2)} EUR');

  final List<Vehicle> fleet = [
    Scooter(id: 'S001', batteryPercentage: 85, preuPerMinut: 0.20)
      ..actualitzarUbicacio(39.5696, 2.6502),
    Scooter(id: 'S002', batteryPercentage: 15, preuPerMinut: 0.20)
      ..actualitzarUbicacio(39.5701, 2.6510),
    Scooter(id: 'S003', batteryPercentage: 60, preuPerMinut: 0.25, enUs: true)
      ..actualitzarUbicacio(39.5710, 2.6520),
    Car(id: 'C001', batteryPercentage: 95, preuPerMinut: 0.50, places: 5)
      ..actualitzarUbicacio(39.5720, 2.6530),
    Car(id: 'C002', batteryPercentage: 20, preuPerMinut: 0.45, places: 4)
      ..actualitzarUbicacio(39.5730, 2.6540),
  ];

  print('\n1. FLOTA: 3 scooters y 2 coches');
  fleet.forEach(print);

  print('\n2. BATERÍA MÁXIMA Y VEHÍCULOS DISPONIBLES');
  final maxim = fleet
      .reduce((a, b) => a.batteryPercentage >= b.batteryPercentage ? a : b);
  print('Mayor batería: $maxim');
  final disponibles =
      fleet.where((v) => v.batteryPercentage > 20 && !v.enUs).toList();
  disponibles.forEach(print);

  print('\n3. RESERVA DE 15 MINUTOS');
  final scooter = disponibles.whereType<Scooter>().first;
  scooter.enUs = true;
  final normal = scooter.calcularCostReserva(15, usuari: nouUsuari);
  final ambVIP = scooter.calcularCostReserva(15, usuari: vip);
  print('Reservado: ${scooter.id}; en uso: ${scooter.enUs}');
  print('Tarifa normal: ${normal.toStringAsFixed(2)} EUR');
  print('Tarifa VIP (-10%): ${ambVIP.toStringAsFixed(2)} EUR');
  final cotxe = fleet.whereType<Car>().first;
  print('Coche, 15 minutos + suplemento: '
      '${cotxe.calcularCostReserva(15).toStringAsFixed(2)} EUR');
  scooter.actualitzarUbicacio(39.5800, 2.6600);
  // Dart 3 record destructuring: two local variables from one record.
  var (lat, lng) = scooter.getCoordinates();
  print('GPS actualizado: latitud=$lat, longitud=$lng');
  scooter.enUs = false;
  print('Reserva finalizada; en uso: ${scooter.enUs}');

  print('\n4. RECARGA NEGATIVA CONTROLADA');
  try {
    nouUsuari.rechargeBalance(-10.0);
  } on ArgumentError catch (error) {
    print('Error capturado: ${error.message}');
  }
  print('Saldo conservado: ${nouUsuari.balance.toStringAsFixed(2)} EUR');
  print('Programa finalizado correctamente.');
}
