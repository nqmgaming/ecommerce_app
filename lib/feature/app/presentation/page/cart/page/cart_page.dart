import 'package:ecommerce_app/core/constants/colors_constant.dart';
import 'package:ecommerce_app/feature/app/presentation/page/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_app/feature/app/presentation/widget/increase_decrease_button.dart';
import 'package:ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CartPage extends StatefulWidget {
  static route({bool isMain = false}) {
    return MaterialPageRoute(
      builder: (context) => CartPage(isMain: isMain),
    );
  }

  final bool isMain;

  const CartPage({super.key, required this.isMain});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int? _userId;
  int _cartLength = 0;
  int _totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _getUserIdFromSecureStorage();
  }

  void _getUserIdFromSecureStorage() async {
    final userId = await const FlutterSecureStorage().read(key: 'userId');
    if (mounted) {
      setState(() {
        _userId = userId != null ? int.tryParse(userId) : null;
      });
      if (_userId != null) {
        BlocProvider.of<CartBloc>(context).add(GetCart(_userId.toString()));
      }
    }
  }

  void _showAlertDialog(BuildContext context) {
    final delegate = S.of(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(delegate.orderSuccessfulTitle),
          content: Text(delegate.orderSuccessfulContent),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(delegate.okCaption),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return Scaffold(
      backgroundColor: ColorsConstant.whiteColor,
      appBar: _buildAppBar(),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartLoaded) {
            setState(() {
              _cartLength = state.cart.length;
              _totalPrice = state.cart.fold(
                0,
                (previousValue, element) =>
                    previousValue + (element.productPrice * element.quantity),
              );
            });
          } else if (state is CartError) {
            _showErrorSnackBar(context, state.message);
          } else if (state is CartUpdated || state is CartRemoved) {
            BlocProvider.of<CartBloc>(context).add(GetCart(_userId.toString()));
          } else if (state is CartRemovedAll) {
            BlocProvider.of<CartBloc>(context)
                .add(GetCart(_userId.toString()));
            _showAlertDialog(context);
          }
        },
        buildWhen: (previous, current) => current is CartLoaded,
        builder: (context, state) {
          return Stack(
            children: [
              if (state is CartLoaded && state.cart.isNotEmpty)
                _buildCartList(state)
              else if (state is CartLoaded && state.cart.isEmpty)
                _buildEmptyCartMessage()
              else
                const Center(
                  child: CircularProgressIndicator(),
                ),
              Positioned(
                bottom: 10,
                right: 10,
                left: 10,
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: ColorsConstant.whiteColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.1,
                        blurRadius: 5,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            Text(
                              delegate.total(_cartLength),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsConstant.greyColor),
                            ),
                            const Spacer(),
                            Text(
                              '\$$_totalPrice',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context)
                                .add(ClearCart(_userId.toString()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10)),
                          child: SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  delegate.checkout,
                                  style: const TextStyle(
                                    color: ColorsConstant.whiteColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_circle_right_sharp,
                                  color: ColorsConstant.whiteColor,
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
            ],
          );
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    final delegate = S.of(context);
    return AppBar(
      surfaceTintColor: ColorsConstant.whiteColor,
      centerTitle: true,
      leading: widget.isMain
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: ColorsConstant.blackColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : null,
      title: Text(
        delegate.cartLabel,
        style: const TextStyle(
          color: ColorsConstant.blackColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(right: 10),
          height: 50,
          decoration: BoxDecoration(
            color: ColorsConstant.whiteColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: ColorsConstant.greyColor.withOpacity(0.5),
                spreadRadius: 0.1,
                blurRadius: 5,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Center(
            child: Badge(
              textStyle: const TextStyle(color: ColorsConstant.redColor),
              backgroundColor: ColorsConstant.blackColor,
              label: Text(
                _cartLength.toString(),
                style: const TextStyle(fontSize: 10),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: ColorsConstant.redColor,
      ),
    );
  }

  Widget _buildCartList(CartLoaded state) {
    return ListView.builder(
      itemCount: state.cart.length + 1,
      itemBuilder: (context, index) {
        if (index == state.cart.length) {
          return const SizedBox(height: 140);
        }

        final cart = state.cart[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 10,
          shadowColor: ColorsConstant.blackColor.withOpacity(0.7),
          margin: const EdgeInsets.all(10),
          color: ColorsConstant.whiteColor,
          surfaceTintColor: ColorsConstant.whiteColor,
          child: Dismissible(
            key: Key(cart.id.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ColorsConstant.blackColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.delete,
                color: ColorsConstant.whiteColor,
                size: 30,
              ),
            ),
            onDismissed: (direction) {
              BlocProvider.of<CartBloc>(context).add(RemoveCart(cart));
            },
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(cart.productImage),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(int.parse('0xff${cart.color}')),
                      width: 5,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      right: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          cart.productName,
                          style: const TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          cart.categoryName,
                          style: const TextStyle(
                            color: ColorsConstant.greyColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Size: ${cart.size}",
                          style: const TextStyle(
                            color: ColorsConstant.greyColor,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            Text(
                              "\$${cart.productPrice * cart.quantity}.00",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            IncreaseDecreaseButton(
                              initialValue: cart.quantity,
                              onChanged: (value) {
                                if (value > 0) {
                                  BlocProvider.of<CartBloc>(context).add(
                                    UpdateCart(id: cart.id, quantity: value),
                                  );
                                } else {
                                  BlocProvider.of<CartBloc>(context).add(
                                    RemoveCart(cart),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
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

  Widget _buildEmptyCartMessage() {
    final delegate = S.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_bag_outlined,
            size: 100,
            color: ColorsConstant.greyColor,
          ),
          Text(
            delegate.noItemsInCart,
            style:
                const TextStyle(fontSize: 20, color: ColorsConstant.greyColor),
          ),
        ],
      ),
    );
  }
}
