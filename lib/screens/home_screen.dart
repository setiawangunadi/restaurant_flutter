import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/blocs/home/home_bloc.dart';
import 'package:restaurant/screens/components/card_item.dart';
import 'package:restaurant/screens/components/text_title.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(GetListRestaurant());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(Icons.search),
              )
            ],
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextTitle(),
                SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      state is OnSuccessHome
                          ? state.listRestaurantResponseModel.count ?? 0
                          : 5,
                      (index) => state is OnSuccessHome
                          ? CardItem(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                            )
                          : Shimmer.fromColors(
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
