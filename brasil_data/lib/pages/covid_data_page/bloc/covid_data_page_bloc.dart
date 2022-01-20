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
  CovidResponseModel? _data; // TODO: Buscar os dados da Covid
  String? _state = "";

  fetchData() async {
    print("Inicio da busca");
    Or<CovidResponseModel, String> response =
        await _service.action(_inputModel);

    if (response.type == CovidResponseModel) {
      _data = response.value;
      sink.add(_data);
    } else {
      print(response.value);
    }
    print("Final da Busca");
  }

  int get totalDepths => _total("depth");

  int get totalCases => _total("cases");

  int _total(String field) {
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

  num _getValueByField(CovidRegistrationDayModel? e, String field) {
    if (e != null) {
      if (field == "depth") {
        return e.deaths;
      } else if (field == "cases") {
        return e.confirmed;
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
