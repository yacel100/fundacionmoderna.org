enum PaymentMethod {
  qrTransferencia,
  tarjeta,
  efectivoPuntoAcopio,
}

class Contribution {
  final String id;
  final String colectaId;
  final String childId;
  final String donorName;
  final String? donorEmail;
  final double amount;
  final String mensajeNavideno;
  final DateTime date;
  final PaymentMethod metodo;
  final bool isAnonymous;

  const Contribution({
    required this.id,
    required this.colectaId,
    required this.childId,
    required this.donorName,
    this.donorEmail,
    required this.amount,
    required this.mensajeNavideno,
    required this.date,
    required this.metodo,
    this.isAnonymous = false,
  });

  String get metodoTexto {
    switch (metodo) {
      case PaymentMethod.qrTransferencia:
        return 'QR / Transferencia Bancaria';
      case PaymentMethod.tarjeta:
        return 'Tarjeta Débito/Crédito';
      case PaymentMethod.efectivoPuntoAcopio:
        return 'Aporte en Punto de Acopio';
    }
  }
}
