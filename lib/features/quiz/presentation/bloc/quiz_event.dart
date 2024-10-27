part of 'quiz_bloc.dart';

sealed class QuizEvent {}

class GetQuestionsEvent extends QuizEvent {
  final String type;
  final String difficulty;
  final int totalQuestions;
  final Category category;

  GetQuestionsEvent({
    required this.type,
    required this.difficulty,
    required this.totalQuestions,
    required this.category,
  });
}

class AnswerQuestionEvent extends QuizEvent {
  final int currentIndex;
  final int correctAnswers;
  final String selectedAnswer;

  AnswerQuestionEvent({
    required this.currentIndex,
    required this.correctAnswers,
    required this.selectedAnswer,
  });
}

class NextQuestionEvent extends QuizEvent {
  final int currentIndex;
  final int correctAnswers;
  final String selectedAnswer;

  NextQuestionEvent({
    required this.currentIndex,
    required this.correctAnswers,
    required this.selectedAnswer,
  });
}
