import 'package:brasil_data/core/models/covid_input_model.dart';
import 'package:brasil_data/core/models/covid_response_model.dart';
import 'package:brasil_data/core/stateMagnement/bloc.dart';
import 'package:brasil_data/core/widgets/date_picker.dart';
import 'package:flutter/cupertino.dart';

class CovidDataPageBloc extends Bloc {
  final CovidInputModel _inputModel = CovidInputModel();
  CovidResponseModel? _lastData; // TODO: Buscar os dados da Covid

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

  void _setDate(String? newDate) {
    _inputModel.date = newDate;
    sink.add(_inputModel);
  }

  void datePickerHandler(BuildContext context) async {
    DateTime selected = date.isEmpty ? DateTime.now() : DateTime.parse(date);
    DateTime? response = await DatePicker.show(context, selected);
    if (response == null) {
      _setDate(null);
    } else if (selected != response) {
      _setDate(response.toString().split(" ").first);
    }
  }
}
