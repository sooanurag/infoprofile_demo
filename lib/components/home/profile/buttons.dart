import 'package:flutter/material.dart';

import '../../../resources/colors.dart';
import '../../../resources/fonts.dart';
import '../../../utils/glassmorph_container.dart';

class ProfileButtons extends StatelessWidget {
  final VoidCallback editProfile;
  final VoidCallback share;
  final VoidCallback discoverUsers;
  const ProfileButtons({
    super.key,
    required this.editProfile,
    required this.share,
    required this.discoverUsers,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: editProfile,
            child: GlassmorphContainer(
              color: (Theme.of(context).brightness == Brightness.dark)
                  ? AppColors.darkPruple
                  : AppColors.grey,
              hzMargin: 0,
              borderRadius: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Edit profile",
                  style: AppFonts.headerStyle(
                      fontWeight: FontWeight.w600, context: context),
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: share,
          child: GlassmorphContainer(
            color: (Theme.of(context).brightness == Brightness.dark)
                ? AppColors.darkPruple
                : AppColors.grey,
            hzMargin: 0,
            borderRadius: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Share",
                style: AppFonts.headerStyle(
                    fontWeight: FontWeight.w600, context: context),
              ),
            ),
          ),
        ),
        const Spacer(),
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: discoverUsers,
          child: GlassmorphContainer(
              color: (Theme.of(context).brightness == Brightness.dark)
                  ? AppColors.darkPruple
                  : AppColors.grey,
              borderRadius: 10,
              hzMargin: 0,
              child: const Icon(Icons.person_add)),
        )
      ],
    );
  }
}
