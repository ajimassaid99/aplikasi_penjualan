import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'keranjang_event.dart';
part 'keranjang_state.dart';

class KeranjangBloc extends Bloc<KeranjangEvent, KeranjangState> {
  List<Map<String, dynamic>> cart = [];
  KeranjangBloc() : super(KeranjangInitial()) {
    on<Increment>((event, emit) {
      emit(KeranjangLoading());
      int index = cart.indexWhere((item) => item['id'] == event.id);

      if (index == -1) {
        cart.add({'id': event.id, 'value': 1});
      } else {
        cart[index]['value'] += 1;
      }
      print(cart);

      emit(StoreKeranjang(cart));
    });
    on<decrement>((event, emit) {
       emit(KeranjangLoading());
      int index = cart.indexWhere((item) => item['id'] == event.id);
 
      if (index == -1) {
        cart.add({'id': event.id, 'value': 0});
      } else {
        if(cart[index]['value']!=0){
          
        cart[index]['value'] -= 1;
        }
      }
      print(cart);

      emit(StoreKeranjang(cart));
    });
  }
}
