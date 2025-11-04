import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSectionProfile extends StatelessWidget {
  final IconData icon;
  final Widget title;
  final Widget? trailing;
  final String subtitle;
  final void Function()? onTap;

  const CustomSectionProfile({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: ListTile(
        onTap: onTap,
        subtitle: Text(subtitle),
        subtitleTextStyle: Theme.of(context).textTheme.labelMedium,
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: title,
        trailing: trailing,
        titleTextStyle: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
