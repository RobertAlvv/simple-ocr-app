// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../app/app_module.dart' as _i431;
import '../../features/analytics/data/datasource/analytics_datasource.dart'
    as _i321;
import '../../features/analytics/data/repository_impl/analytics_repository_impl.dart'
    as _i992;
import '../../features/analytics/domain/repository/analytics_repository.dart'
    as _i876;
import '../../features/analytics/domain/use_case/get_analytics_data_use_case.dart'
    as _i878;
import '../../features/analytics/presentation/bloc/analytics_bloc.dart' as _i70;
import '../../features/auth/data/datasource/auth_datasource.dart' as _i43;
import '../../features/auth/data/repository_impl/auth_repository_impl.dart'
    as _i954;
import '../../features/auth/domain/repository/auth_repository.dart' as _i961;
import '../../features/auth/domain/use_case/get_current_user_use_case.dart'
    as _i563;
import '../../features/auth/domain/use_case/login_use_case.dart' as _i973;
import '../../features/auth/domain/use_case/logout_use_case.dart' as _i633;
import '../../features/auth/presentation/bloc/login_bloc.dart' as _i990;
import '../../features/expense/data/datasource/expense_datasource.dart'
    as _i365;
import '../../features/expense/data/repository_impl/expense_repository_impl.dart'
    as _i1013;
import '../../features/expense/domain/repository/expense_repository.dart'
    as _i495;
import '../../features/expense/domain/use_case/get_expenses_use_case.dart'
    as _i395;
import '../../features/expense/presentation/bloc/expense_bloc.dart' as _i484;
import '../../features/home/data/datasource/home_datasource.dart' as _i850;
import '../../features/home/data/repository_impl/home_repository_impl.dart'
    as _i60;
import '../../features/home/domain/repository/home_repository.dart' as _i541;
import '../../features/home/domain/use_case/get_dashboard_data_use_case.dart'
    as _i73;
import '../../features/home/presentation/bloc/home_bloc.dart' as _i202;
import '../../features/invoice/data/datasource/invoice_datasource.dart'
    as _i939;
import '../../features/invoice/data/repository_impl/invoice_repository_impl.dart'
    as _i996;
import '../../features/invoice/domain/repository/invoice_repository.dart'
    as _i12;
import '../../features/invoice/domain/use_case/get_invoice_use_case.dart'
    as _i945;
import '../../features/invoice/domain/use_case/process_image_use_case.dart'
    as _i921;
import '../../features/invoice/domain/use_case/save_invoice_use_case.dart'
    as _i467;
import '../../features/invoice/presentation/bloc/invoice_bloc.dart' as _i269;
import '../../features/settings/data/datasource/settings_datasource.dart'
    as _i294;
import '../../features/settings/data/repository_impl/settings_repository_impl.dart'
    as _i599;
import '../../features/settings/domain/repository/settings_repository.dart'
    as _i187;
import '../../features/settings/domain/use_case/get_settings_use_case.dart'
    as _i243;
import '../../features/settings/domain/use_case/update_settings_use_case.dart'
    as _i188;
