import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/pages/add_connection/bloc/add_connection_bloc.dart';

class AddConnectionPage extends StatelessWidget {
  const AddConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddConnectionBloc(),
      child: Scaffold(
      ),
    );
  }
}