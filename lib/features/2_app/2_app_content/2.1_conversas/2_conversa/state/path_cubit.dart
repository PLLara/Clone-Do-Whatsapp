import 'package:bloc/bloc.dart';
import '../../1_conversas/state/conversas_state.dart';

class PathCubit extends Cubit<ConversaPathData> {
  PathCubit(path) : super(path);
}
