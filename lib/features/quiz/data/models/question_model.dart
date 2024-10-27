import '../../domain/entities/question.dart';

class QuestionModel implements Question {
  @override
  final String type;
  @override
  final String difficulty;
  @override
  final String category;
  @override
  final String question;
  @override
  final String correctAnswer;
  @override
  final List<String> incorrectAnswers;

  QuestionModel({
    required this.type,
    required this.difficulty,
    required this.category,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      type: json['type'],
      difficulty: json['difficulty'],
      category: json['category'],
      question: json['question'],
      correctAnswer: json['correct_answer'],
      incorrectAnswers: List<String>.from(json['incorrect_answers']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'difficulty': difficulty,
      'category': category,
      'question': question,
      'correct_answer': correctAnswer,
      'incorrect_answers': incorrectAnswers,
    };
  }

  @override
  List<String> get options => [correctAnswer, ...incorrectAnswers]..shuffle();
}
