import 'package:material_ui/material_ui.dart';

class DraggingListItem extends StatelessWidget {
  const DraggingListItem({
    required this.dragKey,
    required this.photoProvider,
    super.key,
  });

  final GlobalKey dragKey;
  final ImageProvider photoProvider;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: ClipRRect(
        key: dragKey,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 150,
          width: 150,
          child: Opacity(
            opacity: 0.85,
            child: Image(image: photoProvider, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
