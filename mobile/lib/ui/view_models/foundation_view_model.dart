import 'package:flutter/foundation.dart';
import '../../data/colectas_repository.dart';
import '../../domain/models/localidad_campana.dart';
import '../../domain/models/colecta_group.dart';
import '../../domain/models/contribution.dart';
import '../../domain/models/foundation_post.dart';
import '../../domain/models/chat_message.dart';

class FoundationViewModel extends ChangeNotifier {
  final ColectasRepository _repository;

  FoundationViewModel({required ColectasRepository repository})
      : _repository = repository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<LocalidadCampana> _localidades = [];
  List<ColectaGroup> _groups = [];
  List<Contribution> _allContributions = [];
  List<FoundationPost> _posts = [];
  final Map<String, List<ChatMessage>> _groupMessages = {};

  // Filtros
  PilarNavideno? _selectedPilar;
  PilarNavideno? get selectedPilar => _selectedPilar;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  // Perfil activo de padrino simulado
  String _currentUserName = 'Yacely (Padrino Solidario)';
  String get currentUserName => _currentUserName;
  void setCurrentUserName(String name) {
    _currentUserName = name;
    notifyListeners();
  }

  // Lista filtrada de Localidades
  List<LocalidadCampana> get localidades {
    return _localidades.where((loc) {
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final matchesName = loc.nombre.toLowerCase().contains(q);
        final matchesZone = loc.departamentoZona.toLowerCase().contains(q);
        final matchesDesc = loc.descripcionComunidad.toLowerCase().contains(q);
        if (!matchesName && !matchesZone && !matchesDesc) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  List<ColectaGroup> get groups => _groups;
  List<Contribution> get allContributions => _allContributions;
  List<FoundationPost> get posts => _posts;

  // Estadísticas globales de impacto comunitario
  double get totalMontoRecaudadoGeneral =>
      _localidades.fold(0.0, (acc, l) => acc + l.recaudadoTotal);

  double get metaTotalCampana =>
      _localidades.fold(0.0, (acc, l) => acc + l.metaTotal);

  int get totalNinosBeneficiados =>
      _localidades.fold(0, (acc, l) => acc + l.cantidadNinosEstimados);

  int get totalLocalidadesCompletadas =>
      _localidades.where((l) => l.recaudadoTotal >= l.metaTotal).length;

  int get totalPadrinosActivos =>
      _allContributions.map((c) => c.donorName).toSet().length;

  double get totalChocolatadaRecaudada =>
      _localidades.fold(0.0, (acc, l) => acc + l.recaudadoChocolatada);

  double get totalJuegosRecaudados =>
      _localidades.fold(0.0, (acc, l) => acc + l.recaudadoJuegos);

  double get totalJuguetesRecaudados =>
      _localidades.fold(0.0, (acc, l) => acc + l.recaudadoJuguetes);

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    try {
      _localidades = await _repository.getLocalidades();
      _groups = await _repository.getGroups();
      _allContributions = await _repository.getAllContributions();
      _posts = await _repository.getFoundationPosts();

      // Preload messages
      for (final g in _groups) {
        _groupMessages[g.id] = await _repository.getMessagesForGroup(g.id);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setPilarFilter(PilarNavideno? pilar) {
    _selectedPilar = pilar;
    notifyListeners();
  }

  void setSearchQuery(String q) {
    _searchQuery = q;
    notifyListeners();
  }

  List<ChatMessage> getMessages(String groupId) {
    return _groupMessages[groupId] ?? [];
  }

  List<Contribution> getContributions(String groupId) {
    return _allContributions.where((c) => c.colectaId == groupId).toList();
  }

  Future<ColectaGroup> createNewColecta({
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
    final grp = await _repository.createGroup(
      localidadId: localidadId,
      localidadNombre: localidadNombre,
      pilar: pilar,
      nombreGrupo: nombreGrupo,
      organizadorNombre: organizadorNombre,
      organizadorEmail: organizadorEmail,
      metaGrupo: metaGrupo,
      fechaLimite: fechaLimite,
      descripcion: descripcion,
    );

    _groups = await _repository.getGroups();
    _groupMessages[grp.id] = await _repository.getMessagesForGroup(grp.id);
    notifyListeners();
    return grp;
  }

  Future<void> addContribution({
    required String colectaId,
    required String localidadId,
    required String donorName,
    required double amount,
    required String mensajeNavideno,
    required PaymentMethod metodo,
    bool isAnonymous = false,
  }) async {
    await _repository.addContribution(
      colectaId: colectaId,
      localidadId: localidadId,
      donorName: donorName,
      amount: amount,
      mensajeNavideno: mensajeNavideno,
      metodo: metodo,
      isAnonymous: isAnonymous,
    );

    // Refresh state
    _localidades = await _repository.getLocalidades();
    _groups = await _repository.getGroups();
    _allContributions = await _repository.getAllContributions();
    _groupMessages[colectaId] =
        await _repository.getMessagesForGroup(colectaId);
    notifyListeners();
  }

  Future<void> sendChatMessage(String groupId, String messageText) async {
    if (messageText.trim().isEmpty) return;

    await _repository.sendChatMessage(
      colectaId: groupId,
      senderName: _currentUserName,
      text: messageText.trim(),
    );

    _groupMessages[groupId] = await _repository.getMessagesForGroup(groupId);
    notifyListeners();
  }

  Future<void> likePost(String postId) async {
    await _repository.togglePostLike(postId);
    _posts = await _repository.getFoundationPosts();
    notifyListeners();
  }
}
