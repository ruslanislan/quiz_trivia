import '../entities/category.dart';

abstract interface class CategoriesRepository {
  Future<List<Category>> getCategories();
}
