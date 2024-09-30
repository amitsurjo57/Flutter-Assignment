import 'package:flutter/material.dart';
import 'package:greeting_app/utils/common_color.dart';

class TamAppbar extends StatelessWidget implements PreferredSizeWidget{
  const TamAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CommonColor.commonColor,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Icon(Icons.logout),
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
                'Amit Banik Surjo',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'surjo@gmail.com',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
