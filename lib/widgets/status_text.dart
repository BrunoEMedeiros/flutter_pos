import 'package:flutter/material.dart';

class StatusText extends StatelessWidget {
  final String status;
  const StatusText({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == 'CREATED') {
      return SizedBox(
          height: 30,
          child: Text('Agendada',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).textScaleFactor * 18)));
    } else if (status == 'INPROGRESS') {
      return SizedBox(
          height: 30,
          child: Text('Viajando!',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).textScaleFactor * 18)));
    } else {
      return SizedBox(
          height: 30,
          child: Text('Ja fui',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).textScaleFactor * 18)));
    }
  }
}
