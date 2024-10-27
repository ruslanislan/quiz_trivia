import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/datasources/categories_data_source.dart';
import '../models/category_model.dart';

const _categoriesKey = 'categories_key';

class LocalCategoriesDataSource implements CategoriesDataSource {
  final SharedPreferences _sharedPreferences;

  LocalCategoriesDataSource(this._sharedPreferences);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final categories = _sharedPreferences.getStringList(_categoriesKey);

    if (categories == null) {
      return [];
    }

    return categories
        .map((e) => CategoryModel.fromJson(jsonDecode(e)))
        .toList();
  }

  void cacheCategories(List<CategoryModel> categories) {
    _sharedPreferences.setStringList(
      _categoriesKey,
      categories.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }
}
