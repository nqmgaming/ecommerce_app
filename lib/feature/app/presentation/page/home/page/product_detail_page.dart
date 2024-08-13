import 'package:card_swiper/card_swiper.dart';
import 'package:ecommerce_app/feature/app/domain/entities/cart_entity.dart';
import 'package:ecommerce_app/feature/app/domain/entities/product_entity.dart';
import 'package:ecommerce_app/feature/app/presentation/page/cart/bloc/cart_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailPage extends StatefulWidget {
  static route({required ProductEntity product}) {
    return MaterialPageRoute(
      builder: (context) => ProductDetailPage(product: product),
    );
  }

  final ProductEntity product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _currentPage = 0;
  int _cartCount = 1;
  final List<String> _sizes = ["S", "M", "L", "XL", "XXL"];
  String? _sizeSelected;
  final List<Color> _colors = [
    Colors.indigo,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
  ];
  Color? _colorSelected;
  bool _isFavorite = false;
  CartEntity? _cart;

  void _showAlertDialog(BuildContext context, String message, Function onOk) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Alert"),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () {
                onOk();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartAdded) {
            _showAlertDialog(
              context,
              "Product added to cart",
              () {
                Navigator.pop(context);
              },
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                color: Colors.white,
              ),
              Container(
                color: Colors.white,
                width: double.infinity,
                height: 450,
                child: Stack(
                  children: [
                    Swiper(
                      itemCount: widget.product.images.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          widget.product.images[index],
                          fit: BoxFit.cover,
                        );
                      },
                      layout: SwiperLayout.DEFAULT,
                      itemWidth: MediaQuery.of(context).size.width,
                      itemHeight: MediaQuery.of(context).size.height,
                      autoplay: false,
                      onIndexChanged: (int index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                    ),
                    Positioned(
                      bottom: 40,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: ListTile(
                          leading: const Text(""),
                          titleAlignment: ListTileTitleAlignment.center,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: List.generate(
                              widget.product.images.length,
                              (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin:
                                    index == widget.product.images.length - 1
                                        ? const EdgeInsets.only(right: 0)
                                        : const EdgeInsets.only(right: 5),
                                height: 20,
                                width: 20,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: _currentPage == index
                                        ? Border.all(
                                            color: Colors.white,
                                            width: 1,
                                          )
                                        : null,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(0),
                          trailing: IconButton(
                            icon: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color:
                                    _isFavorite ? Colors.black : Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.favorite_border,
                                color:
                                    _isFavorite ? Colors.white : Colors.black,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _isFavorite = !_isFavorite;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 400,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height - 400,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.product.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: null,
                                    ),
                                    Text(
                                      widget.product.category.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        RatingBar.builder(
                                          itemSize: 15,
                                          glow: false,
                                          initialRating: 4,
                                          minRating: 0.5,
                                          direction: Axis.horizontal,
                                          allowHalfRating: false,
                                          itemCount: 5,
                                          tapOnlyMode: true,
                                          ignoreGestures: true,
                                          // Disable the RatingBar
                                          itemPadding:
                                              const EdgeInsets.only(right: 4.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                        const Text(
                                          "(320 Reviews)",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 40,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.remove,
                                            size: 14,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (_cartCount > 0) {
                                                _cartCount--;
                                              }
                                            });
                                          },
                                        ),
                                        Text(
                                          "$_cartCount",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.add,
                                            size: 14,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _cartCount++;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text("Available in stock",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Select Color",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: List.generate(
                              _colors.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _colorSelected = _colors[index];
                                  });
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: _colors[index],
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: _colorSelected == _colors[index]
                                          ? Colors.black
                                          : Colors.grey.shade200,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Select Size",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: List.generate(
                              _sizes.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _sizeSelected = _sizes[index];
                                  });
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: _sizeSelected == _sizes[index]
                                        ? Colors.black
                                        : Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: _sizeSelected == _sizes[index]
                                          ? Colors.black
                                          : Colors.grey.shade200,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _sizes[index],
                                      style: TextStyle(
                                          color: _sizeSelected == _sizes[index]
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Description",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.product.description,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 150,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 120,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Price",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "\$${widget.product.price}.00",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () {
                            // Add to cart
                            if (_sizeSelected != null &&
                                _colorSelected != null) {
                              final cart = CartEntity(
                                id: "",
                                userId: "1",
                                productId: widget.product.id.toString(),
                                quantity: _cartCount,
                                size: _sizeSelected!,
                                color: _colorSelected.toString(),
                              );

                            } else {
                              _showAlertDialog(
                                context,
                                "Please select size and color",
                                () {},
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            foregroundColor: Colors.white,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(children: [
                              Icon(Icons.shopping_cart),
                              SizedBox(width: 10),
                              Text(
                                "Add to Cart",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
