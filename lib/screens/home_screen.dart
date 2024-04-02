import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/blocs/home/home_bloc.dart';
import 'package:restaurant/config/app_routes.dart';
import 'package:restaurant/config/widget/toast/custom_toast.dart';
import 'package:restaurant/screens/components/card_item.dart';
import 'package:restaurant/screens/components/text_title.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  static const String title = 'Home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc homeBloc;

  TextEditingController controllerSearch = TextEditingController();
  bool isSearchMode = false;

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(GetListRestaurant());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is OnSuccessHome) {
          setState(() {
            isSearchMode = true;
          });
        }
        if (state is OnErrorHome) {
          AppToast.show(context, state.errorMessage ?? "", Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.listFavorite,
                ),
                child: const Icon(Icons.favorite),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.settings,
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(Icons.settings),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextTitle(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  child: TextFormField(
                    controller: controllerSearch,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      hintText: "Search Your Favorite Restaurant",
                      hintStyle: TextStyle(fontSize: 14),
                      suffixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          isSearchMode = true;
                        });
                        homeBloc.add(DoSearchRestaurant(value));
                      } else {
                        setState(() {
                          isSearchMode = false;
                        });
                      }
                    },
                  ),
                ),
                if (state is OnSuccessHome)
                  SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        state.listRestaurantResponseModel.count ?? 0,
                        (index) => CardItem(
                          id: state.listRestaurantResponseModel
                                  .restaurants?[index].id ??
                              "",
                          title: state.listRestaurantResponseModel
                                  .restaurants?[index].name ??
                              "",
                          location: state.listRestaurantResponseModel
                                  .restaurants?[index].city ??
                              "",
                          rating: state.listRestaurantResponseModel
                                  .restaurants?[index].rating
                                  .toString() ??
                              "",
                          pictureId: state.listRestaurantResponseModel
                                  .restaurants?[index].pictureId ??
                              "",
                          description: state.listRestaurantResponseModel
                                  .restaurants?[index].description ??
                              "",
                          detailType: "home",
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                      ),
                    ),
                  ),
                if (state is OnSuccessSearch)
                  SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        state.searchRestaurantResponseModel.founded ?? 0,
                        (index) => CardItem(
                          id: state.searchRestaurantResponseModel
                                  .restaurants?[index].id ??
                              "",
                          title: state.searchRestaurantResponseModel
                                  .restaurants?[index].name ??
                              "",
                          location: state.searchRestaurantResponseModel
                                  .restaurants?[index].city ??
                              "",
                          rating: state.searchRestaurantResponseModel
                                  .restaurants?[index].rating
                                  .toString() ??
                              "",
                          pictureId: state.searchRestaurantResponseModel
                                  .restaurants?[index].pictureId ??
                              "",
                          description: state.searchRestaurantResponseModel
                                  .restaurants?[index].description ??
                              "",
                          detailType: "home",
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                      ),
                    ),
                  ),
                if (state is OnLoadingHome)
                  SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        5,
                        (index) => Shimmer.fromColors(
                          direction: ShimmerDirection.ltr,
                          period: const Duration(milliseconds: 1200),
                          baseColor: Colors.grey.withOpacity(0.5),
                          highlightColor: Colors.white,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
