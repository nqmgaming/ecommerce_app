import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/constants/colors_constant.dart';
import 'package:ecommerce_app/feature/app/presentation/page/home/bloc/home_bloc.dart';
import 'package:ecommerce_app/feature/app/presentation/page/home/page/products_page.dart';
import 'package:ecommerce_app/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static route() {
    return MaterialPageRoute(builder: (_) => const HomePage());
  }

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    context.read<HomeBloc>().add(HomeLoadCategories());
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  void _onSearchChanged() {
    context
        .read<HomeBloc>()
        .add(HomeSearchCategories(query: _searchController.text));
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        surfaceTintColor: ColorsConstant.whiteColor,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            CupertinoIcons.line_horizontal_3_decrease,
            color: ColorsConstant.blackColor,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: ColorsConstant.blackColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              CupertinoIcons.person_circle,
              color: ColorsConstant.whiteColor,
              size: 30,
            ),
          )
        ],
      ),
      backgroundColor: ColorsConstant.whiteColor,
      body: RefreshIndicator(
        color: ColorsConstant.blackColor,
        backgroundColor: ColorsConstant.whiteColor,
        onRefresh: () async {
          context.read<HomeBloc>().add(HomeLoadCategories());
        },
        child: BlocConsumer<HomeBloc, HomeState>(
          buildWhen: (previous, current) {
            if (previous is HomeLoaded && current is HomeLoaded) {
              return previous.categories != current.categories;
            }
            return true;
          },
          listener: (context, state) {
            if (state is HomeError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: ColorsConstant.redColor,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: ColorsConstant.whiteColor,
                            child: Card(
                              elevation: 0,
                              color: const Color.fromRGBO(243, 244, 246, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: TextField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                      color: ColorsConstant.greyColor,
                                    ),
                                    hintText: delegate.searchCategories,
                                    prefixIcon: const Icon(Icons.search),
                                    border: InputBorder.none,
                                  ),
                                  cursorColor: ColorsConstant.blackColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: ColorsConstant.whiteColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    ColorsConstant.blackColor.withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.tune,
                              color: ColorsConstant.blackColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (state is HomeLoading) ...[
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: CircularProgressIndicator(
                          color: ColorsConstant.blackColor,
                        ),
                      ),
                    ),
                  ] else if (state is HomeLoaded) ...[
                    GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.categories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3.5 / 4,
                      ),
                      itemBuilder: (context, index) {
                        final category = state.categories[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              ProductsPage.route(categoryEntity: category),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    CachedNetworkImageProvider(category.image),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black.withOpacity(0.5),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        category.icon,
                                        color: ColorsConstant.whiteColor,
                                        size: 40,
                                      ),
                                      Text(
                                        category.name,
                                        style: const TextStyle(
                                          color: ColorsConstant.whiteColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ] else if (state is HomeNoResults) ...[
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 100),
                          const Icon(
                            Icons.search_off,
                            size: 100,
                            color: ColorsConstant.greyColor,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            delegate.noCategoriesFound,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
