import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/screens/HomeScreen.dart';
import 'package:perdi_meu_pet/widgets/PostWidget.dart';

class FeedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: mockPosts.length,
      itemBuilder: (context, index) {
        return PostWidget(
          post: mockPosts[index],
          onFavoriteToggled: () {
            // Aciona a atualização da UI quando o status de favorito de um post muda
            (context as Element).markNeedsBuild();
          },
        );
      },
    );
  }
}
