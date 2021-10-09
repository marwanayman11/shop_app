import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
 final searchController = TextEditingController();
 final  formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      defaultForm(
                          controller: searchController,
                          type: TextInputType.text,
                          label: 'Search',
                          prefix: Icons.search,
                          validate: (value) {
                            if (formKey.currentState!.validate()) {
                              return 'Search can\'t be empty';
                            } else {
                              return null;
                            }
                          },
                          onChange: (value) {
                            SearchCubit.get(context).productSearch(value);
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      if (state is LoadingSearchState) const LinearProgressIndicator(),
                      const SizedBox(
                        height: 10,
                      ),
                      if (state is SuccessSearchState)
                        Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return searchBuilder(
                                    SearchCubit.get(context)
                                        .searchModel!
                                        .data
                                        .data1[index],
                                    context);
                              },
                              separatorBuilder: (context, index) => const SizedBox(
                                    height: 10,
                                  ),
                              itemCount: SearchCubit.get(context)
                                  .searchModel!
                                  .data
                                  .data1
                                  .length),
                        )
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (context, state) {}),
    );
  }
}

Widget searchBuilder(SearchProductsDataModel? model, context) => Card(
      color: Colors.white,
      elevation: 10,
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(
                    image: NetworkImage(model!.image),
                    width: 150,
                    height: 150,
                  ),

                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.aladin(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.aladin(color: Colors.blue),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      const Spacer(),
                CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  model.inFavorites
                                      ? Colors.green
                                      : Colors.grey,
                              child: const Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
