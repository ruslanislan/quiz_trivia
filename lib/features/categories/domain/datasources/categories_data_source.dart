import '../entities/category.dart';

abstract interface class CategoriesDataSource {
  Future<List<Category>> getCategories();
}
