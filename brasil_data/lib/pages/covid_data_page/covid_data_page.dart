import 'package:brasil_data/core/util/states.dart';
import 'package:brasil_data/pages/covid_data_page/bloc/covid_data_page_bloc.dart';
import 'package:flutter/material.dart';

class CovidDataPage extends StatefulWidget {
  const CovidDataPage({Key? key}) : super(key: key);

  @override
  _CovidDataPageState createState() => _CovidDataPageState();
}

class _CovidDataPageState extends State<CovidDataPage> {
  final _bloc = CovidDataPageBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            flex: 1,
            child: Column(
              children: [
                Row(
                  children: [
                    const Text("Estado: "),
                    DropdownButton<String>(
                      value: _bloc.state,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: _bloc.setState,
                      items:
                          states.map<DropdownMenuItem<String>>((String value) {
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
                      decoration: const BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: Border(
                          top: BorderSide(width: 1.0, color: Colors.black87),
                          left: BorderSide(width: 1.0, color: Colors.black87),
                          right: BorderSide(width: 1.0, color: Colors.black87),
                          bottom: BorderSide(width: 1.0, color: Colors.black87),
                        ),
                      ),
                      child: Text(_bloc.date),
                    )
                  ],
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 2,
              crossAxisCount: 2,
              children: [
                Card(
                  child: Column(
                    children: const [Text("Total de Casos"), Text("XXX.XXX")],
                  ),
                ),
                Card(
                  child: Column(
                    children: const [Text("Total de Mortes"), Text("XXX.XXX")],
                  ),
                ),
                Card(
                  child: Column(
                    children: const [
                      Text("Total de Casos em 24 horas"),
                      Text("XXX.XXX")
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: const [
                      Text("Total de Mortes em 24 horas"),
                      Text("XXX.XXX")
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
