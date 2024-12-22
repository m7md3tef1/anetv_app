abstract class FavState {}

class InitialState extends FavState {}

class AddFav extends FavState {}

class DeleteFav extends FavState {}

class GetProductsLoadingState extends FavState {}

class GetProductsSuccessState extends FavState {}

class FailedToGetProductsState extends FavState {}

class GetFavoritesSuccessState extends FavState {}

class FailedToGetFavoritesState extends FavState {}

class AddOrRemoveItemFromFavoritesSuccessState extends FavState {}

class FailedToAddOrRemoveItemFromFavoritesState extends FavState {}
