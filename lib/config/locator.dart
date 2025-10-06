import 'package:be_life_style/data/network/base_api_services.dart';
import 'package:be_life_style/data/network/network_api_services.dart';
import 'package:be_life_style/repo/auth/auth_repo.dart';
import 'package:be_life_style/repo/auth/auth_repo_impl.dart';
import 'package:be_life_style/repo/chat/chat_repo.dart';
import 'package:be_life_style/repo/chat/chat_repo_impl.dart';
import 'package:be_life_style/repo/comments/comments_repo.dart';
import 'package:be_life_style/repo/comments/comments_repo_impl.dart';
import 'package:be_life_style/repo/user/user_repo.dart';
import 'package:be_life_style/repo/user/user_repo_impl.dart';
import 'package:be_life_style/repo/video/video_repo.dart';
import 'package:be_life_style/repo/video/video_repo_impl.dart';
import 'package:be_life_style/services/auth/auth_services.dart';
import 'package:be_life_style/services/cloudinary/cloudinary_services.dart';
import 'package:be_life_style/services/socket/chat_socket_service.dart';
import 'package:be_life_style/utils/image_picker_utils.dart';
import 'package:be_life_style/view_model/chat/chat_view_model.dart';
import 'package:be_life_style/view_model/main_nav_view_model.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<BaseApiService>(NetworkApiService());
  getIt.registerLazySingleton<ImagePickerUtils>(() => ImagePickerUtils());
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl( apiService: getIt<BaseApiService>()));
  getIt.registerLazySingleton<UserRepo>(() => UserRepoImpl( apiService: getIt<BaseApiService>()));
  getIt.registerLazySingleton<CloudinaryServices>(() => CloudinaryServices( apiService: getIt<BaseApiService>()));
  getIt.registerLazySingleton<AuthServices>(() => AuthServices(authRepo:  getIt<AuthRepo>(),cloudinaryService:getIt<CloudinaryServices>()));
  getIt.registerLazySingleton<VideoRepo>(() => VideoRepoImpl( apiService: getIt<BaseApiService>()));
  getIt.registerLazySingleton<CommentsRepo>(() => CommentsRepoImpl( apiService: getIt<BaseApiService>()));
  getIt.registerLazySingleton<ChatRepo>(() => ChatRepoImpl( apiService: getIt<BaseApiService>()));
  getIt.registerLazySingleton<ChatSocketService>(() => ChatSocketService());
  getIt.registerLazySingleton<ChatViewModel>(() => ChatViewModel(
    chatSocketService: getIt<ChatSocketService>(),
    chatRepo: getIt<ChatRepo>(),
  ));
  getIt.registerSingleton<MainNavViewModel>(MainNavViewModel());
}
