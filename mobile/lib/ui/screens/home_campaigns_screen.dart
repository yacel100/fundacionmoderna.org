import 'package:flutter/material.dart';
import '../../domain/models/child_story.dart';
import '../core/app_theme.dart';
import '../core/widgets/festive_badge.dart';
import '../core/widgets/progress_stat_bar.dart';
import '../view_models/foundation_view_model.dart';
import 'child_detail_screen.dart';
import 'nueva_colecta_dialog.dart';

class HomeCampaignsScreen extends StatelessWidget {
  final FoundationViewModel viewModel;

  const HomeCampaignsScreen({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final children = viewModel.children;

        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                const Text('🎄 ', style: TextStyle(fontSize: 20)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Fundación Moderna',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Misión Navidad 2026',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.rubyRed,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border, color: AppTheme.rubyRed),
                tooltip: 'Padrinos activos',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppTheme.pineGreen,
                      content: Text(
                        '¡${viewModel.totalPadrinosActivos} padrinos y amigos ya están colaborando!',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () => viewModel.init(),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Hero Banner with stats
                _buildHeroBanner(context),

                const SizedBox(height: 18),

                // Search Bar
                TextField(
                  onChanged: (q) => viewModel.setSearchQuery(q),
                  decoration: InputDecoration(
                    hintText: 'Buscar por niño, regalo, ciudad o juguete...',
                    prefixIcon: const Icon(Icons.search, color: AppTheme.pineGreen),
                    suffixIcon: viewModel.searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => viewModel.setSearchQuery(''),
                          )
                        : null,
                  ),
                ),

                const SizedBox(height: 14),

                // Filter chips
                _buildCategoryFilters(),

                const SizedBox(height: 18),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cartas Navideñas (${children.length})',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const Text(
                      'Toca para ver detalles',
                      style: TextStyle(fontSize: 12, color: AppTheme.textMuted),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                if (children.isEmpty)
                  _buildNoResults()
                else
                  ...children.map((c) => _buildChildCard(context, c)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeroBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F5132), Color(0xFF166534)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.pineGreen.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const FestiveBadge(
                text: 'CAMPAÑA OFICIAL 2026',
                backgroundColor: AppTheme.lightGold,
                textColor: AppTheme.festiveGold,
                icon: Icons.star,
              ),
              Row(
                children: [
                  const Icon(Icons.calendar_month, color: Colors.white70, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    'Faltan días para Nochebuena',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            '¡Ningún niño sin regalo esta Navidad!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Organiza una colecta con tus amigos, familiares o compañeros y regalen una sonrisa.',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBannerKpi(
                  '\$${viewModel.totalMontoRecaudadoGeneral.toStringAsFixed(0)}',
                  'Recaudado Global',
                ),
                Container(width: 1, height: 26, color: Colors.white24),
                _buildBannerKpi(
                  '${viewModel.totalNinosCompletados}/${viewModel.children.length}',
                  'Metas Listas',
                ),
                Container(width: 1, height: 26, color: Colors.white24),
                _buildBannerKpi(
                  '${viewModel.groups.length}',
                  'Grupos de Amigos',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerKpi(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white60, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildCategoryFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: const Text('Todos'),
              selected: viewModel.selectedCategory == null,
              onSelected: (_) => viewModel.setCategoryFilter(null),
              selectedColor: AppTheme.pineGreen.withValues(alpha: 0.15),
              checkmarkColor: AppTheme.pineGreen,
            ),
          ),
          ...GiftCategory.values.map((cat) {
            final isSelected = viewModel.selectedCategory == cat;
            String label;
            switch (cat) {
              case GiftCategory.juguetes:
                label = '🧸 Juguetes';
                break;
              case GiftCategory.ropaCalzado:
                label = '👟 Ropa/Calzado';
                break;
              case GiftCategory.educacionArte:
                label = '🎨 Arte/Libros';
                break;
              case GiftCategory.deportes:
                label = '⚽ Deportes';
                break;
              case GiftCategory.tecnologia:
                label = '💻 Tecnología';
                break;
            }

            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(label),
                selected: isSelected,
                onSelected: (_) => viewModel.setCategoryFilter(cat),
                selectedColor: AppTheme.pineGreen.withValues(alpha: 0.15),
                checkmarkColor: AppTheme.pineGreen,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildChildCard(BuildContext context, ChildStory child) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChildDetailScreen(child: child, viewModel: viewModel),
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
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: AppTheme.lightGold,
                    child: Text(child.emoji, style: const TextStyle(fontSize: 28)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              child.nombre,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppTheme.textDark,
                              ),
                            ),
                            FestiveBadge(
                              text: child.estadoTexto,
                              backgroundColor: child.estaCompleto
                                  ? AppTheme.emerald.withValues(alpha: 0.15)
                                  : AppTheme.lightGold,
                              textColor: child.estaCompleto
                                  ? AppTheme.emerald
                                  : AppTheme.festiveGold,
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${child.edad} años • ${child.ciudadComunidad}',
                          style: const TextStyle(color: AppTheme.textMuted, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.softBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Text('🎁', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        child.deseoRegalo,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textDark,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              ProgressStatBar(
                current: child.montoRecaudado,
                target: child.metaMonto,
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    child.estaCompleto
                        ? '🎉 ¡Completado!'
                        : 'Faltan: \$${child.restante.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: child.estaCompleto ? AppTheme.emerald : AppTheme.rubyRed,
                    ),
                  ),
                  Row(
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          visualDensity: VisualDensity.compact,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (ctx) => NuevaColectaDialog(
                              viewModel: viewModel,
                              preselectedChild: child,
                            ),
                          );
                        },
                        child: const Text('Colecta con Amigos'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          visualDensity: VisualDensity.compact,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChildDetailScreen(child: child, viewModel: viewModel),
                            ),
                          );
                        },
                        child: const Text('Ver Carta'),
                      ),
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

  Widget _buildNoResults() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: const Center(
        child: Column(
          children: [
            Text('🔍', style: TextStyle(fontSize: 40)),
            SizedBox(height: 10),
            Text(
              'No se encontraron cartas navideñas',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              'Intenta con otra palabra clave o selecciona otra categoría.',
              style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
