import '../entities/question.dart';

abstract interface class QuestionsRepository {
  Future<List<Question>> getQuestions({
    required int categoryId,
    required String? type,
    required String? difficulty,
    required int totalQuestions,
  });
}
