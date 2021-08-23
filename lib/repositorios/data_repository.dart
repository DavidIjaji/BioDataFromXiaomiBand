class DataRepository {
  static final DataRepository _instancia = DataRepository._internal();

  factory DataRepository() {
    return _instancia;
  }

  DataRepository._internal();
}