import 'package:brasil_data/core/enum/field_enum.dart';
import 'package:brasil_data/core/models/covid_input_model.dart';
import 'package:brasil_data/core/models/covid_registration_day_model.dart';
import 'package:brasil_data/core/models/covid_response_model.dart';
import 'package:brasil_data/core/services/impl/covid_service.dart';
import 'package:brasil_data/core/stateMagnement/bloc.dart';
import 'package:brasil_data/core/util/or.dart';
import 'package:brasil_data/core/widgets/date_picker.dart';
import 'package:flutter/cupertino.dart';

class CovidDataPageBloc extends Bloc {
  final _inputModel = CovidInputModel();
  final _service = CovidService();
  CovidResponseModel? _data;
  String? _state = "";

  fetchData() async {
    Or<CovidResponseModel, String> response =
        await _service.action(_inputModel);

    if (response.type == CovidResponseModel) {
      _data = response.value;
      sink.add(_data);
    } else {
      print(response.value);
    }
  }

  int get totalDepths => _total(FieldEnum.depths);

  int get totalCases => _total(FieldEnum.cases);

  String get depthPer100k => _totalPer100k(FieldEnum.depths);
  String get casesPer100k => _totalPer100k(FieldEnum.cases);

  String _totalPer100k(FieldEnum field) {
    int population = _total(FieldEnum.population);
    int value = _total(field);
    return ((value / population) * 10e4).round().toString();
  }

  int _total(FieldEnum field) {
    num result = 0;
    if (_data == null) {
      return result.toInt();
    }
    if (state == null || state!.isEmpty) {
      for (var element in _data!.results) {
        result += _getValueByField(element, field);
      }
    } else {
      result = _getValueByField(_data!.getDataByState(state), field);
    }
    return result.toInt();
  }

  num _getValueByField(CovidRegistrationDayModel? e, FieldEnum field) {
    if (e != null) {
      switch (field) {
        case FieldEnum.population:
          return e.estimatedPopulation;
        case FieldEnum.cases:
          return e.confirmed;
        case FieldEnum.depths:
          return e.deaths;
      }
    }
    return 0;
  }

  String? get state => _state;

  void setState(String? newState) {
    _state = newState;
    sink.add(_state);
  }

  String get date => _inputModel.date ?? '';

  Future<void> _setDate(String? newDate) async {
    _inputModel.isLast = (newDate == null);
    _inputModel.date = newDate;
    sink.add(_inputModel);
    await fetchData();
  }

  void datePickerHandler(BuildContext context) async {
    DateTime selected = date.isEmpty ? DateTime.now() : DateTime.parse(date);
    DateTime? response = await DatePicker.show(context, selected);
    if (response == null) {
      await _setDate(null);
    } else if (selected != response) {
      await _setDate(response.toString().split(" ").first);
    }
  }
}
