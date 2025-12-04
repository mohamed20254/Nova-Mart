import 'package:ecomerc_app_with_admin/core/constant/app_lottie.dart';
import 'package:ecomerc_app_with_admin/core/responsive/app_size.dart';
import 'package:ecomerc_app_with_admin/core/theme/widget/app_widget.dart';
import 'package:ecomerc_app_with_admin/features/Home/presentation/bloc/cubit/category_cubit.dart';
import 'package:ecomerc_app_with_admin/features/Home/presentation/bloc/prudic_cubit/product_cubit.dart';
import 'package:ecomerc_app_with_admin/features/Home/presentation/widget/carousel_slider.dart';
import 'package:ecomerc_app_with_admin/features/Home/presentation/widget/custom_appbar.dart';
import 'package:ecomerc_app_with_admin/features/Home/presentation/widget/custom_clipp_path.dart';
import 'package:ecomerc_app_with_admin/features/Home/presentation/widget/custom_search.dart';
import 'package:ecomerc_app_with_admin/features/Home/presentation/widget/custome_gride_view.dart';
import 'package:ecomerc_app_with_admin/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lottie/lottie.dart';

class HomeScrren extends StatefulWidget {
  const HomeScrren({super.key});

  @override
  State<HomeScrren> createState() => _HomeScrrenState();
}

class _HomeScrrenState extends State<HomeScrren> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        context.read<ProductCubit>().getProduct(isloademore: true);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipPath(
              clipper: MyCustomClipper(),
              child: SizedBox(
                height: AppSize.hight(context) * 0.44,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      height: AppSize.hight(context) * 0.44,
                    ),
                    _posinedContaner(-100),
                    _posinedContaner(100),
                    DecoratedBox(
                      decoration: const BoxDecoration(),
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ===============Appbar
                              InkWell(
                                onTap: () async {},
                                child: const CustomAppbar(),
                              ),
                              SizedBox(height: AppSize.hight(context) * 0.01),
                              //================search
                              const CustomSearch(),

                              SizedBox(height: AppSize.spacehight2(context)),
                              //=================TextCategores
                              _buileText(
                                context,
                                AppLocalizations.of(context)!.popularCategories,
                              ),
                              SizedBox(height: AppSize.spacehight1(context)),
                              //=================section
                              _buildSection(
                                label: "electronic",
                                child: const Icon(
                                  Iconsax.activity_copy,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const CarouselSlider(),
            SizedBox(height: AppSize.spacehight1(context)),
            Text(
              "  ${AppLocalizations.of(context)!.popularProducts}",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(height: 0.0),
            ),
            SizedBox(height: AppSize.spacehight1(context)),
            BlocBuilder<ProductCubit, ProductState>(
              builder: (final context, final state) {
                if (state is ProductLodingState) {
                  return Center(child: Lottie.asset(AppLottie.loading));
                } else if (state is ProductFailureState) {
                  return Column(
                    children: [
                      Text(
                        state.messige,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<ProductCubit>().getProduct();
                        },
                        child: const Text("try agin"),
                      ),
                    ],
                  );
                } else if (state is ProductSuccessState) {
                  return CustomeGrideView(products: state.products);
                }
                return const SizedBox();
              },
            ),
            // true
            //     ? Align(
            //         alignment: Alignment.bottomCenter,
            //         child: CircularProgressIndicator(),
            //       )
            //     : SizedBox(),
          ],
        ),
      ),
    );
  }

  Expanded _buildSection({
    required final String label,
    required final Widget child,
  }) {
    return Expanded(
      child: SizedBox(
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (final context, final state) {
            if (state is CategoryFailure) {
              AppWidget.showsnackbar(context, state.messige);
              return const Icon(Icons.error);
            } else if (state is CategoryLoding) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CategorySuccess) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.categores.length,
                itemBuilder: (final context, final index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          height: 50.h,
                          width: 50.w,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            state.categores[index].image,
                            loadingBuilder:
                                (
                                  final context,
                                  final child,
                                  final loadingProgress,
                                ) {
                                  if (loadingProgress == null) return child;
                                  return const CircularProgressIndicator(
                                    color: Colors.black,
                                  );
                                },
                            errorBuilder:
                                (final context, final error, final stackTrace) {
                                  return const Icon(Icons.error);
                                },
                          ),
                        ),
                        SizedBox(height: AppSize.spacehight1(context)),
                        Text(
                          state.categores[index].name,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall!.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Text _buileText(final BuildContext context, final String text) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium!.copyWith(color: Colors.white),
    );
  }

  Positioned _posinedContaner(final double top) {
    return Positioned(
      top: top,
      right: -200,
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color.fromARGB(255, 81, 105, 240).withValues(alpha: 0.4),
        ),
      ),
    );
  }
}
