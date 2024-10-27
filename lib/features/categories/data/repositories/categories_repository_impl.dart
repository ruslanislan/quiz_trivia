import '../../domain/entities/category.dart';
import '../../domain/repositories/categories_repository.dart';
import '../datasources/local_categories_data_source.dart';
import '../datasources/remote_categories_data_source.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final RemoteCategoriesDataSource _remoteCategoriesDataSource;
  final LocalCategoriesDataSource _localCategoriesDataSource;

  CategoriesRepositoryImpl(
      {required RemoteCategoriesDataSource remoteCategoriesDataSource,
      required LocalCategoriesDataSource localCategoriesDataSource})
      : _remoteCategoriesDataSource = remoteCategoriesDataSource,
        _localCategoriesDataSource = localCategoriesDataSource;

  @override
  Future<List<Category>> getCategories() async {
    final localCategories = await _localCategoriesDataSource.getCategories();
    if (localCategories.isNotEmpty) {
      return localCategories;
    }

    final categories = await _remoteCategoriesDataSource.getCategories();
    _localCategoriesDataSource.cacheCategories(categories);
    return categories;
  }
}
