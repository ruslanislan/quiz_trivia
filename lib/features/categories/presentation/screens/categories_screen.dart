import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/resources/app_sizes.dart';
import '../../domain/entities/category.dart';
import '../../domain/usecases/get_categories.dart';
import '../bloc/categories_bloc.dart';
import '../dialogs/category_config_dialog.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: BlocProvider<CategoriesBloc>(
        create: (BuildContext context) => CategoriesBloc(
          GetCategories(context.read()),
        )..add(GetCategoriesEvent()),
        child: _buildBody(),
      ),
    );
  }

  BlocBuilder<CategoriesBloc, CategoriesState> _buildBody() {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (BuildContext context, CategoriesState state) {
        return switch (state) {
          CategoriesInitial() => const SizedBox.shrink(),
          CategoriesLoading() =>
            const Center(child: CircularProgressIndicator()),
          CategoriesLoaded() => ListView.separated(
              itemCount: state.categories.length,
              itemBuilder: (BuildContext context, int index) {
                final category = state.categories[index];
                return CategoryItem(
                  category: category,
                  onTap: () => _showConfigDialog(context, category),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return mediumGap;
              },
            ),
          CategoriesError() => Center(
              child: Text(state.message),
            ),
        };
      },
    );
  }

  Future<dynamic> _showConfigDialog(
    BuildContext context,
    Category category,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CategoryConfigDialog(
          onStart: ({
            required String difficult,
            required String type,
            required String numberOfQuestions,
          }) {
            context.go(
              '/quiz?difficult=$difficult&type=$type&totalQuestions=$numberOfQuestions',
              extra: category,
            );
          },
        );
      },
    );
  }
}
