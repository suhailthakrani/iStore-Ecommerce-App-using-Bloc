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
        child: ListView(
          children: [
            Container(
              height: 200,
              decoration: ShapeDecoration(
                shape: const RoundedRectangleBorder(),
                gradient: SweepGradient(
                  colors: [
                    Colors.grey.shade300,
                    Colors.grey.shade100,
                    Colors.grey.shade200,
                     Colors.grey.shade300,
                    Colors.grey.shade100,
                    Colors.grey.shade200,
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            ProfileTile(
              icon: Icons.person,
              title: 'My Account',
              onTap: () {
                // Add your logic for handling the "My Account" tile tap
              },
            ),
            ProfileTile(
              icon: Icons.location_on,
              title: 'Shipping Address',
              onTap: () {
                // Add your logic for handling the "Shipping Address" tile tap
              },
            ),
            ProfileTile(
              icon: Icons.credit_card,
              title: 'Payment Methods',
              onTap: () {
                // Add your logic for handling the "Payment Methods" tile tap
              },
            ),
            ProfileTile(
              icon: Icons.favorite,
              title: 'My Favorites',
              onTap: () {
                // Add your logic for handling the "My Favorites" tile tap
              },
            ),
            ProfileTile(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {
                // Add your logic for handling the "Settings" tile tap
              },
            ),
            ProfileTile(
              icon: Icons.exit_to_app,
              title: 'Logout',
              onTap: () {
                context.read<HomeBloc>().add(HomeLogoutButtonPressedEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
