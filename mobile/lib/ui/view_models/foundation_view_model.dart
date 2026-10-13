import 'package:flutter/foundation.dart';
import '../../data/colectas_repository.dart';
import '../../domain/models/child_story.dart';
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

  List<ChildStory> _children = [];
  List<ColectaGroup> _groups = [];
  List<Contribution> _allContributions = [];
  List<FoundationPost> _posts = [];
  final Map<String, List<ChatMessage>> _groupMessages = {};

  // Filters
  GiftCategory? _selectedCategory;
  GiftCategory? get selectedCategory => _selectedCategory;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  // Active current user profile for simulation
  String _currentUserName = 'Yacely (Padrino)';
  String get currentUserName => _currentUserName;
  void setCurrentUserName(String name) {
    _currentUserName = name;
    notifyListeners();
  }

  List<ChildStory> get children {
    return _children.where((child) {
      if (_selectedCategory != null && child.categoria != _selectedCategory) {
        return false;
      }
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final matchesName = child.nombre.toLowerCase().contains(q);
        final matchesGift = child.deseoRegalo.toLowerCase().contains(q);
        final matchesCity = child.ciudadComunidad.toLowerCase().contains(q);
        final matchesTags = child.tags.any((t) => t.toLowerCase().contains(q));
        if (!matchesName && !matchesGift && !matchesCity && !matchesTags) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  List<ColectaGroup> get groups => _groups;
  List<Contribution> get allContributions => _allContributions;
  List<FoundationPost> get posts => _posts;

  // Statistics
  double get totalMontoRecaudadoGeneral =>
      _children.fold(0.0, (acc, c) => acc + c.montoRecaudado);

  double get metaTotalCampana =>
      _children.fold(0.0, (acc, c) => acc + c.metaMonto);

  int get totalNinosCompletados =>
      _children.where((c) => c.montoRecaudado >= c.metaMonto).length;

  int get totalPadrinosActivos =>
      _allContributions.map((c) => c.donorName).toSet().length;

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    try {
      _children = await _repository.getChildren();
      _groups = await _repository.getGroups();
      _allContributions = await _repository.getAllContributions();
      _posts = await _repository.getFoundationPosts();

      // Preload messages for each group
      for (final g in _groups) {
        _groupMessages[g.id] = await _repository.getMessagesForGroup(g.id);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setCategoryFilter(GiftCategory? cat) {
    _selectedCategory = cat;
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
    required String childId,
    required String childName,
    required String nombreGrupo,
    required String organizadorNombre,
    required String organizadorEmail,
    required double metaGrupo,
    required DateTime fechaLimite,
    required String descripcion,
  }) async {
    final grp = await _repository.createGroup(
      childId: childId,
      childName: childName,
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
    required String childId,
    required String donorName,
    required double amount,
    required String mensajeNavideno,
    required PaymentMethod metodo,
    bool isAnonymous = false,
  }) async {
    await _repository.addContribution(
      colectaId: colectaId,
      childId: childId,
      donorName: donorName,
      amount: amount,
      mensajeNavideno: mensajeNavideno,
      metodo: metodo,
      isAnonymous: isAnonymous,
    );

    // Refresh state
    _children = await _repository.getChildren();
    _groups = await _repository.getGroups();
    _allContributions = await _repository.getAllContributions();
    _groupMessages[colectaId] = await _repository.getMessagesForGroup(colectaId);
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
