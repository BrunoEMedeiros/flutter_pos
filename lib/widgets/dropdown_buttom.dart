import 'package:flutter/material.dart';

class StatusDropDown extends StatefulWidget {
  final String initialValue;
  final Function funcao;
  const StatusDropDown(
      {super.key, required this.initialValue, required this.funcao});

  @override
  State<StatusDropDown> createState() => _StatusDropDownState();
}

class _StatusDropDownState extends State<StatusDropDown> {
  late String? valueField;
  @override
  void initState() {
    valueField = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isDense: true,
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      iconSize: 30,
      itemHeight: 50,
      isExpanded: true,
      value: valueField,
      onChanged: (String? value) {
        setState(() {
          widget.funcao(value);
          valueField = value;
        });
      },
      items: const [
        DropdownMenuItem<String>(
          value: 'CREATED',
          child: Center(
              child: Text(
            "Agendado",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
        ),
        DropdownMenuItem<String>(
          value: 'INPROGRESS',
          child: Center(
              child: Text(
            "Viajando",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
        ),
        DropdownMenuItem<String>(
          value: 'FINISHED',
          child: Center(
              child: Text(
            "Ja fui",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
        ),
      ],
    );
  }
}
