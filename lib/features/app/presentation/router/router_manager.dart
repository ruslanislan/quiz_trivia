import 'package:go_router/go_router.dart';

import '../../../categories/data/models/category_model.dart';
import '../../../categories/presentation/screens/categories_screen.dart';
import '../../../quiz/presentation/screens/quiz_screen.dart';

class RouterManager {
  late final GoRouter router;

  RouterManager() {
    router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const CategoriesScreen(),
          routes: [
            GoRoute(
              path: '/quiz',
              builder: (context, state) {
                final type = state.uri.queryParameters['type']!;
                final difficulty = state.uri.queryParameters['difficult']!;
                final totalQuestionsStr =
                    state.uri.queryParameters['totalQuestions']!;
                final totalQuestions = int.parse(totalQuestionsStr);
                final category = state.extra as CategoryModel;
                return QuizScreen(
                  category: category,
                  difficulty: difficulty,
                  type: type,
                  totalQuestions: totalQuestions,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
