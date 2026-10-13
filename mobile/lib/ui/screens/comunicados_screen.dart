import 'package:flutter/material.dart';
import '../../domain/models/foundation_post.dart';
import '../core/app_theme.dart';
import '../core/widgets/festive_badge.dart';
import '../view_models/foundation_view_model.dart';

class ComunicadosScreen extends StatelessWidget {
  final FoundationViewModel viewModel;

  const ComunicadosScreen({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final posts = viewModel.posts;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Canal Oficial Fundación'),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none),
                tooltip: 'Notificaciones',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Estás al día con todos los comunicados oficiales.'),
                    ),
                  );
                },
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Foundation Badge Banner
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.borderLight),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppTheme.pineGreen.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text('🎄', style: TextStyle(fontSize: 24)),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fundación Moderna',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppTheme.textDark,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Campaña Oficial "Regalos con Sonrisa" 2026',
                            style: TextStyle(
                              color: AppTheme.textMuted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const FestiveBadge(
                      text: 'Verificado',
                      backgroundColor: AppTheme.lightGold,
                      textColor: AppTheme.festiveGold,
                      icon: Icons.verified,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                'Novedades y Puntos de Entrega',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 12),

              ...posts.map((post) => _buildPostCard(context, post)),

              const SizedBox(height: 10),

              // Emergency & Volunteer Contact Card
              Card(
                color: AppTheme.lightGold.withValues(alpha: 0.4),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.headset_mic_outlined, color: AppTheme.festiveGold),
                          SizedBox(width: 8),
                          Text(
                            '¿Tienes dudas o quieres ser voluntario?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: AppTheme.textDark,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Escríbenos directamente a coordinacion@fundacionmoderna.org o visítanos en nuestra sede central de lunes a viernes.',
                        style: TextStyle(fontSize: 13, color: AppTheme.textDark),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.pineGreen,
                          side: const BorderSide(color: AppTheme.pineGreen),
                        ),
                        icon: const Icon(Icons.phone),
                        label: const Text('Contactar Mesa de Ayuda'),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: AppTheme.pineGreen,
                              content: Text('Línea de voluntariado: +591 700-12345'),
                            ),
                          );
                        },
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

  Widget _buildPostCard(BuildContext context, FoundationPost post) {
    Color badgeColor;
    Color badgeTextColor;

    switch (post.category) {
      case PostCategory.hito:
        badgeColor = AppTheme.emerald.withValues(alpha: 0.15);
        badgeTextColor = AppTheme.emerald;
        break;
      case PostCategory.logisticaEntrega:
        badgeColor = AppTheme.rubyRed.withValues(alpha: 0.15);
        badgeTextColor = AppTheme.rubyRed;
        break;
      case PostCategory.noticia:
      case PostCategory.agradecimiento:
        badgeColor = AppTheme.pineGreen.withValues(alpha: 0.15);
        badgeTextColor = AppTheme.pineGreen;
        break;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FestiveBadge(
                  text: post.categoryLabel,
                  backgroundColor: badgeColor,
                  textColor: badgeTextColor,
                ),
                Text(
                  '${post.date.day}/${post.date.month} • ${post.authorName}',
                  style: const TextStyle(color: AppTheme.textMuted, fontSize: 11),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              post.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              post.content,
              style: const TextStyle(
                fontSize: 14,
                height: 1.45,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 14),
            const Divider(height: 1),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => viewModel.likePost(post.id),
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Row(
                      children: [
                        const Icon(Icons.favorite, size: 18, color: AppTheme.rubyRed),
                        const SizedBox(width: 6),
                        Text(
                          '${post.likesCount} corazones',
                          style: const TextStyle(
                            color: AppTheme.rubyRed,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.share_outlined, size: 18, color: AppTheme.textMuted),
                  tooltip: 'Compartir comunicado',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Comunicado "${post.title}" listo para compartir.'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
