import 'package:ecomerc_app_with_admin/core/constant/string.dart';
import 'package:ecomerc_app_with_admin/core/routing/app_routing.dart';
import 'package:ecomerc_app_with_admin/features/checkout/presentation/bloc/checkout_cubit/checkout_cubit.dart';
import 'package:ecomerc_app_with_admin/features/checkout/presentation/widget/checkout_buttom.dart';
import 'package:ecomerc_app_with_admin/features/orders/data/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({
    super.key,
    required this.orders,
    required this.addressInfo,
    required this.customerInfo,
    required this.currentPayment,
  });
  final List<OrderItem> orders;
  final AddressInfo addressInfo;
  final CustomerInfo customerInfo;
  final String currentPayment;
  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(final BuildContext context) {
    final bool isdark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(
                widget.orders.length,
                (final index) => Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 92,
                        maxWidth: 337,
                      ),

                      child: Row(
                        children: [
                          _buildImage(index),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.orders[index].productName,
                                  style: Theme.of(context).textTheme.labelLarge!
                                      .copyWith(fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 10),
                                LayoutBuilder(
                                  builder: (final context, final constraints) =>
                                      SizedBox(
                                        width: constraints.maxWidth,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "\$${widget.orders[index].price.toStringAsFixed(1)}",
                                              style: Theme.of(
                                                context,
                                              ).textTheme.labelLarge,
                                            ),

                                            Text(
                                              widget.orders[index].quantity
                                                  .toString(),
                                            ),
                                          ],
                                        ),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        _buildTotalbox(context, isdark),
      ],
    );
  }

  // ignore: prefer_final_parameters
  Container _buildTotalbox(BuildContext context, final bool isdark) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 315,

      decoration: BoxDecoration(
        color: isdark ? Colors.black : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: isdark ? Colors.white : Colors.black26,
            spreadRadius: 3,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total", style: Theme.of(context).textTheme.bodySmall),
              Text(
                "\$${_totail(widget.orders).toStringAsFixed(1)}",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shipping Free",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                "\$10.0",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Divider(
            color: isdark ? Colors.white : Colors.black,
            indent: 20,
            endIndent: 20,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Subtotal", style: Theme.of(context).textTheme.titleSmall),
              Text(
                "\$${(_totail(widget.orders) + 10.0).toStringAsFixed(1)}",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const Spacer(),
          CheckoutButtom(
            text: "Confrom order",
            ontap: () {
              final order = OrderModel(
                orderId: "ORD--${DateTime.now().microsecondsSinceEpoch}",
                userId: "",
                status: "send success",
                createdAt: DateTime.now(),
                customer: widget.customerInfo,
                address: widget.addressInfo,
                payment: PaymentInfo(
                  paymentMethod: "cash",
                  paymentStatus: "Pending",
                  transactionId: "",
                  currency: "egp",
                ),
                items: widget.orders,
                total: _totail(widget.orders),
              );
              if (widget.currentPayment.contains(AppStrings.cash)) {
                context.read<CheckoutCubit>().sendOrder(order);
                final cubit = context.read<CheckoutCubit>();
                print(context.read<CheckoutCubit>().state);
                Navigator.pushNamed(
                  context,
                  AppRouting.checkoutsucess,

                  arguments: ChecoutArg(order: order, cubit: cubit),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  double _totail(final List<OrderItem> orders) {
    double totail = 0;
    for (var order in orders) {
      totail += order.finalPrice;
    }
    return totail;
  }

  ClipRRect _buildImage(final int index) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(12),
      child: Image.network(
        widget.orders[index].image,
        height: 83.02,
        width: 92.53,
        loadingBuilder: (final context, final child, final loadingProgress) {
          if (loadingProgress != null) {
            return const CircularProgressIndicator();
          }
          return child;
        },
      ),
    );
  }
}
