# LOG_PROCESS
# ПРАКТИКА 1 курс СпецВО (01.04.02 и 02.04.02)

# Задача 7. Разработка системы логирования и аудита

# Выполнил студент группы М80-114СВ-24

Система логирования была выполнена на языке PL/SQL на платформе 
  
https://apex.oracle.com

В рамках проекта были созданы таблицы:

 * [Источник данных](cars_source.sql) 

 * [Таргет](cars.sql)

 * [Логирование](log_procedure.sql) 

 * [Логирование ошибок](cars_err_log.sql)

И пакет:

* [TEST_LOG_PACKAGE](test_log_package.sql)
* [TEST_LOG_PACKAGE_BODY](test_log_package_body.sql)

Для тестирования работы логирования были созданы процедуры:

* [TEST_INSERT_x_UPDATE](TEST_INSERT_x_UPDATE.sql)
* [TEST_DELETE](TEST_DELETE.sql)

Для проверки работы проекта нужно перейти на сайт 
https://apex.oracle.com/go/sign-in
 
 [Данные для входа](Security.txt)

Работу процедур можно простестировать на [сайте](https://apex.oracle.com/pls/apex/r/apex/sql-workshop/sql-scripts?session=117132774741616), для этого в таблице нужно нажать кнопку RUN в соответствующих строках

 
После этого при успешном выполнении любой процедуры данные появятся в отчете

* [Log Procedure Dashboard](https://apex.oracle.com/pls/apex/r/kirill/log-procedure/log-procedure-dashboard?session=22180205766775)

При ошибке (например если несколько раз подряд запустить [TEST_INSERT_x_UPDATE](TEST_INSERT_x_UPDATE.sql)) данные появятся в отчете

* [ERRORS](https://apex.oracle.com/pls/apex/r/kirill/log-procedure/errors?session=22180205766775)











