import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk_diamonds/models/diamonds.dart';
import '../data/data.dart'; // Import the data.dart file

class DiamondBloc extends Cubit<List<Diamond>> {
  DiamondBloc() : super([]);

  // Rename the function to avoid conflict
  void loadDiamondData() async {
    // final diamonds = await loadDiamonds(); // Call the function from data.dart
    emit(diamonds);
  }

  void filterDiamonds({
    double? minCarat,
    double? maxCarat,
    String? lab,
    String? shape,
    String? color,
    String? clarity,
  }) {
    final filteredDiamonds = diamonds.where((diamond) {
      return (minCarat == null || diamond.carat >= minCarat) &&
          (maxCarat == null || diamond.carat <= maxCarat) &&
          (lab == null || diamond.lab == lab) &&
          (shape == null || diamond.shape == shape) &&
          (color == null || diamond.color == color) &&
          (clarity == null || diamond.clarity == clarity);
    }).toList();
    emit(filteredDiamonds);
  }

  void sortDiamonds(String sortBy, {bool ascending = true}) {
    final diamonds = List<Diamond>.from(state);
    diamonds.sort((a, b) {
      if (sortBy == 'finalAmount') {
        return ascending
            ? a.finalAmount.compareTo(b.finalAmount)
            : b.finalAmount.compareTo(a.finalAmount);
      } else if (sortBy == 'carat') {
        return ascending
            ? a.carat.compareTo(b.carat)
            : b.carat.compareTo(a.carat);
      }
      return 0;
    });
    emit(diamonds);
  }
}
