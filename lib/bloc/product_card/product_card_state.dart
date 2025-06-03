class ProductCardState {
  final bool isFavorite;
  final bool isLoading;

  ProductCardState({
    required this.isFavorite,
    required this.isLoading,
  });

  ProductCardState copyWith({bool? isFavorite, bool? isLoading}) {
    return ProductCardState(
      isFavorite: isFavorite ?? this.isFavorite,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
