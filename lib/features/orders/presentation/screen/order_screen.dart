import 'package:ecomerc_app_with_admin/features/orders/presentation/bloc/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders", style: Theme.of(context).textTheme.bodyMedium),
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (final context, final state) {
          if (state is OrderLoding) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderFailure) {
            return Column(
              children: [
                Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                  ),
                  onPressed: () {
                    context.read<OrderCubit>().watchOrder();
                  },
                  child: Text(
                    "try again",
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall!.copyWith(color: Colors.white),
                  ),
                ),
              ],
            );
          }
          if (state is OrderLoaded) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (final context, final index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(
                        Iconsax.copy_success,
                        color: Colors.blue,
                      ),
                      title: Text(
                        "oeder id :${state.orders[index].orderId}",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Text(
                        state.orders[index].status,
                        style: Theme.of(context).textTheme.labelMedium!
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
