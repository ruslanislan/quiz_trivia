import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/datasources/questions_data_source.dart';
import '../models/question_model.dart';

const _questionsKey = 'questions_key';

class LocalQuestionsDataSource implements QuestionsDataSource {
  final SharedPreferences _sharedPreferences;

  LocalQuestionsDataSource(this._sharedPreferences);

  @override
  Future<List<QuestionModel>> getQuestions({
    required int categoryId,
    required String? type,
    required String? difficulty,
    required int totalQuestions,
  }) async {
    final questions =
        _sharedPreferences.getStringList(_questionsKey + categoryId.toString());

    if (questions == null) {
      return [];
    }

    final filteredQuestions = questions.where((e) {
      final question = QuestionModel.fromJson(jsonDecode(e));
      return (type == null || question.type == type) &&
          (difficulty == null || question.difficulty == difficulty);
    }).toList();

    if (filteredQuestions.length < totalQuestions) {
      return [];
    }

    final result = filteredQuestions
        .map((e) => QuestionModel.fromJson(jsonDecode(e)))
        .toList();
    return result;
  }

  void cacheQuestions(List<QuestionModel> questions, int categoryId) {
    final oldQuestions =
        _sharedPreferences.getStringList(_questionsKey + categoryId.toString());

    if (oldQuestions != null) {
      final oldQuestionsModels = oldQuestions
          .map((e) => QuestionModel.fromJson(jsonDecode(e)))
          .toList();

      questions = [
        ...oldQuestionsModels,
        ...questions,
      ];
    }

    _sharedPreferences.setStringList(
      _questionsKey + categoryId.toString(),
      questions.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }
}
