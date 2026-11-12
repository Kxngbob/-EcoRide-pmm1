class User {
  final String _id;
  final String _nomComplet;
  double _balance;
  String mail;
  bool esVIP;

  User({
    required String id,
    required String nom,
    required this.mail,
    required double balance,
    this.esVIP = false,
  })  : _id = id,
        _nomComplet = nom,
        _balance = balance {
    if (!balance.isFinite || balance < 0) {
      throw ArgumentError('El saldo inicial debe ser finito y no negativo.');
    }
  }

  User.nou({required String id, required String nom, required String correu})
      : this(id: id, nom: nom, mail: correu, balance: 0.0);

  String get id => _id;
  String get nomComplet => _nomComplet;
  double get balance => _balance;

  void rechargeBalance(double amount) {
    if (!amount.isFinite || amount <= 0 || !(_balance + amount).isFinite) {
      throw ArgumentError('La recarga debe ser finita y mayor que cero.');
    }
    _balance += amount;
  }
}
