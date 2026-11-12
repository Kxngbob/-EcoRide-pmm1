import 'user.dart';
import 'vehicle.dart';

class Car extends Vehicle {
  final int places;
  final bool requiredLlicence;
  static const double supplementEcologicalFilter = 2.0;

  Car({
    required super.id,
    required super.batteryPercentage,
    required super.preuPerMinut,
    required this.places,
    this.requiredLlicence = true,
    super.enUs,
  }) {
    if (places <= 0) throw ArgumentError('Número de plazas no válido.');
  }

  @override
  double calcularCostReserva(int minuts, {User? usuari}) {
    validarMinuts(minuts);
    return minuts * preuPerMinut + supplementEcologicalFilter;
  }
}
