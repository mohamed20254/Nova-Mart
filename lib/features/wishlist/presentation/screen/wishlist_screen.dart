import 'package:ecomerc_app_with_admin/core/routing/app_routing.dart';
import 'package:ecomerc_app_with_admin/features/wishlist/presentation/bloc/favorit_cuibt/favvorit_cubit.dart';
import 'package:ecomerc_app_with_admin/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    context.read<FavvoritCubit>().getFavorits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.wishlist,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: BlocBuilder<FavvoritCubit, FavvoritState>(
        builder: (context, state) {
          if (state is Favvorlodaing) {
            return Center(child: CircularProgressIndicator());
          } else if (state is Favvorfailure) {
            return Center(child: Text(state.message));
          }
          if (state is Favvorloaded) {
            return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10),

              itemCount: state.favorits.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(state.favorits[index].id.toString()),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    context.read<FavvoritCubit>().removeFav(
                      id: state.favorits[index].id,
                      context: context,
                    );
                  },
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRouting.prudicdetils,
                      arguments: state.favorits[index],
                    ),
                    child: ListTile(
                      title: Text(
                        state.favorits[index].title,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      leading: Image.network(
                        state.favorits[index].images[0],
                        height: 80.h,
                        fit: BoxFit.fill,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress != null) {
                            return CircularProgressIndicator();
                          }
                          return child;
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return Container();
        },
      ),
      // body: CustomeGrideView(),
    );
  }
}
