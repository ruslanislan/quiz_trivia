import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/category.dart';
import '../../domain/usecases/get_categories.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategories getCategories;

  CategoriesBloc(this.getCategories) : super(CategoriesInitial()) {
    on<CategoriesEvent>(_eventHandler);
  }

  Future<void> _eventHandler(
    CategoriesEvent event,
    Emitter<CategoriesState> emit,
  ) async {
    return switch (event) {
      GetCategoriesEvent() => _getCategories(event, emit),
    };
  }

  Future<void> _getCategories(
    GetCategoriesEvent event,
    Emitter<CategoriesState> emit,
  ) async {
    try {
      emit(CategoriesLoading());
      final categories = await getCategories();
      emit(CategoriesLoaded(categories));
    } on DioException catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }
}