import '../../features/settings/presentation/bloc/settings_bloc.dart' as _i585;
import '../router/app_router.dart' as _i81;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.lazySingleton<_i81.AppRouter>(() => appModule.router);
    gh.lazySingleton<_i43.AuthDatasource>(() => _i43.AuthDatasourceImpl());
    gh.lazySingleton<_i365.ExpenseDatasource>(
      () => _i365.ExpenseDatasourceImpl(),
    );
    gh.lazySingleton<_i939.InvoiceDatasource>(
      () => _i939.InvoiceDatasourceImpl(),
    );
    gh.lazySingleton<_i321.AnalyticsDatasource>(
      () => _i321.AnalyticsDatasourceImpl(),
    );
    gh.lazySingleton<_i850.HomeDatasource>(() => _i850.HomeDatasourceImpl());
    gh.lazySingleton<_i961.AuthRepository>(
      () => _i954.AuthRepositoryImpl(gh<_i43.AuthDatasource>()),
    );
    gh.lazySingleton<_i294.SettingsDatasource>(
      () => _i294.SettingsDatasourceImpl(),
    );
    gh.lazySingleton<_i187.SettingsRepository>(
      () => _i599.SettingsRepositoryImpl(gh<_i294.SettingsDatasource>()),
    );
    gh.lazySingleton<_i876.AnalyticsRepository>(
      () => _i992.AnalyticsRepositoryImpl(gh<_i321.AnalyticsDatasource>()),
    );
    gh.lazySingleton<_i541.HomeRepository>(
      () => _i60.HomeRepositoryImpl(gh<_i850.HomeDatasource>()),
    );
    gh.lazySingleton<_i878.GetAnalyticsDataUseCase>(
      () => _i878.GetAnalyticsDataUseCase(gh<_i876.AnalyticsRepository>()),
    );
    gh.factory<_i73.GetDashboardDataUseCase>(
      () => _i73.GetDashboardDataUseCase(gh<_i541.HomeRepository>()),
    );
    gh.factory<_i70.AnalyticsBloc>(
      () => _i70.AnalyticsBloc(gh<_i878.GetAnalyticsDataUseCase>()),
    );
    gh.lazySingleton<_i243.GetSettingsUseCase>(
      () => _i243.GetSettingsUseCase(gh<_i187.SettingsRepository>()),
    );
    gh.lazySingleton<_i188.UpdateSettingsUseCase>(
      () => _i188.UpdateSettingsUseCase(gh<_i187.SettingsRepository>()),
    );
    gh.factory<_i633.LogoutUseCase>(
      () => _i633.LogoutUseCase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i563.GetCurrentUserUseCase>(
      () => _i563.GetCurrentUserUseCase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i973.LoginUseCase>(
      () => _i973.LoginUseCase(gh<_i961.AuthRepository>()),
    );
    gh.lazySingleton<_i495.ExpenseRepository>(
      () => _i1013.ExpenseRepositoryImpl(gh<_i365.ExpenseDatasource>()),
    );
    gh.factory<_i202.HomeBloc>(
      () => _i202.HomeBloc(gh<_i73.GetDashboardDataUseCase>()),
    );
    gh.lazySingleton<_i12.InvoiceRepository>(
      () => _i996.InvoiceRepositoryImpl(gh<_i939.InvoiceDatasource>()),
    );
    gh.factory<_i395.GetExpensesUseCase>(
      () => _i395.GetExpensesUseCase(gh<_i495.ExpenseRepository>()),
    );
    gh.factory<_i990.LoginBloc>(
      () => _i990.LoginBloc(gh<_i973.LoginUseCase>()),
    );
    gh.factory<_i945.GetInvoiceUseCase>(
      () => _i945.GetInvoiceUseCase(gh<_i12.InvoiceRepository>()),
    );
    gh.factory<_i467.SaveInvoiceUseCase>(
      () => _i467.SaveInvoiceUseCase(gh<_i12.InvoiceRepository>()),
    );
    gh.factory<_i921.ProcessImageUseCase>(
      () => _i921.ProcessImageUseCase(gh<_i12.InvoiceRepository>()),
    );
    gh.factory<_i585.SettingsBloc>(
      () => _i585.SettingsBloc(
        gh<_i243.GetSettingsUseCase>(),
        gh<_i188.UpdateSettingsUseCase>(),
      ),
    );
    gh.factory<_i484.ExpenseBloc>(
      () => _i484.ExpenseBloc(gh<_i395.GetExpensesUseCase>()),
    );
    gh.factory<_i269.InvoiceBloc>(
      () => _i269.InvoiceBloc(
        gh<_i921.ProcessImageUseCase>(),
        gh<_i467.SaveInvoiceUseCase>(),
        gh<_i945.GetInvoiceUseCase>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i431.AppModule {}
