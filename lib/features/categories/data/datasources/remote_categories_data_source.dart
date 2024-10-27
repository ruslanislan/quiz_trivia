import 'package:dio/dio.dart';

import '../../domain/datasources/categories_data_source.dart';
import '../models/category_model.dart';

class RemoteCategoriesDataSource implements CategoriesDataSource {
  final Dio _dio;

  RemoteCategoriesDataSource(this._dio);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _dio.get<Map<String, dynamic>>('/api_category.php');

    final data = response.data?['trivia_categories'] as List<dynamic>;

    return data.map((e) => CategoryModel.fromJson(e)).toList();
  }
}
