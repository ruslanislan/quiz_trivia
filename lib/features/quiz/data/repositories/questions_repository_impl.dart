import '../../domain/entities/question.dart';
import '../../domain/repositories/questions_repository.dart';
import '../datasources/local_questions_data_source.dart';
import '../datasources/remote_questions_data_source.dart';

class QuestionsRepositoryImpl implements QuestionsRepository {
  final LocalQuestionsDataSource _localQuestionsDataSource;
  final RemoteQuestionsDataSource _remoteQuestionsDataSource;

  QuestionsRepositoryImpl({
    required LocalQuestionsDataSource localQuestionsDataSource,
    required RemoteQuestionsDataSource remoteQuestionsDataSource,
  })  : _localQuestionsDataSource = localQuestionsDataSource,
        _remoteQuestionsDataSource = remoteQuestionsDataSource;

  @override
  Future<List<Question>> getQuestions({
    required int categoryId,
    required String? type,
    required String? difficulty,
    required int totalQuestions,
  }) async {
    final localQuestions = await _localQuestionsDataSource.getQuestions(
      categoryId: categoryId,
      type: type,
      difficulty: difficulty,
      totalQuestions: totalQuestions,
    );

    if (localQuestions.isNotEmpty) {
      return localQuestions;
    }

    final questions = await _remoteQuestionsDataSource.getQuestions(
      categoryId: categoryId,
      type: type,
      difficulty: difficulty,
      totalQuestions: totalQuestions,
    );

    _localQuestionsDataSource.cacheQuestions(questions, categoryId);
    return questions;
  }
}
