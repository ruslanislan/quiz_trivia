part of 'categories_bloc.dart';

sealed class CategoriesState {
  final List<Category> categories;

  CategoriesState(this.categories);
}

class CategoriesInitial extends CategoriesState {
  CategoriesInitial() : super([]);
}

class CategoriesLoading extends CategoriesState {
  CategoriesLoading() : super([]);
}

class CategoriesLoaded extends CategoriesState {
  CategoriesLoaded(super.categories);
}

class CategoriesError extends CategoriesState {
  final String message;

  CategoriesError(this.message) : super([]);
}
