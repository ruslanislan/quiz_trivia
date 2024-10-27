import 'dart:convert';

import 'package:dio/dio.dart';

import '../../domain/datasources/questions_data_source.dart';
import '../models/question_model.dart';

class RemoteQuestionsDataSource implements QuestionsDataSource {
  final Dio _dio;

  RemoteQuestionsDataSource(this._dio);

  @override
  Future<List<QuestionModel>> getQuestions({
    required int categoryId,
    required String? type,
    required String? difficulty,
    required int totalQuestions,
  }) async {
    final params = {
      'amount': totalQuestions,
      'category': categoryId,
      'type': type,
      'difficulty': difficulty,
      'encode': 'url3986',
    }..removeWhere((key, value) => value == null);

    final response = await _dio.get<Map<String, dynamic>>(
      '/api.php',
      queryParameters: params,
    );

    final encodedData = response.data?['results'] as List<dynamic>;

    final decoded =
        Uri.decodeComponent(json.encode(encodedData).replaceAll('%22', '\\"'));

    final data = jsonDecode(decoded) as List<dynamic>;

    return data.map((e) => QuestionModel.fromJson(e)).toList();
  }
}
