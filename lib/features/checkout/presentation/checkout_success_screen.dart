import 'package:ecomerc_app_with_admin/core/constant/app_images.dart';
import 'package:ecomerc_app_with_admin/core/routing/app_routing.dart';
import 'package:ecomerc_app_with_admin/features/checkout/presentation/bloc/checkout_cubit/checkout_cubit.dart';
import 'package:ecomerc_app_with_admin/features/checkout/presentation/widget/checkout_buttom.dart';
import 'package:ecomerc_app_with_admin/features/orders/data/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutSuccessScreen extends StatelessWidget {
  const CheckoutSuccessScreen({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        child: BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (final context, final state) {
            if (state is Checkoutlodaing) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CheckoutFailure) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.message),
                      CheckoutButtom(
                        text: "try again",
                        ontap: () {
                          context.read<CheckoutCubit>().sendOrder(order);
                        },
                      ),
                      const SizedBox(height: 20),
                      CheckoutButtom(
                        text: "back",
                        ontap: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRouting.mainScreen,
                            // ignore: prefer_final_parameters
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is Checkoutfinish) {
              return Padding(
                padding: const EdgeInsets.all(25),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20 + kToolbarHeight),
                      Center(
                        child: SizedBox(
                          height: 240,
                          width: 240,
                          child: Image.asset(
                            AppImages.checotsucess,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Text(
                        "Your order has been\n placed successfully",
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Thank you for choosing us! Feel free to continue shopping and explore our wide range of \n products. Happy Shopping!",
                        style: Theme.of(context).textTheme.labelLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      CheckoutButtom(
                        text: "Continue Shopping",
                        ontap: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRouting.mainScreen,
                            // ignore: prefer_final_parameters
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container(height: 50, color: Colors.red);
          },
        ),
      ),
    );
  }
}
