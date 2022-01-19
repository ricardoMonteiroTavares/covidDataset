/// Classe responsável por armazenar o valor de um determinado tipo,
/// podendo ser do tipo [K] ou [T]
class Or<K, T> {
  T? _right;
  K? _left;

  Or(dynamic value) {
    if (value == null) {
      throw ArgumentError("value is not null");
    }
    if (value.runtimeType == T) {
      _right = value;
      _left = null;
    } else if (value.runtimeType == K) {
      _right = null;
      _left = value;
    } else {
      throw TypeError();
    }
  }

  /// Busca o valor contido no objeto
  get value => _right ?? _left;

  /// Busca o tipo ao qual o valor contido pertence
  Type get type => value.runtimeType;
}
