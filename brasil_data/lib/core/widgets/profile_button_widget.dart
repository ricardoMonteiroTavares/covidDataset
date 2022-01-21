import 'package:brasil_data/core/models/user_model.dart';
import 'package:brasil_data/core/routes/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfileButtonWidget extends StatelessWidget {
  final UserModel user;
  const ProfileButtonWidget({Key? key, required this.user}) : super(key: key);

  Column getUserColumn(UserModel user) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            user.name ?? '',
            style: const TextStyle(
              fontSize: 20,
              fontFamily: "Odibee Sans",
            ),
          ),
          Text(user.email ?? '')
        ],
      );

  @override
  Widget build(BuildContext context) {
    bool flag = kIsWeb && MediaQuery.of(context).size.width > 770;
    return PopupMenuButton(
      offset: const Offset(0, kToolbarHeight),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
            minWidth: 50, maxWidth: 250, maxHeight: kToolbarHeight),
        child: (flag)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 5),
                  const Icon(Icons.person),
                  const SizedBox(width: 10),
                  getUserColumn(user)
                ],
              )
            : const Icon(Icons.person),
      ),
      onSelected: (value) {
        if (value == 0) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.login, (route) => false);
        }
      },
      itemBuilder: (context) {
        List<PopupMenuEntry> list = [
          const PopupMenuItem(
            value: 0,
            child: Text(
              "Sair",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Odibee Sans",
              ),
            ),
          )
        ];
        if (!flag) {
          list.insertAll(0, [
            PopupMenuItem(
              value: -1,
              child: getUserColumn(user),
            ),
            const PopupMenuDivider(
              height: 10,
            ),
          ]);
        }
        return list;
      },
    );
  }
}
