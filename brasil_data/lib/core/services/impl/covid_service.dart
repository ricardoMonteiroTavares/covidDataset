import 'package:brasil_data/core/models/covid_input_model.dart';
import 'package:brasil_data/core/models/covid_response_model.dart';
import 'package:brasil_data/core/repositories/impl/covid_repository.dart';
import 'package:brasil_data/core/services/interface/service.dart';
import 'package:brasil_data/core/util/or.dart';

class CovidService implements Service<CovidInputModel, CovidResponseModel> {
  CovidRepository repository = CovidRepository();

  @override
  Future<Or<CovidResponseModel, String>> action(CovidInputModel data) async {
    try {
      Map<String, dynamic> json = await repository.get(data);
      return Or<CovidResponseModel, String>(CovidResponseModel.fromJson(json));
    } catch (e) {
      return Or<CovidResponseModel, String>(e.toString());
    }
  }
}
