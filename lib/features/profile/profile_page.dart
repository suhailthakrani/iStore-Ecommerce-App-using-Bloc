import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/home/home_bloc.dart';
import '../../blocs/signin/signin_bloc.dart';
import '../../repositories/authentication_repository.dart';
import '../auth/sign_in_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
            if (state is HomeLogoutState) {
                AuthenticationRepository authRepository =
                    AuthenticationRepository();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: BlocProvider.of<SignInBloc>(context),
                      child: SignInPage(
                        signInBloc: SignInBloc(authRepository),
                      ),
                    ),
                  ),
                );
              }
        },
        child: ElevatedButton(
          onPressed: () {
            context.read<HomeBloc>().add(HomeLogoutButtonPressedEvent());
          },
          child: const Text("Log Out"),
        ),
      ),
    );
  }
}
