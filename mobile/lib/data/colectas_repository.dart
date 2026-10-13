import '../domain/models/localidad_campana.dart';
import '../domain/models/colecta_group.dart';
import '../domain/models/contribution.dart';
import '../domain/models/foundation_post.dart';
import '../domain/models/chat_message.dart';
import 'mock_data.dart';

class ColectasRepository {
  List<LocalidadCampana> _localidades = [];
  List<ColectaGroup> _groups = [];
  List<Contribution> _contributions = [];
  List<FoundationPost> _posts = [];
  List<ChatMessage> _messages = [];

  ColectasRepository() {
    _localidades = List.from(MockData.initialLocalidades);
    _groups = List.from(MockData.initialGroups);
    _contributions = List.from(MockData.initialContributions);
    _posts = List.from(MockData.initialPosts);
    _messages = List.from(MockData.initialChatMessages);
  }

  Future<List<LocalidadCampana>> getLocalidades() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.unmodifiable(_localidades);
  }

  Future<List<ColectaGroup>> getGroups() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.unmodifiable(_groups);
  }

  Future<List<Contribution>> getContributionsForGroup(String groupId) async {
    await Future.delayed(const Duration(milliseconds: 80));
    return _contributions.where((c) => c.colectaId == groupId).toList();
  }

  Future<List<Contribution>> getAllContributions() async {
    await Future.delayed(const Duration(milliseconds: 80));
    return List.unmodifiable(_contributions);
  }

  Future<List<FoundationPost>> getFoundationPosts() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.unmodifiable(_posts);
  }

  Future<List<ChatMessage>> getMessagesForGroup(String groupId) async {
    await Future.delayed(const Duration(milliseconds: 80));
    return _messages.where((m) => m.colectaId == groupId).toList();
  }

  Future<ColectaGroup> createGroup({
    required String localidadId,
    required String localidadNombre,
    PilarNavideno pilar = PilarNavideno.integral,
    required String nombreGrupo,
    required String organizadorNombre,
    required String organizadorEmail,
    required double metaGrupo,
    required DateTime fechaLimite,
    required String descripcion,
  }) async {
    final code =
        'NAV-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';
    final newGroup = ColectaGroup(
      id: 'group-${DateTime.now().millisecondsSinceEpoch}',
      localidadId: localidadId,
      localidadNombre: localidadNombre,
      pilar: pilar,
      nombreGrupo: nombreGrupo,
      organizadorNombre: organizadorNombre,
      organizadorEmail: organizadorEmail,
      metaGrupo: metaGrupo,
      montoActual: 0.0,
      fechaLimite: fechaLimite,
      descripcion: descripcion,
      codigoInvitacion: code,
      amigosParticipantes: [organizadorNombre],
    );

    _groups.insert(0, newGroup);
    return newGroup;
  }

  Future<Contribution> addContribution({
    required String colectaId,
    required String localidadId,
    required String donorName,
    required double amount,
    required String mensajeNavideno,
    required PaymentMethod metodo,
    bool isAnonymous = false,
  }) async {
    final newContrib = Contribution(
      id: 'contrib-${DateTime.now().millisecondsSinceEpoch}',
      colectaId: colectaId,
      localidadId: localidadId,
      donorName: donorName,
      amount: amount,
      mensajeNavideno: mensajeNavideno,
      date: DateTime.now(),
      metodo: metodo,
      isAnonymous: isAnonymous,
    );
    _contributions.insert(0, newContrib);

    // Update group
    final gIndex = _groups.indexWhere((g) => g.id == colectaId);
    PilarNavideno targetPilar = PilarNavideno.integral;
    if (gIndex != -1) {
      final grp = _groups[gIndex];
      targetPilar = grp.pilar;
      final newAmt = grp.montoActual + amount;
      final parts = List<String>.from(grp.amigosParticipantes);
      if (!parts.contains(donorName) && !isAnonymous) {
        parts.add(donorName);
      }
      _groups[gIndex] = grp.copyWith(
        montoActual: newAmt,
        amigosParticipantes: parts,
      );
    }

    // Update localidad
    final locIndex = _localidades.indexWhere((l) => l.id == localidadId);
    if (locIndex != -1) {
      final loc = _localidades[locIndex];
      double newChoco = loc.recaudadoChocolatada;
      double newJuegos = loc.recaudadoJuegos;
      double newJuguetes = loc.recaudadoJuguetes;

      switch (targetPilar) {
        case PilarNavideno.chocolatada:
          newChoco += amount;
          break;
        case PilarNavideno.juegosShow:
          newJuegos += amount;
          break;
        case PilarNavideno.juguetes:
          newJuguetes += amount;
          break;
        case PilarNavideno.integral:
          // Distribute proportionally
          newChoco += (amount * 0.25);
          newJuegos += (amount * 0.20);
          newJuguetes += (amount * 0.55);
          break;
      }

      final totalRec = newChoco + newJuegos + newJuguetes;
      final newEstado = totalRec >= loc.metaTotal
          ? EstadoCaravana.metaAlcanzada
          : loc.estado;

      _localidades[locIndex] = LocalidadCampana(
        id: loc.id,
        nombre: loc.nombre,
        departamentoZona: loc.departamentoZona,
        descripcionComunidad: loc.descripcionComunidad,
        cantidadNinosEstimados: loc.cantidadNinosEstimados,
        fechaCaravana: loc.fechaCaravana,
        estado: newEstado,
        emoji: loc.emoji,
        puntoEncuentroSalida: loc.puntoEncuentroSalida,
        necesidadesPuntuales: loc.necesidadesPuntuales,
        metaChocolatada: loc.metaChocolatada,
        recaudadoChocolatada: newChoco,
        metaJuegos: loc.metaJuegos,
        recaudadoJuegos: newJuegos,
        metaJuguetes: loc.metaJuguetes,
        recaudadoJuguetes: newJuguetes,
      );
    }

    // Auto-post chat message in the group
    _messages.add(
      ChatMessage(
        id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
        colectaId: colectaId,
        senderName: donorName,
        text: '🎁 Aportó \$${amount.toStringAsFixed(0)}: "$mensajeNavideno"',
        timestamp: DateTime.now(),
      ),
    );

    return newContrib;
  }

  Future<void> sendChatMessage({
    required String colectaId,
    required String senderName,
    required String text,
    bool isOrganizer = false,
  }) async {
    _messages.add(
      ChatMessage(
        id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
        colectaId: colectaId,
        senderName: senderName,
        text: text,
        timestamp: DateTime.now(),
        isOrganizer: isOrganizer,
      ),
    );
  }

  Future<void> togglePostLike(String postId) async {
    final idx = _posts.indexWhere((p) => p.id == postId);
    if (idx != -1) {
      final post = _posts[idx];
      _posts[idx] = post.copyWith(likesCount: post.likesCount + 1);
    }
  }
}
