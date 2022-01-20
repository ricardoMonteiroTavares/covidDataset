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
        body: Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Filtros:",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Text("UF: "),
                        DropdownButton<String>(
                          value: _bloc.state,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          menuMaxHeight: 300,
                          onChanged: _bloc.setState,
                          items: states
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Data: "),
                        Container(
                          padding: const EdgeInsets.only(left: 5),
                          constraints: const BoxConstraints(
                              maxWidth: 200, maxHeight: 30),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 0.2, color: Colors.black),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_bloc.date),
                              IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  Icons.calendar_today,
                                  size: 20,
                                  color: Colors.black54,
                                ),
                                onPressed: () =>
                                    _bloc.datePickerHandler(context),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                childAspectRatio: aspectRatio,
                crossAxisSpacing: 10,
                mainAxisSpacing: 2,
                crossAxisCount: 2,
                children: [
                  DataCardWidget(
                    title: "Total de Casos",
                    value: "XXX.XXX",
                    aspectRatio: aspectRatio,
                    color: Colors.orange.shade700,
                  ),
                  DataCardWidget(
                    title: "Total de Mortes",
                    value: "XXX.XXX",
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
            ),
          ],
        ),
      ),
    );
  }
}
