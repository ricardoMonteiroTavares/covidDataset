/// Modelo que representa os parâmetros para a busca de informações
class CovidModel {
  String? state;
  String? date;
  late bool isLast;
  int? cityIbgeCode;
  late int page;

  CovidModel({
    this.state,
    this.date,
    this.isLast = false,
    this.cityIbgeCode,
    this.page = 1,
  });

  @override
  String toString() {
    const String empty = '';
    String _cityCode = cityIbgeCode == null ? '' : cityIbgeCode.toString();
    String _isLast = isLast ? "True" : "False";
    return "?city_ibge_code=$_cityCode&date=${date ?? empty}&is_last=$_isLast&page=${page.toString()}&place_type=state&search=&state=${state ?? empty}";
  }
}
