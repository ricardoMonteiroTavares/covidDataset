import 'package:brasil_data/core/models/covid_input_model.dart';
import 'package:brasil_data/core/models/covid_response_model.dart';
import 'package:brasil_data/core/stateMagnement/bloc.dart';

class CovidDataPageBloc extends Bloc {
  final CovidInputModel _inputModel = CovidInputModel();
  CovidResponseModel? _lastData;

  fetchData([String? state, String? initialDate, String? finalDate]) {
    bool stateIsNull = state == null;
    bool initialDateIsNull = initialDate == null;
    bool finalDateIsNull = finalDate == null;
    if (!stateIsNull) {
      _inputModel.state = state;
    }
    if (initialDateIsNull && finalDateIsNull) {
      _inputModel.isLast = true;
    } else {
      _inputModel.isLast = false;
      _inputModel.date = state;
    }
  }

  String? get state => _inputModel.state;

  void setState(String? newState) {
    _inputModel.state = newState;
    sink.add(_inputModel);
  }

  String get date => _inputModel.date ?? '';

  void setDate(String? newDate) {
    _inputModel.date = newDate;
    sink.add(_inputModel);
  }
}
