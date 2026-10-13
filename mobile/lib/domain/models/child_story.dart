enum GiftCategory {
  juguetes,
  ropaCalzado,
  educacionArte,
  deportes,
  tecnologia,
}

enum GiftStatus {
  buscandoPadrinos,
  metaAlcanzada,
  comprando,
  empaquetado,
  listoParaEntrega,
  entregado,
}

class ChildStory {
  final String id;
  final String nombre;
  final int edad;
  final String ciudadComunidad;
  final String historia;
  final String deseoRegalo;
  final GiftCategory categoria;
  final double metaMonto;
  final double montoRecaudado;
  final GiftStatus estado;
  final String emoji;
  final String fotoAvatarUrl;
  final List<String> tags;

  const ChildStory({
    required this.id,
    required this.nombre,
    required this.edad,
    required this.ciudadComunidad,
    required this.historia,
    required this.deseoRegalo,
    required this.categoria,
    required this.metaMonto,
    required this.montoRecaudado,
    required this.estado,
    required this.emoji,
    required this.fotoAvatarUrl,
    this.tags = const [],
  });

  double get porcentajeAvance {
    if (metaMonto <= 0) return 0;
    final p = montoRecaudado / metaMonto;
    return p > 1.0 ? 1.0 : p;
  }

  double get restante => (metaMonto - montoRecaudado) > 0 ? metaMonto - montoRecaudado : 0.0;

  bool get estaCompleto => montoRecaudado >= metaMonto;

  String get categoriaTexto {
    switch (categoria) {
      case GiftCategory.juguetes:
        return 'Juguetes';
      case GiftCategory.ropaCalzado:
        return 'Ropa & Calzado';
      case GiftCategory.educacionArte:
        return 'Educación & Arte';
      case GiftCategory.deportes:
        return 'Deportes';
      case GiftCategory.tecnologia:
        return 'Tecnología';
    }
  }

  String get estadoTexto {
    switch (estado) {
      case GiftStatus.buscandoPadrinos:
        return 'Buscando padrinos';
      case GiftStatus.metaAlcanzada:
        return '¡Meta alcanzada!';
      case GiftStatus.comprando:
        return 'Comprando regalo';
      case GiftStatus.empaquetado:
        return 'Regalo empaquetado';
      case GiftStatus.listoParaEntrega:
        return 'Listo para entrega';
      case GiftStatus.entregado:
        return '¡Entregado!';
    }
  }

  ChildStory copyWith({
    double? montoRecaudado,
    GiftStatus? estado,
  }) {
    return ChildStory(
      id: id,
      nombre: nombre,
      edad: edad,
      ciudadComunidad: ciudadComunidad,
      historia: historia,
      deseoRegalo: deseoRegalo,
      categoria: categoria,
      metaMonto: metaMonto,
      montoRecaudado: montoRecaudado ?? this.montoRecaudado,
      estado: estado ?? this.estado,
      emoji: emoji,
      fotoAvatarUrl: fotoAvatarUrl,
      tags: tags,
    );
  }
}
