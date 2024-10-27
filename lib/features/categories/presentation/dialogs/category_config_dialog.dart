import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/resources/app_sizes.dart';
import '../widgets/custom_dropdown.dart';

const _difficulties = ['Any Difficulty', 'Easy', 'Medium', 'Hard'];
const _types = ['Any Type', 'Multiple Choice', 'True/False'];

class CategoryConfigDialog extends StatefulWidget {
  const CategoryConfigDialog({
    super.key,
    required this.onStart,
  });

  final void Function({
    required String difficult,
    required String type,
    required String numberOfQuestions,
  }) onStart;

  @override
  State<CategoryConfigDialog> createState() => _CategoryConfigDialogState();
}

class _CategoryConfigDialogState extends State<CategoryConfigDialog> {
  String? _difficulty = _difficulties.first;
  String? _type = _types.first;

  final _numberOfQuestions = TextEditingController(text: '10');

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Quiz Configuration'),
              largeGap,
              TextField(
                controller: _numberOfQuestions,
                decoration: const InputDecoration(
                  labelText: 'Number of questions',
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(3),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  // Handle the change in number of questions
                },
              ),
              mediumGap,
              CustomDropdown(
                label: 'Select Difficulty',
                items: _difficulties,
                value: _difficulty,
                onChanged: (String? value) {
                  _difficulty = value;
                },
              ),
              mediumGap,
              CustomDropdown(
                label: 'Select Type',
                items: _types,
                value: _type,
                onChanged: (String? value) {
                  _type = value;
                },
              ),
              mediumGap,
              ElevatedButton(
                onPressed: _onStart,
                child: const Text('Start Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onStart() {
    Navigator.of(context).pop();

    final numberOfQuestions = _numberOfQuestions.text.trim();
    if (numberOfQuestions.isEmpty) {
      showErrorMessage('Number of questions is required');
      return;
    }

    widget.onStart(
      difficult: _difficulty!,
      type: _type!,
      numberOfQuestions: _numberOfQuestions.text.trim(),
    );
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Number of questions is required',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              smallGap,
              Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              mediumGap,
              ElevatedButton(
                onPressed: Navigator.of(context).pop,
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
