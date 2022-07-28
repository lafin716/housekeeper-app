
import 'package:housekeeper_front/usecase/output.dart';

abstract class UseCase {

  Future<Output> execute();
}