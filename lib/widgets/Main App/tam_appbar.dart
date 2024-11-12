import 'package:flutter/material.dart';
import 'package:greeting_app/screens/Profile/profile_screen.dart';
import 'package:greeting_app/screens/Starting%20Body/log_in_screen.dart';
import 'package:greeting_app/ui/controllers/auth_controllers.dart';
import 'package:greeting_app/utils/common_color.dart';

class TamAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool isProfileScreenOpen;

  const TamAppbar({
    super.key,
    this.isProfileScreenOpen = false,
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isProfileScreenOpen) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );
      },
      child: AppBar(
        backgroundColor: CommonColor.commonColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          InkWell(
            onTap: () => _onLogOut(context),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Icon(Icons.logout),
            ),
          ),
        ],
        title: Row(
          children: [
            const CircleAvatar(backgroundColor: Colors.white),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthControllers.userData?.fullName ?? ' ',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  AuthControllers.userData?.email ?? ' ',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onLogOut(var context) async {
    await AuthControllers.clearUserData();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LogInScreen(),
      ),
      (_) => false,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
