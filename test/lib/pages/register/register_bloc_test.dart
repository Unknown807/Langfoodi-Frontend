import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_social_media/forms/bloc/base_form.dart';
import 'package:recipe_social_media/pages/register/register_bloc.dart';
import '../../../../test_utilities/mocks/generic_mocks.dart';

void main() {
  late AuthenticationRepositoryMock authRepoMock;
  late NetworkManagerMock networkManagerMock;

  setUp(() {
    authRepoMock = AuthenticationRepositoryMock();
    networkManagerMock = NetworkManagerMock();
    when(() => networkManagerMock.isNetworkConnected()).thenAnswer((invocation) => Future.value(true));
  });

  group("formSubmitted method tests", () {
    blocTest("form submission success",
      build: () {
        when(() => authRepoMock.register(any(), any(), any(), any())).thenAnswer((invocation) => Future.value(""));
        return RegisterBloc(authRepo: authRepoMock, networkManager: networkManagerMock);
      },
      act: (bloc) => bloc.add(const FormSubmitted()),
      expect: () => [
        const InputState(formStatus: FormzSubmissionStatus.inProgress, errorMessage: ""),
        const InputState(formStatus: FormzSubmissionStatus.success, errorMessage: "")
      ]
    );

    blocTest("form submission failure",
      build: () {
        when(() => authRepoMock.register(any(), any(), any(), any())).thenAnswer((invocation) => Future.value("form error"));
        return RegisterBloc(authRepo: authRepoMock, networkManager: networkManagerMock);
      },
      act: (bloc) => bloc.add(const FormSubmitted()),
      expect: () => [
        const InputState(formStatus: FormzSubmissionStatus.inProgress, errorMessage: ""),
        const InputState(formStatus: FormzSubmissionStatus.failure, errorMessage: "form error")
      ]
    );
    
    blocTest("network connectivity issue, form submission failure",
      build: () {
        when(() => networkManagerMock.isNetworkConnected()).thenAnswer((invocation) => Future.value(false));
        return RegisterBloc(authRepo: authRepoMock, networkManager: networkManagerMock);
      },
      act: (bloc) => bloc.add(const FormSubmitted()),
      expect: () => [
        const InputState(
          formStatus: FormzSubmissionStatus.failure,
          errorMessage: "Network Issue Encountered"
        )
      ]
    );
  });
}