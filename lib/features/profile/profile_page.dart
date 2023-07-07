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
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeLogoutState) {
            AuthenticationRepository authRepository =
                AuthenticationRepository();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: BlocProvider.of<SignInBloc>(context),
                  child: const SignInPage(),
                ),
              ),
            );
          }
        },
        child: ListView(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.grey.shade200,
                    Colors.grey.shade100,
                    Colors.grey.shade200,
                    Colors.white,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              // child: Stack(
              //   children: [

              //     Align(
              //       alignment: Alignment.center,
              //       child: Padding(
              //         padding: const EdgeInsets.only(bottom: 20),
              //         child: Container(
              //           width: 120,
              //           height: 120,
              //           decoration: BoxDecoration(
              //             shape: BoxShape.circle,
              //             border: Border.all(
              //               color: Colors.white,
              //               width: 5,
              //             ),
              //             boxShadow: [
              //               BoxShadow(
              //                 color: Colors.black26,
              //                 blurRadius: 8,
              //                 offset: Offset(0, 4),
              //               ),
              //             ],
              //             image: DecorationImage(
              //               image: AssetImage('assets/profile_image.jpg'),
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
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
