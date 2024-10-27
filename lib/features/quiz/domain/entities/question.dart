abstract interface class Question {
  abstract final String type;
  abstract final String difficulty;
  abstract final String category;
  abstract final String question;
  abstract final String correctAnswer;
  abstract final List<String> incorrectAnswers;

  List<String> get options;
}
