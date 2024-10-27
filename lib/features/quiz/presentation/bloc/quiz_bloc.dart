import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../categories/domain/entities/category.dart';
import '../../domain/entities/question.dart';
import '../../domain/usecases/get_questions.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final GetQuestions _getQuestions;

  QuizBloc(this._getQuestions) : super(QuizInitial()) {
    on<QuizEvent>(_eventHandler);
  }

  Future<void> _eventHandler(QuizEvent event, Emitter<QuizState> emit) async {
    return switch (event) {
      GetQuestionsEvent() => _loadQuestions(event, emit),
      NextQuestionEvent() => _nextQuestion(event, emit),
      AnswerQuestionEvent() => _answerQuestion(event, emit),
    };
  }

  void _loadQuestions(GetQuestionsEvent event, Emitter<QuizState> emit) async {
    try {
      emit(QuizLoading(state.questions));

      final type = event.type.contains('Any') ? null : event.type;
      final difficulty =
          event.difficulty.contains('Any') ? null : event.difficulty;

      final params = GetQuestionsParams(
        categoryId: event.category.id,
        type: type,
        difficulty: difficulty,
        totalQuestions: event.totalQuestions,
      );

      final questions = await _getQuestions(params);
      emit(
        QuizNextQuestion(
          currentIndex: 0,
          correctAnswers: 0,
          questions: questions,
        ),
      );
    } on DioException catch (e) {
      emit(QuizError(e.error.toString()));
    }
  }

  void _nextQuestion(NextQuestionEvent event, Emitter<QuizState> emit) {
    emit(QuizLoading(state.questions));

    if (event.currentIndex == state.questions.length - 1) {
      emit(QuizFinished(state.questions, event.correctAnswers));
      return;
    }

    emit(
      QuizNextQuestion(
        currentIndex: event.currentIndex + 1,
        correctAnswers: event.correctAnswers,
        questions: state.questions,
      ),
    );
  }

  void _answerQuestion(
    AnswerQuestionEvent event,
    Emitter<QuizState> emit,
  ) async {
    emit(QuizLoading(state.questions));

    final question = state.questions[event.currentIndex];
    final isCorrect = question.correctAnswer == event.selectedAnswer;
    final correctAnswers =
        isCorrect ? event.correctAnswers + 1 : event.correctAnswers;

    emit(
      QuizAnswered(
        currentIndex: event.currentIndex,
        correctAnswers: correctAnswers,
        selectedAnswer: event.selectedAnswer,
        questions: state.questions,
      ),
    );
  }
}
