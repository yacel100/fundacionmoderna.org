import '../domain/models/child_story.dart';
import '../domain/models/colecta_group.dart';
import '../domain/models/contribution.dart';
import '../domain/models/foundation_post.dart';
import '../domain/models/chat_message.dart';
import 'mock_data.dart';

class ColectasRepository {
  List<ChildStory> _children = [];
  List<ColectaGroup> _groups = [];
  List<Contribution> _contributions = [];
  List<FoundationPost> _posts = [];
  List<ChatMessage> _messages = [];

  ColectasRepository() {
    _children = List.from(MockData.initialChildren);
    _groups = List.from(MockData.initialGroups);
    _contributions = List.from(MockData.initialContributions);
    _posts = List.from(MockData.initialPosts);
    _messages = List.from(MockData.initialChatMessages);
  }

  Future<List<ChildStory>> getChildren() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return List.unmodifiable(_children);
  }

  Future<List<ColectaGroup>> getGroups() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return List.unmodifiable(_groups);
  }

  Future<List<Contribution>> getContributionsForGroup(String groupId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _contributions.where((c) => c.colectaId == groupId).toList();
  }

  Future<List<Contribution>> getAllContributions() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.unmodifiable(_contributions);
  }

  Future<List<FoundationPost>> getFoundationPosts() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return List.unmodifiable(_posts);
  }

  Future<List<ChatMessage>> getMessagesForGroup(String groupId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _messages.where((m) => m.colectaId == groupId).toList();
  }

  Future<ColectaGroup> createGroup({
    required String childId,
    required String childName,
    required String nombreGrupo,
    required String organizadorNombre,
    required String organizadorEmail,
    required double metaGrupo,
    required DateTime fechaLimite,
    required String descripcion,
  }) async {
    final code = 'NAV-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';
    final newGroup = ColectaGroup(
      id: 'group-${DateTime.now().millisecondsSinceEpoch}',
      childId: childId,
      childName: childName,
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
    required String childId,
    required String donorName,
    required double amount,
    required String mensajeNavideno,
    required PaymentMethod metodo,
    bool isAnonymous = false,
  }) async {
    final newContrib = Contribution(
      id: 'contrib-${DateTime.now().millisecondsSinceEpoch}',
      colectaId: colectaId,
      childId: childId,
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
    if (gIndex != -1) {
      final grp = _groups[gIndex];
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

    // Update child story
    final cIndex = _children.indexWhere((c) => c.id == childId);
    if (cIndex != -1) {
      final ch = _children[cIndex];
      final newRecaudado = ch.montoRecaudado + amount;
      final newStatus = newRecaudado >= ch.metaMonto ? GiftStatus.metaAlcanzada : ch.estado;
      _children[cIndex] = ch.copyWith(
        montoRecaudado: newRecaudado,
        estado: newStatus,
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
