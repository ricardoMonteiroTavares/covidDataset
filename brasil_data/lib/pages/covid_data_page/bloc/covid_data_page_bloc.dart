import 'package:brasil_data/core/enum/field_enum.dart';
import 'package:brasil_data/core/mixins/has_get_user.dart';
import 'package:brasil_data/core/models/covid_input_model.dart';
import 'package:brasil_data/core/models/covid_registration_day_model.dart';
import 'package:brasil_data/core/models/covid_response_model.dart';
import 'package:brasil_data/core/models/user_model.dart';
import 'package:brasil_data/core/routes/app_routes.dart';
import 'package:brasil_data/core/services/impl/covid_service.dart';
import 'package:brasil_data/core/stateMagnement/bloc.dart';
import 'package:brasil_data/core/util/or.dart';
import 'package:flutter/cupertino.dart';

class CovidDataPageBloc extends Bloc with HasAndGetUser {
  final _inputModel = CovidInputModel();
  final _service = CovidService();
  UserModel? _user;

  String? _errorMsg;
  CovidResponseModel? _data;
  String? _state = "";

  loadUser(BuildContext context) async {
    if (await hasUser()) {
      Or<UserModel, String> response = await getUser();
      _user = response.value;
      sink.add(user);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.login, (route) => false);
    }
  }

  fetchData() async {
    Or<CovidResponseModel, String> response =
        await _service.action(_inputModel);

    if (response.type == CovidResponseModel) {
      _errorMsg = null;
      _data = response.value;
      sink.add(_data);
    } else {
      _errorMsg = response.value;
    }
    sink.add(_errorMsg);
  }

  UserModel? get user => _user;

  String? get errorMsg => _errorMsg;

  int? get totalDepths => _total(FieldEnum.depths);

  int? get totalCases => _total(FieldEnum.cases);

  int? get depthPer100k => _totalPer100k(FieldEnum.depths);
  int? get casesPer100k => _totalPer100k(FieldEnum.cases);

  int? _totalPer100k(FieldEnum field) {
    int? population = _total(FieldEnum.population);
    int? value = _total(field);
    if (value == null || population == null) {
      return null;
    }
    return ((value / population) * 10e4).round();
  }

  int? _total(FieldEnum field) {
    num result = 0;
    if (_data == null) {
      return null;
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
}
