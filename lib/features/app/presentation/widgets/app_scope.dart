import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/dio_client/dio_client.dart';
import '../../../../core/interceptors/trivia_interceptor.dart';
import '../../../categories/data/datasources/local_categories_data_source.dart';
import '../../../categories/data/datasources/remote_categories_data_source.dart';
import '../../../categories/data/repositories/categories_repository_impl.dart';
import '../../../categories/domain/repositories/categories_repository.dart';
import '../../../quiz/data/datasources/local_questions_data_source.dart';
import '../../../quiz/data/datasources/remote_questions_data_source.dart';
import '../../../quiz/data/repositories/questions_repository_impl.dart';
import '../../../quiz/domain/repositories/questions_repository.dart';
import '../router/router_manager.dart';

class AppScope extends StatefulWidget {
  const AppScope({super.key, required this.prefs});

  final SharedPreferences prefs;

  @override
  State<AppScope> createState() => _AppScopeState();
}

class _AppScopeState extends State<AppScope> {
  final _routerManager = RouterManager();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<DioClient>(
          create: (BuildContext context) =>
              DioClient()..addInterceptors(TriviaInterceptor()),
        ),
        RepositoryProvider<CategoriesRepository>(
          create: (BuildContext context) => CategoriesRepositoryImpl(
            remoteCategoriesDataSource:
                RemoteCategoriesDataSource(context.read<DioClient>().dio),
            localCategoriesDataSource: LocalCategoriesDataSource(widget.prefs),
          ),
        ),
        RepositoryProvider<QuestionsRepository>(
          create: (BuildContext context) => QuestionsRepositoryImpl(
            localQuestionsDataSource: LocalQuestionsDataSource(widget.prefs),
            remoteQuestionsDataSource: RemoteQuestionsDataSource(
              context.read<DioClient>().dio,
            ),
          ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _routerManager.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
