import 'package:flutter/material.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/app/routes/routes.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'bloc/app.dart';

class App extends StatelessWidget {
  const App({super.key, required AuthenticationRepository authRepo})
      : _authRepo = authRepo;

  final AuthenticationRepository _authRepo;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepo,
      child: BlocProvider(
        create: (_) => AppBloc(authRepo: _authRepo),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Social Media',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
