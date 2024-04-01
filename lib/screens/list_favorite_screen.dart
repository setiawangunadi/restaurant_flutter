import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/blocs/list_favorite/list_favorite_bloc.dart';
import 'package:restaurant/screens/components/card_item.dart';
import 'package:shimmer/shimmer.dart';

class ListFavoriteScreen extends StatefulWidget {
  const ListFavoriteScreen({super.key});

  @override
  State<ListFavoriteScreen> createState() => _ListFavoriteScreenState();
}

class _ListFavoriteScreenState extends State<ListFavoriteScreen> {
  late ListFavoriteBloc listFavoriteBloc;

  @override
  void initState() {
    listFavoriteBloc = BlocProvider.of<ListFavoriteBloc>(context);
    listFavoriteBloc.add(GetListRestaurant());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListFavoriteBloc, ListFavoriteState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "List Restaurant Favorite",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: state is OnSuccessListFavorite
              ? SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: state.dataBox.length > 0
                        ? List.generate(
                            state.dataBox.length,
                            (index) {
                              return CardItem(
                                id: state.dataBox[index].id,
                                title: state.dataBox[index].name,
                                location: state.dataBox[index].city,
                                rating: state.dataBox[index].rating.toString(),
                                pictureId: state.dataBox[index].pictureId,
                                description: state.dataBox[index].description,
                                detailType: "favorites",
                                index: index,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                              );
                            },
                          )
                        : [
                            Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.disabled_by_default_outlined,
                                      size: 32,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "You doesn't have favorite restaurant",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                  ),
                )
              : SingleChildScrollView(
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
        );
      },
    );
  }
}
