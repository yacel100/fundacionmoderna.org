import 'package:flutter_test/flutter_test.dart';
import 'package:fundacion_moderna/data/colectas_repository.dart';
import 'package:fundacion_moderna/main.dart';
import 'package:fundacion_moderna/ui/view_models/foundation_view_model.dart';

void main() {
  testWidgets('Fundacion Moderna smoke test', (WidgetTester tester) async {
    final repo = ColectasRepository();
    final vm = FoundationViewModel(repository: repo);
    await tester.runAsync(() async {
      await vm.init();
    });

    await tester.pumpWidget(FundacionModernaApp(viewModel: vm));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.textContaining('Fundación moderna', findRichText: true), findsWidgets);
    expect(find.text('Explorar'), findsOneWidget);
    expect(find.text('Colectas'), findsOneWidget);
  });
}
