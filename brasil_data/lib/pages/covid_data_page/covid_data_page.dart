import 'package:brasil_data/core/models/user_model.dart';
import 'package:brasil_data/core/util/states.dart';
import 'package:brasil_data/core/widgets/data_card_widget.dart';
import 'package:brasil_data/core/widgets/profile_button_widget.dart';
import 'package:brasil_data/pages/covid_data_page/bloc/covid_data_page_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CovidDataPage extends StatefulWidget {
  final UserModel user;
  const CovidDataPage({Key? key, required this.user}) : super(key: key);

  @override
  _CovidDataPageState createState() => _CovidDataPageState();
}

class _CovidDataPageState extends State<CovidDataPage> {
  final _bloc = CovidDataPageBloc();
  final double aspectRatio = (kIsWeb) ? 3 : 2;
  @override
  void initState() {
    _bloc.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "PAINEL - DATA COVID BRASIL",
            style: TextStyle(fontFamily: "Odibee Sans"),
          ),
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
                  const Text(
                    "Filtro por Estado:",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Odibee Sans",
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: DropdownButton<String>(
                      value: _bloc.state,
                      icon: const Icon(Icons.arrow_drop_down),
                      isExpanded: true,
                      elevation: 16,
                      menuMaxHeight: 300,
                      onChanged: _bloc.setState,
                      items:
                          states.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: "Odibee Sans",
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              padding: const EdgeInsets.all(10),
              childAspectRatio: aspectRatio,
              crossAxisSpacing: 10,
              mainAxisSpacing: 2,
              crossAxisCount:
                  (kIsWeb && MediaQuery.of(context).size.width > 770) ? 2 : 1,
              children: [
                DataCardWidget(
                  title: "Total de Casos:",
                  value: _bloc.totalCases,
                  aspectRatio: aspectRatio,
                  color: Colors.orange.shade700,
                ),
                DataCardWidget(
                  title: "Total de Mortes:",
                  value: _bloc.totalDepths,
                  aspectRatio: aspectRatio,
                  color: Colors.red.shade800,
                ),
                DataCardWidget(
                  title: "Casos por 100 mil habitantes:",
                  value: _bloc.casesPer100k,
                  aspectRatio: aspectRatio,
                  color: Colors.amberAccent.shade700,
                ),
                DataCardWidget(
                  title: "Mortes por 100 mil habitantes:",
                  value: _bloc.depthPer100k,
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
