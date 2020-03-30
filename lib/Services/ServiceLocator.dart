import 'package:get_it/get_it.dart';

import 'CallsAndMessageService.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerSingleton(CallsAndMessagesService());
}