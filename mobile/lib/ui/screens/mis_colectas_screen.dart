import 'package:flutter/material.dart';
import '../../domain/models/colecta_group.dart';
import '../core/app_theme.dart';
import '../core/widgets/festive_badge.dart';
import '../core/widgets/progress_stat_bar.dart';
import '../view_models/foundation_view_model.dart';
import 'colecta_detail_screen.dart';
import 'nueva_colecta_dialog.dart';

class MisColectasScreen extends StatelessWidget {
  final FoundationViewModel viewModel;

  const MisColectasScreen({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final groups = viewModel.groups;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Colectas entre Amigos'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add_circle_outline, color: AppTheme.pineGreen),
                tooltip: 'Nueva Colecta',
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (ctx) => NuevaColectaDialog(viewModel: viewModel),
                  );
                },
              ),
            ],
          ),
          body: groups.isEmpty
              ? _buildEmptyState(context)
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Header info box
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0F5132), Color(0xFF166534)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 24,
                            child: Text('👥', style: TextStyle(fontSize: 24)),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Causas en Comunidad',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${groups.length} grupos activos uniendo amigos para hacer sonreír a un niño esta Navidad.',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'Tus Colectas & Grupos Activos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 12),

                    ...groups.map((group) => _buildGroupCard(context, group)),
                  ],
                ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: AppTheme.rubyRed,
            foregroundColor: Colors.white,
            icon: const Icon(Icons.group_add),
            label: const Text('Crear Colecta con Amigos'),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (ctx) => NuevaColectaDialog(viewModel: viewModel),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🎄', style: TextStyle(fontSize: 54)),
            const SizedBox(height: 16),
            const Text(
              'No tienes colectas activas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Crea un grupo con tus amigos de la universidad, trabajo o familia para comprar el regalo de un niño.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppTheme.textMuted),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Iniciar mi primera colecta'),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (ctx) => NuevaColectaDialog(viewModel: viewModel),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupCard(BuildContext context, ColectaGroup group) {
    final messages = viewModel.getMessages(group.id);
    final contributions = viewModel.getContributions(group.id);

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ColectaDetailScreen(
                group: group,
                viewModel: viewModel,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          group.nombreGrupo,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppTheme.textDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${group.localidadNombre}  •  ${group.pilarTexto}',
                          style: const TextStyle(
                            color: AppTheme.pineGreen,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  FestiveBadge(
                    text: '${group.diasRestantes} días',
                    backgroundColor: AppTheme.lightGold,
                    textColor: AppTheme.festiveGold,
                    icon: Icons.access_time,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                group.descripcion,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: AppTheme.textMuted, fontSize: 13),
              ),
              const SizedBox(height: 14),
              ProgressStatBar(
                current: group.montoActual,
                target: group.metaGrupo,
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.people_alt_outlined, size: 16, color: AppTheme.textMuted),
                      const SizedBox(width: 4),
                      Text(
                        '${group.amigosParticipantes.length} amigos',
                        style: const TextStyle(color: AppTheme.textMuted, fontSize: 12),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.chat_bubble_outline, size: 16, color: AppTheme.textMuted),
                      const SizedBox(width: 4),
                      Text(
                        '${messages.length}',
                        style: const TextStyle(color: AppTheme.textMuted, fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '${contributions.length} aportes',
                        style: const TextStyle(
                          color: AppTheme.emerald,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.chevron_right, size: 18, color: AppTheme.textMuted),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
