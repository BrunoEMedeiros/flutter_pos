import 'package:flutter/material.dart';

class StatusText extends StatelessWidget {
  final String status;
  const StatusText({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == 'CREATED') {
      return const SizedBox(height: 30, child: Text('Agendada'));
    } else if (status == 'INPROGRESS') {
      return const SizedBox(height: 30, child: Text('Viajando!'));
    } else {
      return const SizedBox(height: 30, child: Text('Ja fui'));
    }
  }
}
