import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/resources/app_sizes.dart';
import '../../../categories/data/models/category_model.dart';
import '../../domain/usecases/get_questions.dart';
import '../bloc/quiz_bloc.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({
    super.key,
    required this.category,
    required this.difficulty,
    required this.type,
    required this.totalQuestions,
  });

  final CategoryModel category;
  final String difficulty;
  final String type;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => QuizBloc(
        GetQuestions(context.read()),
      )..add(
          GetQuestionsEvent(
            type: type,
            difficulty: difficulty,
            totalQuestions: totalQuestions,
            category: category,
          ),
        ),
      child: BlocBuilder<QuizBloc, QuizState>(
        builder: (BuildContext context, QuizState state) {
          final counter = state is QuizAnswered
              ? state.currentIndex + 1
              : state is QuizNextQuestion
                  ? state.currentIndex + 1
                  : state is QuizFinished
                      ? state.questions.length
                      : 0;
          return Scaffold(
            appBar: AppBar(
              title: Text(category.name),
              actions: [
                Text('$counter/${state.questions.length}'),
                largeGap,
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: switch (state) {
                QuizInitial() => const Center(
                    child: Text('Quiz Initial'),
                  ),
                QuizLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                QuizError() => Center(
                    child: Text(state.message),
                  ),
                QuizAnswered() => _buildShortResult(state, context),
                QuizNextQuestion() => _showQuestion(state, context),
                QuizFinished() => _buildResult(state, context),
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildShortResult(QuizAnswered state, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Selected Answer: ${state.selectedAnswer}'),
        largeGap,
        Text(state.isCorrect ? 'Correct' : 'Incorrect'),
        largeGap,
        ElevatedButton(
          onPressed: () {
            context.read<QuizBloc>().add(
                  NextQuestionEvent(
                    currentIndex: state.currentIndex,
                    correctAnswers: state.correctAnswers,
                    selectedAnswer: state.selectedAnswer,
                  ),
                );
          },
          child: const Text('Next Question'),
        ),
      ],
    );
  }

  Widget _showQuestion(QuizNextQuestion state, BuildContext context) {
    final question = state.questions[state.currentIndex];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(question.question),
        largeGap,
        ...question.options.map(
          (answer) => Padding(
            padding: const EdgeInsets.all(2.0),
            child: ElevatedButton(
              onPressed: () {
                context.read<QuizBloc>().add(
                      AnswerQuestionEvent(
                        currentIndex: state.currentIndex,
                        correctAnswers: state.correctAnswers,
                        selectedAnswer: answer,
                      ),
                    );
              },
              child: Text(answer),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResult(QuizFinished state, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Correct Answers: ${state.correctAnswers}'),
        largeGap,
        ElevatedButton(
          onPressed: () {
            context.read<QuizBloc>().add(
                  GetQuestionsEvent(
                    type: type,
                    difficulty: difficulty,
                    totalQuestions: totalQuestions,
                    category: category,
                  ),
                );
          },
          child: const Text('Try Again'),
        ),
        largeGap,
        ElevatedButton(
          onPressed: () => context.pop(),
          child: const Text('Back to Categories'),
        ),
      ],
    );
  }
}
