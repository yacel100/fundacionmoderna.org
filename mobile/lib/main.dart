import 'package:flutter/material.dart';
import 'data/colectas_repository.dart';
import 'ui/core/app_theme.dart';
import 'ui/screens/comunicados_screen.dart';
import 'ui/screens/home_campaigns_screen.dart';
import 'ui/screens/mi_impacto_screen.dart';
import 'ui/screens/mis_colectas_screen.dart';
import 'ui/view_models/foundation_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = ColectasRepository();
  final viewModel = FoundationViewModel(repository: repository);
  viewModel.init();

  runApp(FundacionModernaApp(viewModel: viewModel));
}

class FundacionModernaApp extends StatelessWidget {
  final FoundationViewModel viewModel;

  const FundacionModernaApp({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fundación Moderna - Misión Navidad',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: MainNavigationScaffold(viewModel: viewModel),
    );
  }
}

class MainNavigationScaffold extends StatefulWidget {
  final FoundationViewModel viewModel;

  const MainNavigationScaffold({super.key, required this.viewModel});

  @override
  State<MainNavigationScaffold> createState() => _MainNavigationScaffoldState();
}

class _MainNavigationScaffoldState extends State<MainNavigationScaffold> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeCampaignsScreen(viewModel: widget.viewModel),
      MisColectasScreen(viewModel: widget.viewModel),
      ComunicadosScreen(viewModel: widget.viewModel),
      MiImpactoScreen(viewModel: widget.viewModel),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppTheme.borderLight, width: 0.8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: Colors.white,
          selectedItemColor: AppTheme.rubyRed,
          unselectedItemColor: AppTheme.textMuted,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard_outlined),
              activeIcon: Icon(Icons.card_giftcard),
              label: 'Explorar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined),
              activeIcon: Icon(Icons.group),
              label: 'Colectas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.campaign_outlined),
              activeIcon: Icon(Icons.campaign),
              label: 'Canal Oficial',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(Icons.favorite),
              label: 'Mi Impacto',
            ),
          ],
        ),
      ),
    );
  }
}
