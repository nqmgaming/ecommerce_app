import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:ecommerce_app/core/constants/colors_constant.dart';
import 'package:ecommerce_app/feature/app/domain/entities/cart_entity.dart';
import 'package:ecommerce_app/feature/app/domain/entities/product_entity.dart';
import 'package:ecommerce_app/feature/app/presentation/page/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_app/feature/app/presentation/page/cart/page/cart_page.dart';
import 'package:ecommerce_app/feature/app/presentation/widget/increase_decrease_button.dart';
import 'package:ecommerce_app/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

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
  int? _userId;

  void _showAlertDialog(BuildContext context, String message, Function onOk) {
    final delegate = S.of(context);
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(delegate.alertTitle),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: const Text(
                "OK",
                style: TextStyle(
                  color: ColorsConstant.blackColor,
                ),
              ),
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

  void getUserIdFromSecureStorage() async {
    final userId = await const FlutterSecureStorage().read(key: 'userId');
    setState(() {
      _userId = int.parse(userId!);
    });
  }

  @override
  void initState() {
    getUserIdFromSecureStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
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
              color: ColorsConstant.whiteColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back,
              color: ColorsConstant.blackColor,
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
                color: ColorsConstant.whiteColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: ColorsConstant.greyColor,
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: const Icon(
                Icons.shopping_cart,
                color: ColorsConstant.blackColor,
                size: 18,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                CartPage.route(isMain: true),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartAdded) {
            _showAlertDialog(
              context,
              delegate.productAddedToCart,
              () {},
            );
          }
          if (state is CartError) {
            _showAlertDialog(
              context,
              delegate.failedToAddProductToCart,
              () {},
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                color: ColorsConstant.whiteColor,
              ),
              Container(
                color: ColorsConstant.whiteColor,
                width: double.infinity,
                height: 450,
                child: Stack(
                  children: [
                    Swiper(
                      itemCount: widget.product.images.length,
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          imageUrl: widget.product.images[index],
                          fit: BoxFit.cover,
                          scale: 1.0,
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
                                            color: ColorsConstant.whiteColor,
                                            width: 1,
                                          )
                                        : null,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: ColorsConstant.whiteColor,
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
                                color: _isFavorite
                                    ? ColorsConstant.blackColor
                                    : ColorsConstant.whiteColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.favorite_border,
                                color: _isFavorite
                                    ? ColorsConstant.whiteColor
                                    : ColorsConstant.blackColor,
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
                    color: ColorsConstant.whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
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
                                        color: ColorsConstant.greyColor,
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
                                            color: ColorsConstant.amberColor,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                        Text(
                                          delegate.reviews,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: ColorsConstant.blackColor,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  IncreaseDecreaseButton(
                                    initialValue: _cartCount,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _cartCount = newValue;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    delegate.availableInStock,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: ColorsConstant.blackColor,
                                    ),
                                  ),
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
                          Text(
                            delegate.selectColor,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: ColorsConstant.blackColor,
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
                                          ? ColorsConstant.blackColor
                                          : ColorsConstant.greyColor,
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
                          Text(
                            delegate.selectSize,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: ColorsConstant.blackColor,
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
                                        ? ColorsConstant.blackColor
                                        : ColorsConstant.whiteColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: _sizeSelected == _sizes[index]
                                          ? ColorsConstant.blackColor
                                          : ColorsConstant.greyColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _sizes[index],
                                      style: TextStyle(
                                          color: _sizeSelected == _sizes[index]
                                              ? ColorsConstant.whiteColor
                                              : ColorsConstant.greyColor,
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
                          Text(
                            delegate.description,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: ColorsConstant.blackColor,
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
                              color: ColorsConstant.greyColor,
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
                    color: ColorsConstant.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: ColorsConstant.greyColor,
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
                            Text(
                              delegate.price,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: ColorsConstant.greyColor,
                              ),
                            ),
                            Text(
                              "\$${widget.product.price}.00",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: ColorsConstant.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: ColorsConstant.blackColor,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              // Add to cart
                              if (_sizeSelected != null &&
                                  _colorSelected != null) {
                                final cart = CartEntity(
                                  id: const Uuid().v4(),
                                  userId: _userId.toString(),
                                  productId: widget.product.id.toString(),
                                  productName: widget.product.title,
                                  productImage: widget.product.images[0],
                                  productPrice: widget.product.price,
                                  categoryId: widget.product.category.id,
                                  categoryName: widget.product.category.name,
                                  quantity: _cartCount,
                                  size: _sizeSelected!,
                                  color:
                                      _colorSelected!.value.toRadixString(16),
                                );
                                BlocProvider.of<CartBloc>(context)
                                    .add(AddCart(cart));
                              } else {
                                _showAlertDialog(
                                  context,
                                  delegate.selectSizeAndColor,
                                  () {},
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsConstant.blackColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              foregroundColor: ColorsConstant.whiteColor,
                            ),
                            child: Row(children: [
                              const Icon(Icons.shopping_cart),
                              const SizedBox(width: 10),
                              Text(
                                delegate.addToCart,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsConstant.whiteColor,
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
