import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/home/home_bloc.dart';
import '../../blocs/signin/signin_bloc.dart';
import '../../repositories/authentication_repository.dart';
import '../auth/signin/sign_in_page.dart';

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
              height: MediaQuery.of(context).size.width * 0.5,
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
              child: Row(
                children: [
                  // Image.asset(
                  //   'assets/images/image.png', // Replace with your image asset path
                  //   width: 100, // Adjust the width as needed
                  //   height: 100, // Adjust the height as needed
                  // ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        CupertinoIcons.profile_circled,
                        size: MediaQuery.of(context).size.width * 0.28,
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                      ),
                    ),
                  ),

                  const SizedBox(
                      width:
                          10), // Optional spacing between the image and column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Suhail Thakrani',
                        style: TextStyle(
                          fontSize: 20,
                          color:  Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // SizedBox(height: 10),
                      Text(
                        'suhailthakrani12@gmail.com',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ProfileTile(
              icon: Icons.person_outline,
              title: 'My Account',
              onTap: () {
                // Add your logic for handling the "My Account" tile tap
              },
            ),
            ProfileTile(
              icon: Icons.location_on_outlined,
              title: 'Shipping Address',
              onTap: () {
                // Add your logic for handling the "Shipping Address" tile tap
              },
            ),
            ProfileTile(
              icon: Icons.credit_card_outlined,
              title: 'Payment Methods',
              onTap: () {
                // Add your logic for handling the "Payment Methods" tile tap
              },
            ),
            ProfileTile(
              icon: Icons.favorite_border,
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
              icon: Icons.exit_to_app_outlined,
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
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Theme.of(context).primaryColor,
        size: 16,
      ),
      onTap: onTap,
    );
  }
}
