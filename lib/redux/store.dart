import 'package:qr_code/api/api_client.dart';
import 'package:qr_code/api/qr_code_api.dart';
import 'package:qr_code/redux/api_middleware.dart';
import 'package:qr_code/redux/app_state.dart';
import 'package:qr_code/redux/auto_refresh_middleware.dart';
import 'package:qr_code/redux/reducers.dart';
import 'package:redux/redux.dart';

Store<AppState> createReduxStore({ApiClient apiClient}) => Store<AppState>(
      appReducer,
      initialState: AppState.init(),
      middleware: [
        ApiMiddleware(apiClient ?? ApiClient(QrCodeApi.create())),
        AutoRefreshMiddleware(),
      ],
    );
