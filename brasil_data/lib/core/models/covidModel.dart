/// Modelo para representar os parâmetros para a busca de informações
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
}
