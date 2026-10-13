import 'package:flutter/material.dart';
import '../../domain/models/colecta_group.dart';
import '../core/app_theme.dart';
import '../core/widgets/festive_badge.dart';
import '../core/widgets/progress_stat_bar.dart';
import '../view_models/foundation_view_model.dart';
import 'registrar_aporte_dialog.dart';

class ColectaDetailScreen extends StatefulWidget {
  final ColectaGroup group;
  final FoundationViewModel viewModel;

  const ColectaDetailScreen({
    super.key,
    required this.group,
    required this.viewModel,
  });

  @override
  State<ColectaDetailScreen> createState() => _ColectaDetailScreenState();
}

class _ColectaDetailScreenState extends State<ColectaDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _chatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _chatController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final txt = _chatController.text.trim();
    if (txt.isEmpty) return;
    widget.viewModel.sendChatMessage(widget.group.id, txt);
    _chatController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        final currentGroup = widget.viewModel.groups.firstWhere(
          (g) => g.id == widget.group.id,
          orElse: () => widget.group,
        );

        final contributions = widget.viewModel.getContributions(currentGroup.id);
        final messages = widget.viewModel.getMessages(currentGroup.id);

        return Scaffold(
          appBar: AppBar(
            title: Text(currentGroup.nombreGrupo),
            actions: [
              IconButton(
                icon: const Icon(Icons.share_outlined),
                tooltip: 'Invitar amigos por WhatsApp',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppTheme.pineGreen,
                      content: Text(
                        'Código ${currentGroup.codigoInvitacion} copiado para invitar amigos a la colecta.',
                      ),
                    ),
                  );
                },
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              labelColor: AppTheme.pineGreen,
              indicatorColor: AppTheme.pineGreen,
              tabs: [
                Tab(
                  icon: const Icon(Icons.volunteer_activism_outlined, size: 20),
                  text: 'Aportes (${contributions.length})',
                ),
                Tab(
                  icon: const Icon(Icons.chat_bubble_outline, size: 20),
                  text: 'Coordinación (${messages.length})',
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              // Group Card Summary
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.borderLight),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: AppTheme.lightGold,
                          child: Text('🎁', style: TextStyle(fontSize: 20)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentGroup.childName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: AppTheme.textDark,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Organiza: ${currentGroup.organizadorNombre}',
                                style: const TextStyle(
                                  color: AppTheme.textMuted,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        FestiveBadge(
                          text: '${currentGroup.diasRestantes} días restantes',
                          backgroundColor: AppTheme.lightGold,
                          textColor: AppTheme.festiveGold,
                          icon: Icons.timer_outlined,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    ProgressStatBar(
                      current: currentGroup.montoActual,
                      target: currentGroup.metaGrupo,
                      height: 10,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          currentGroup.estaCompletada
                              ? '🎉 ¡Meta grupal completada!'
                              : 'Faltan: \$${currentGroup.restante.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: currentGroup.estaCompletada
                                ? AppTheme.emerald
                                : AppTheme.rubyRed,
                          ),
                        ),
                        Text(
                          '${currentGroup.amigosParticipantes.length} amigos unidos',
                          style: const TextStyle(color: AppTheme.textMuted, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Tab views
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Tab 1: Contributions list
                    _buildContributionsTab(contributions, currentGroup),

                    // Tab 2: Coordination Chat
                    _buildChatTab(messages, currentGroup),
                  ],
                ),
              ),

              // Bottom Sticky Action Button
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: AppTheme.borderLight)),
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.rubyRed,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          icon: const Icon(Icons.favorite),
                          label: const Text('Registrar mi Aporte Navideño'),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (ctx) => RegistrarAporteDialog(
                                group: currentGroup,
                                viewModel: widget.viewModel,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContributionsTab(List contributions, ColectaGroup currentGroup) {
    if (contributions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🌟', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 12),
            const Text(
              'Aún no hay aportes registrados',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 6),
            const Text(
              'Sé el primero en dar el paso para el regalo del niño.',
              style: TextStyle(color: AppTheme.textMuted),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: contributions.length,
      itemBuilder: (context, index) {
        final c = contributions[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: AppTheme.pineGreen.withValues(alpha: 0.1),
                          child: const Icon(Icons.person, color: AppTheme.pineGreen, size: 18),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          c.donorName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppTheme.textDark,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '+\$${c.amount.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppTheme.emerald,
                      ),
                    ),
                  ],
                ),
                if (c.mensajeNavideno.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.softBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '"${c.mensajeNavideno}"',
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 13,
                        color: AppTheme.textDark,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      c.metodoTexto,
                      style: const TextStyle(color: AppTheme.textMuted, fontSize: 11),
                    ),
                    Text(
                      '${c.date.day}/${c.date.month}/${c.date.year}',
                      style: const TextStyle(color: AppTheme.textMuted, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChatTab(List messages, ColectaGroup currentGroup) {
    return Column(
      children: [
        // Help banner
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: AppTheme.lightGold.withValues(alpha: 0.3),
          child: const Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: AppTheme.festiveGold),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Espacio para coordinar quién compra el regalo, empaque y punto de encuentro.',
                  style: TextStyle(fontSize: 12, color: AppTheme.textDark),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final m = messages[index];
              final isMe = m.senderName == widget.viewModel.currentUserName;

              return Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.78,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isMe ? AppTheme.pineGreen : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isMe ? Colors.transparent : AppTheme.borderLight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment:
                        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Text(
                        m.isOrganizer ? '${m.senderName} (Organizador)' : m.senderName,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: isMe ? Colors.white70 : AppTheme.rubyRed,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        m.text,
                        style: TextStyle(
                          fontSize: 14,
                          color: isMe ? Colors.white : AppTheme.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Chat Input Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _chatController,
                  decoration: InputDecoration(
                    hintText: 'Escribir mensaje al grupo...',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.send, color: AppTheme.pineGreen),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
