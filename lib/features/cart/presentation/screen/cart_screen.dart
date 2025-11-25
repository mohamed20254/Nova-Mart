import 'package:ecomerc_app_with_admin/core/routing/app_routing.dart';
import 'package:ecomerc_app_with_admin/core/theme/app_theme.dart';
import 'package:ecomerc_app_with_admin/features/cart/domain/entity/cart_entity.dart';
import 'package:ecomerc_app_with_admin/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (final context, final state) {
          if (state is CartFailure) {
            return const SizedBox();
          }
          if (state is CartLoaded) {
            double total = 0;
            for (var element in state.data) {
              total += element.totalPrice;
            }
            return DecoratedBox(
              decoration: const BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "total:",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      total.toString(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, AppRouting.checkout);
                      },
                      child: Text(
                        "checkout",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
      appBar: AppBar(
        title: Text("Cart", style: Theme.of(context).textTheme.bodyLarge),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (final context, final state) {
          if (state is CartLoding) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartFailure) {
            return Center(child: Text(state.message));
          }
          if (state is CartLoaded) {
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (final context, final index) {
                return Dismissible(
                  key: Key(state.data[index].product.title),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (final direction) {
                    context.read<CartCubit>().removeItem(
                      id: state.data[index].product.id,
                    );
                  },
                  background: Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(color: Colors.red),
                    child: const Icon(
                      Icons.delete_rounded,
                      color: Colors.white,
                    ),
                  ),

                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRouting.prudicdetils,
                        arguments: state.data[index].product,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Row(
                          children: [
                            Image.network(
                              state.data[index].product.images[0],
                              height: 80,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 10),
                                  Text(
                                    state.data[index].product.title,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelMedium,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: Row(
                                children: [
                                  _buildAddandminus(
                                    context,

                                    ontap: () async {
                                      ubdateQuntitiy(
                                        index: index,
                                        state: state,
                                        context: context,
                                        amount: 1,
                                      );
                                    },

                                    icon: Icons.add,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    child: Text(
                                      state.data[index].quantity.toString(),
                                    ),
                                  ),
                                  _buildAddandminus(
                                    context,
                                    ontap: () {
                                      if (state.data[index].quantity > 0) {
                                        ubdateQuntitiy(
                                          index: index,
                                          state: state,
                                          context: context,
                                          amount: -1,
                                        );
                                      }
                                    },
                                    icon: Icons.remove,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
    );
  }

  InkWell _buildAddandminus(
    final BuildContext context, {
    required final void Function() ontap,
    required final IconData icon,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        height: 25.h,
        width: 25.w,

        decoration: BoxDecoration(
          color: AppTheme.isdark(context) ? Colors.black : Colors.white,
          border: Border.all(color: Theme.of(context).primaryColor),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20.w),
      ),
    );
  }

  ubdateQuntitiy({
    required final int index,
    required final CartLoaded state,
    required final BuildContext context,
    required final int amount,
  }) {
    final box = Hive.box("cart");

    final items = box.values
        .map((final e) => CartItem.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    final indexoddata = items.indexWhere(
      (final element) => element.product.id == state.data[index].product.id,
    );

    if (indexoddata == -1) return;

    final currentItem = items[indexoddata];

    final updatedItem = currentItem.ubdatequantity(
      currentItem.quantity + amount,
    );

    box.putAt(indexoddata, updatedItem.toJson());

    context.read<CartCubit>().getcart();
  }
}
