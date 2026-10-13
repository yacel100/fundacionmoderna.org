import 'package:flutter/material.dart';
import '../../domain/models/child_story.dart';
import '../core/app_theme.dart';
import '../core/widgets/festive_badge.dart';
import '../core/widgets/progress_stat_bar.dart';
import '../view_models/foundation_view_model.dart';
import 'nueva_colecta_dialog.dart';
import 'registrar_aporte_dialog.dart';
import 'colecta_detail_screen.dart';

class ChildDetailScreen extends StatelessWidget {
  final ChildStory child;
  final FoundationViewModel viewModel;

  const ChildDetailScreen({
    super.key,
    required this.child,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    // Current latest state of the child
    final currentChild = viewModel.children.firstWhere(
      (c) => c.id == child.id,
      orElse: () => child,
    );

    final relatedGroups =
        viewModel.groups.where((g) => g.childId == currentChild.id).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(currentChild.nombre),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            tooltip: 'Compartir historia',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppTheme.pineGreen,
                  content: Text(
                    'Enlace de la carta de ${currentChild.nombre} copiado para WhatsApp.',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header Card with festive gradient
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.pineGreen, Color(0xFF14532D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 46,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 42,
                      backgroundColor: AppTheme.lightGold,
                      child: Text(
                        currentChild.emoji,
                        style: const TextStyle(fontSize: 44),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    currentChild.nombre,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${currentChild.edad} años • ${currentChild.ciudadComunidad}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  FestiveBadge(
                    text: currentChild.estadoTexto,
                    backgroundColor: currentChild.estaCompleto
                        ? AppTheme.emerald
                        : AppTheme.festiveGold,
                    textColor: Colors.white,
                    icon: currentChild.estaCompleto
                        ? Icons.check_circle_outline
                        : Icons.star_outline,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Wish Highlight Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppTheme.lightGold.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.festiveGold.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('🎁', style: TextStyle(fontSize: 26)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Regalo Soñado para Navidad:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textDark,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                currentChild.deseoRegalo,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: AppTheme.textDark,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Categoría: ${currentChild.categoriaTexto}',
                                style: const TextStyle(
                                  color: AppTheme.textMuted,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Progress Box
                  const Text(
                    'Estado de la Colecta',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          ProgressStatBar(
                            current: currentChild.montoRecaudado,
                            target: currentChild.metaMonto,
                            height: 12,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                currentChild.estaCompleto
                                    ? '🎉 ¡Regalo 100% financiado!'
                                    : 'Faltan: \$${currentChild.restante.toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: currentChild.estaCompleto
                                      ? AppTheme.emerald
                                      : AppTheme.rubyRed,
                                ),
                              ),
                              Text(
                                '${relatedGroups.length} grupo(s) activo(s)',
                                style: const TextStyle(
                                  color: AppTheme.textMuted,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Child's Story
                  const Text(
                    'Carta e Historia',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentChild.historia,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: AppTheme.textDark,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Actions Section
                  const Text(
                    '¿Cómo puedes ayudar?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Button 1: Create Group with Friends
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.pineGreen,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      icon: const Icon(Icons.group_add_outlined),
                      label: const Text(
                        'Iniciar Colecta entre Amigos',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (ctx) => NuevaColectaDialog(
                            viewModel: viewModel,
                            preselectedChild: currentChild,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Button 2: Direct Contribution to Existing Group
                  if (relatedGroups.isNotEmpty) ...[
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        icon: const Icon(Icons.volunteer_activism_outlined),
                        label: Text(
                          'Aportar a "${relatedGroups.first.nombreGrupo}"',
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (ctx) => RegistrarAporteDialog(
                              group: relatedGroups.first,
                              viewModel: viewModel,
                            ),
                          );
                        },
                      ),
                    ),
                  ],

                  if (relatedGroups.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    const Text(
                      'Colectas de Amigos Activas para este Regalo',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...relatedGroups.map((g) => Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: AppTheme.lightGold,
                              child: Text('👥'),
                            ),
                            title: Text(
                              g.nombreGrupo,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Org: ${g.organizadorNombre} • \$${g.montoActual.toStringAsFixed(0)} recaudados',
                            ),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ColectaDetailScreen(
                                    group: g,
                                    viewModel: viewModel,
                                  ),
                                ),
                              );
                            },
                          ),
                        )),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
