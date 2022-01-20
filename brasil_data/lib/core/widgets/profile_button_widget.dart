import 'package:brasil_data/core/models/user_model.dart';
import 'package:flutter/material.dart';

class ProfileButtonWidget extends StatelessWidget {
  final UserModel user;
  const ProfileButtonWidget({Key? key, required this.user}) : super(key: key);

  // TODO: Realizar a operação de logout
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: const Offset(0, kToolbarHeight),
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(maxWidth: 250, maxHeight: kToolbarHeight),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 5),
            const Icon(Icons.person),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(user.name ?? ''), Text(user.email ?? '')],
            ),
          ],
        ),
      ),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 1,
          child: Text(
            "Sair",
          ),
        ),
      ],
    );
  }
}
