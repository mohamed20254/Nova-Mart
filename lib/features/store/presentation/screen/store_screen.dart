import 'package:ecomerc_app_with_admin/core/responsive/app_size.dart';
import 'package:ecomerc_app_with_admin/core/theme/app_theme.dart';
import 'package:ecomerc_app_with_admin/features/Home/presentation/widget/padge_card.dart';
import 'package:ecomerc_app_with_admin/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/custom_Flexible.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        scrolledUnderElevation: 0,
        title: Text(
          AppLocalizations.of(context)!.store,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [PadgeCard()],
      ),
      body: DefaultTabController(
        length: 5,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                scrolledUnderElevation: 0,
                pinned: true,
                floating: true,
                expandedHeight: 320.h,

                automaticallyImplyLeading: true,
                flexibleSpace: FlexibleSpaceBar(background: CustomFlexible()),

                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: TabBar(
                      indicatorColor: Theme.of(context).primaryColor,

                      isScrollable: true,
                      unselectedLabelColor: AppTheme.isdark(context)
                          ? Colors.white54
                          : Colors.black54,
                      tabAlignment: TabAlignment.start,
                      labelStyle: Theme.of(context).textTheme.bodySmall!
                          .copyWith(fontWeight: FontWeight.w500),
                      tabs: [
                        Tab(child: Text("mohamed")),
                        Tab(child: Text("mohamed")),
                        Tab(child: Text("mohamed")),
                        Tab(child: Text("mohamed")),
                        Tab(child: Text("mohamed")),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              _buildtabbarview(context),
              _buildtabbarview(context),
              _buildtabbarview(context),
              _buildtabbarview(context),
              _buildtabbarview(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildtabbarview(context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        SizedBox(height: AppSize.spacehight2(context)),
        // CustomeGrideView(),
      ],
    );
  }
}
