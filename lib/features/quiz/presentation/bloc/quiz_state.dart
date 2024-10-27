part of 'quiz_bloc.dart';

sealed class QuizState {
  final List<Question> questions;

  QuizState(this.questions);
}

class QuizInitial extends QuizState {
  QuizInitial() : super([]);
}

class QuizLoading extends QuizState {
  QuizLoading(super.questions);
}

class QuizError extends QuizState {
  final String message;

  QuizError(this.message) : super([]);
}

class QuizAnswered extends QuizState {
  final int currentIndex;
  final int correctAnswers;
  final String selectedAnswer;

  bool get isCorrect => questions[currentIndex].correctAnswer == selectedAnswer;

  QuizAnswered({
    required this.currentIndex,
    required this.correctAnswers,
    required this.selectedAnswer,
    required List<Question> questions,
  }) : super(questions);
}

class QuizNextQuestion extends QuizState {
  final int currentIndex;
  final int correctAnswers;

  QuizNextQuestion({
    required this.currentIndex,
    required this.correctAnswers,
    required List<Question> questions,
  }) : super(questions);
}

class QuizFinished extends QuizState {
  final int correctAnswers;

  QuizFinished(super.questions, this.correctAnswers);
}
