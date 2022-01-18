
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'plant_list_event.dart';
part 'plant_list_state.dart';

class PlantListBloc extends Bloc<PlantListEvent, PlantListState> {
  PlantListBloc() : super(PlantListInitial()) {
    on<PlantListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
