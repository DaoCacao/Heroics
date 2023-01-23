import 'package:flutter/material.dart';
import 'package:heroics/base/view_model.dart';

class ViewModelProvider<VM extends ViewModel> extends StatelessWidget {
  final VM Function() create;
  final Function(VM)? listener;
  final Widget Function(VM) builder;

  const ViewModelProvider({
    super.key,
    required this.create,
    this.listener,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) => builder(create());
}
