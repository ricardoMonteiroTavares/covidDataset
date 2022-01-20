import 'package:brasil_data/core/models/user_model.dart';
import 'package:brasil_data/core/util/states.dart';
import 'package:brasil_data/core/widgets/data_card_widget.dart';
import 'package:brasil_data/core/widgets/profile_button_widget.dart';
import 'package:brasil_data/pages/covid_data_page/bloc/covid_data_page_bloc.dart';
import 'package:flutter/material.dart';

class CovidDataPage extends StatefulWidget {
  final UserModel user;
  const CovidDataPage({Key? key, required this.user}) : super(key: key);

  @override
  _CovidDataPageState createState() => _CovidDataPageState();
}

class _CovidDataPageState extends State<CovidDataPage> {
  final _bloc = CovidDataPageBloc();

  double calculateAspectRatio(Size size) {
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return (itemWidth / itemHeight);
  }

  @override
  void initState() {
    _bloc.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double aspectRatio =
        calculateAspectRatio(MediaQuery.of(context).size);
    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
              "Painel Covid - ${(_bloc.state == null || _bloc.state!.isEmpty) ? "Brasil" : _bloc.state}"),
          actions: [
            ProfileButtonWidget(
              user: widget.user,
            )
          ],
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("Filtro por Estado: "),
                  DropdownButton<String>(
                    value: _bloc.state,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    menuMaxHeight: 300,
                    onChanged: _bloc.setState,
                    items: states.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              primary: true,
              padding: const EdgeInsets.all(10),
              childAspectRatio: aspectRatio,
              crossAxisSpacing: 10,
              mainAxisSpacing: 2,
              crossAxisCount: 2,
              children: [
                DataCardWidget(
                  title: "Total de Casos",
                  value: _bloc.totalCases.toString(),
                  aspectRatio: aspectRatio,
                  color: Colors.orange.shade700,
                ),
                DataCardWidget(
                  title: "Total de Mortes",
                  value: _bloc.totalDepths.toString(),
                  aspectRatio: aspectRatio,
                  color: Colors.red.shade800,
                ),
                DataCardWidget(
                  title: "Total de Casos em 24 horas",
                  value: "XXX.XXX",
                  aspectRatio: aspectRatio,
                  color: Colors.amberAccent.shade700,
                ),
                DataCardWidget(
                  title: "Total de Mortes em 24 horas",
                  value: "XXX.XXX",
                  aspectRatio: aspectRatio,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
