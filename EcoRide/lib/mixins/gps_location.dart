mixin GPSLocation {
  double latitud = 0.0;
  double longitud = 0.0;

  void actualitzarUbicacio(double lat, double lng) {
    if (!lat.isFinite ||
        lat < -90 ||
        lat > 90 ||
        !lng.isFinite ||
        lng < -180 ||
        lng > 180) {
      throw ArgumentError('Coordenadas GPS no válidas.');
    }
    latitud = lat;
    longitud = lng;
  }

  (double lat, double lng) getCoordinates() => (latitud, longitud);
}
