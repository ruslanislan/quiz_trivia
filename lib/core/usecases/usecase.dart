abstract interface class UseCase<T, Params> {
  Future<T> call(Params params);
}

abstract interface class UseCaseWithoutParams<T> {
  Future<T> call();
}
