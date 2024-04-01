import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'list_menu_event.dart';
part 'list_menu_state.dart';

class ListMenuBloc extends Bloc<ListMenuEvent, ListMenuState> {
  ListMenuBloc() : super(ListMenuInitial()) {
    on<ListMenuEvent>((event, emit) {});
  }
}
