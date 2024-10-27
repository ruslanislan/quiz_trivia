import '../../../../core/usecases/usecase.dart';
import '../entities/category.dart';
import '../repositories/categories_repository.dart';

class GetCategories implements UseCaseWithoutParams<List<Category>> {
  final CategoriesRepository _repository;

  GetCategories(this._repository);

  @override
  Future<List<Category>> call() async {
    return await _repository.getCategories();
  }
}
