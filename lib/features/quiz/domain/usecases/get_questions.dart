import '../../../../core/usecases/usecase.dart';
import '../entities/question.dart';
import '../repositories/questions_repository.dart';

class GetQuestionsParams {
  final int categoryId;
  final String? type;
  final String? difficulty;
  final int totalQuestions;

  const GetQuestionsParams({
    required this.categoryId,
    this.type,
    this.difficulty,
    required this.totalQuestions,
  });
}

class GetQuestions implements UseCase<List<Question>, GetQuestionsParams> {
  final QuestionsRepository repository;

  GetQuestions(this.repository);

  @override
  Future<List<Question>> call(GetQuestionsParams params) async {
    return await repository.getQuestions(
      categoryId: params.categoryId,
      type: params.type,
      difficulty: params.difficulty,
      totalQuestions: params.totalQuestions,
    );
  }
}
