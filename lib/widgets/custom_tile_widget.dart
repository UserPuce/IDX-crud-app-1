import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomTileWidget extends StatelessWidget {
  final IconData lead;
  final String label;
  final IconData end;
  final String route;

  const CustomTileWidget({
    super.key,
    required this.lead,
    required this.label,
    required this.route,
    this.end = Icons.arrow_right,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).hoverColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        leading: Icon(lead, color: Theme.of(context).primaryColor),
        title: Text(label, style: TextStyle(color: Theme.of(context).primaryColor)),
        trailing: Icon(end, color: Theme.of(context).primaryColor),
        onTap: () => context.push(route),
      ),
    );
  }
}
