import 'package:ecommerce_app/feature/app/domain/entities/category_entity.dart';
import 'package:ecommerce_app/feature/app/presentation/page/app_page.dart';
import 'package:ecommerce_app/feature/app/presentation/page/home/bloc/home_bloc.dart';
import 'package:ecommerce_app/feature/app/presentation/page/home/page/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatefulWidget {
  static route({required CategoryEntity categoryEntity}) => MaterialPageRoute(
      builder: (_) => ProductsPage(categoryEntity: categoryEntity));
  final CategoryEntity categoryEntity;

  const ProductsPage({super.key, required this.categoryEntity});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    context
        .read<HomeBloc>()
        .add(ProductPageLoad(categoryId: widget.categoryEntity.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 10,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const AppPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(-1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
              (route) => false,
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
            color: Colors.black,
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
            color: Colors.black,
          ),
        ],
        title: Text(
          widget.categoryEntity.name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          } else if (state is ProductLoaded) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      ProductDetailPage.route(product: product),
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Stack(
                            children: [
                              Image.network(
                                product.images.first,
                                height: 180,
                                width: 150,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.error,
                                    size: 150,
                                  );
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    );
                                  }
                                },
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          product.category.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '\$${product.price}.00',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is HomeError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('No results found'),
            );
          }
        },
      ),
    );
  }
}
