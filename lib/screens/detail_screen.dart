import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/blocs/detail/detail_bloc.dart';
import 'package:restaurant/config/app_routes.dart';
import 'package:restaurant/config/constants.dart';
import 'package:restaurant/config/widget/loading_progress/stack_with_progress.dart';
import 'package:restaurant/config/widget/toast/custom_toast.dart';
import 'package:restaurant/data/models/restaurant_favorite_model.dart';
import 'package:restaurant/screens/components/text_title.dart';
import 'package:shimmer/shimmer.dart';

class DetailScreen extends StatefulWidget {
  final String id;

  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late DetailBloc detailBloc;

  List<String> listMenu = ["Foods", "Drinks"];

  @override
  void initState() {
    detailBloc = BlocProvider.of<DetailBloc>(context);
    detailBloc.add(GetDetailRestaurant(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailBloc, DetailState>(
      listener: (context, state) {
        if (state is OnSuccessAddFavorite) {
          Navigator.pushNamed(context, AppRoutes.home);
        }
        if (state is OnErrorDetail) {
          AppToast.show(context, state.errorMessage ?? "", Colors.red);
        }
      },
      builder: (context, state) {
        if (state is OnSuccessDetail) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Detail Restaurant",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            body: StackWithProgress(
              isLoading: state is OnLoadingAddFavorite,
              children: [
                SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.25,
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16.0),
                            bottomRight: Radius.circular(16.0),
                          ),
                        ),
                        child: Stack(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                "${Constants.baseUrlImageMedium}${state.detailRestaurantResponseModel.restaurant?.pictureId ?? ""}",
                                fit: BoxFit.fill,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () => detailBloc.add(
                                  DoAddFavorite(
                                    FavoriteRestaurant(
                                      id: state.detailRestaurantResponseModel
                                              .restaurant?.id ??
                                          "",
                                      rating: state
                                              .detailRestaurantResponseModel
                                              .restaurant
                                              ?.rating ??
                                          0,
                                      name: state.detailRestaurantResponseModel
                                              .restaurant?.name ??
                                          "",
                                      city: state.detailRestaurantResponseModel
                                              .restaurant?.city ??
                                          "",
                                      description: state
                                              .detailRestaurantResponseModel
                                              .restaurant
                                              ?.description ??
                                          "",
                                      pictureId: state
                                              .detailRestaurantResponseModel
                                              .restaurant
                                              ?.pictureId ??
                                          "",
                                    ),
                                    state.detailRestaurantResponseModel,
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  margin: const EdgeInsets.only(
                                    right: 16.0,
                                    bottom: 8.0,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextTitle(
                              title: state.detailRestaurantResponseModel
                                      .restaurant?.name ??
                                  "",
                              subtitle: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(state.detailRestaurantResponseModel
                                          .restaurant?.address ??
                                      ""),
                                ],
                              ),
                              margin: const EdgeInsets.only(bottom: 8.0),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            margin: const EdgeInsets.only(right: 16.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.orangeAccent,
                            ),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Text(
                                  state.detailRestaurantResponseModel.restaurant
                                          ?.rating
                                          .toString() ??
                                      "",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          state.detailRestaurantResponseModel.restaurant
                                  ?.city ??
                              "",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          state.detailRestaurantResponseModel.restaurant
                                  ?.description ??
                              "",
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          "Category",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          state.detailRestaurantResponseModel.restaurant
                                  ?.categories?.length ??
                              0,
                          (index) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                const Icon(Icons.arrow_circle_right_sharp),
                                const SizedBox(width: 8),
                                Text(
                                  state.detailRestaurantResponseModel.restaurant
                                          ?.categories?[index].name ??
                                      "",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          "Menus",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          listMenu.length,
                          (index) => GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRoutes.listFoodAndDrink,
                              arguments: {
                                "title": listMenu[index],
                                "listMenu": index == 0
                                    ? state.detailRestaurantResponseModel
                                        .restaurant?.menus?.foods
                                    : state.detailRestaurantResponseModel
                                        .restaurant?.menus?.drinks,
                              },
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Container(
                                padding: const EdgeInsets.all(32.0),
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    const Icon(Icons.menu_book),
                                    const SizedBox(width: 8),
                                    Text(
                                      listMenu[index],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          "Reviews",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.detailRestaurantResponseModel
                              .restaurant?.customerReviews?.length,
                          itemBuilder: (context, index) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state
                                            .detailRestaurantResponseModel
                                            .restaurant
                                            ?.customerReviews?[index]
                                            .name ??
                                        "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    state
                                            .detailRestaurantResponseModel
                                            .restaurant
                                            ?.customerReviews?[index]
                                            .date ??
                                        "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    state
                                            .detailRestaurantResponseModel
                                            .restaurant
                                            ?.customerReviews?[index]
                                            .review ??
                                        "",
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return Scaffold(
          body: Shimmer.fromColors(
            direction: ShimmerDirection.ltr,
            period: const Duration(milliseconds: 1200),
            baseColor: Colors.grey.withOpacity(0.5),
            highlightColor: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.25,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    color: Colors.grey,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 24,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    color: Colors.grey,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 24,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    color: Colors.grey,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 24,
                  margin: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 16.0,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    color: Colors.grey,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  margin: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 16.0,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    color: Colors.grey,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 24,
                  margin: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 16.0,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    2,
                    (index) => Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.2,
                      margin: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 16.0,
                      ),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
