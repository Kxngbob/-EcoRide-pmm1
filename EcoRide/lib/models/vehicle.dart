import '../mixins/gps_location.dart';
import 'user.dart';

abstract class Vehicle with GPSLocation {
  final String id;
  int _batteryPercentage;
  bool enUs;
  final double preuPerMinut;

  Vehicle({
    required this.id,
    required int batteryPercentage,
    required this.preuPerMinut,
    this.enUs = false,
  }) : _batteryPercentage = batteryPercentage {
    this.batteryPercentage = batteryPercentage;
    if (!preuPerMinut.isFinite || preuPerMinut < 0) {
      throw ArgumentError('El precio debe ser finito y no negativo.');
    }
  }

  int get batteryPercentage => _batteryPercentage;
  set batteryPercentage(int value) {
    if (value < 0 || value > 100) {
      throw ArgumentError('La batería debe estar entre 0 y 100.');
    }
    _batteryPercentage = value;
  }

  // Dart 3 switch expression with relational patterns.
  String get batteryStat => switch (batteryPercentage) {
        >= 80 => 'High',
        >= 20 => 'Average',
        _ => 'Critical (Requires loading)',
      };

  void validarMinuts(int minuts) {
    if (minuts <= 0) throw ArgumentError('Los minutos deben ser positivos.');
  }

  // Optional user keeps the required one-argument call valid and enables VIPs.
  double calcularCostReserva(int minuts, {User? usuari});

  @override
  String toString() => '$runtimeType $id | batería: $batteryPercentage% | '
      '$batteryStat | en uso: $enUs';
}
