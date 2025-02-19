import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/constants/colors_constant.dart';
import 'package:ecommerce_app/core/utils/convert_date.dart';
import 'package:ecommerce_app/feature/app/presentation/page/notification/bloc/notification_bloc.dart';
import 'package:ecommerce_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String? _userId;

  void _getUserIdAddData() async {
    const storage = FlutterSecureStorage();
    _userId = await storage.read(key: 'userId');
    if (mounted) {
      context.read<NotificationBloc>().add(GetNotificationEvent(_userId!));
    }
  }

  @override
  void initState() {
    _getUserIdAddData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return Scaffold(
      backgroundColor: ColorsConstant.whiteColor,
      appBar: AppBar(
        surfaceTintColor: ColorsConstant.whiteColor,
        title: Text(
          delegate.notificationsTitle,
          style: const TextStyle(
            color: ColorsConstant.blackColor,
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
            child: const Center(
              child: Icon(
                Icons.more_vert,
                color: ColorsConstant.blackColor,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<NotificationBloc, NotificationState>(
        listener: (context, state) {
          if (state is NotificationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }

          if (state is NotificationAdded) {
            context.read<NotificationBloc>().add(GetNotificationEvent(_userId!));
          }

          if (state is NotificationRead) {
            context.read<NotificationBloc>().add(GetNotificationEvent(_userId!));
          }
        },
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NotificationLoaded) {
            final notifications = state.notifications;
            if (notifications.isEmpty) {
              return Center(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.notifications_off,
                        size: 100,
                        color: ColorsConstant.greyColor,
                      ),
                      Text(
                        delegate.noNotifications,
                        style: const TextStyle(
                          color: ColorsConstant.greyColor,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return GestureDetector(
                  onTap: () {
                    context
                        .read<NotificationBloc>()
                        .add(ReadNotificationEvent(notification.id));
                  },
                  child: Dismissible(
                    key: Key(notification.id),
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
                      context.read<NotificationBloc>().add(
                            DeleteNotificationEvent(notification.id),
                          );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: notification.isRead
                            ? Colors.white
                            : Colors.grey.withOpacity(0.1),
                        // border only bottom
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: CachedNetworkImageProvider(
                                      notification.profileImage),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: 50,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: notification.fullName,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' ${notification.content}',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        convertDate(notification.createdAt),
                                        style: const TextStyle(
                                          color: ColorsConstant.greyColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.notifications_off,
                    size: 100,
                    color: ColorsConstant.greyColor,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    delegate.noNotifications,
                    style: const TextStyle(
                      color: ColorsConstant.greyColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
