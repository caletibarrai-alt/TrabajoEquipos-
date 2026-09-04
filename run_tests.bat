@echo off
REM Script para ejecutar pruebas unitarias - ProyectoEquipos (Windows)
REM Uso: run_tests.bat [opción]
REM Opciones: all, users, categories, mantenimiento, verbose, coverage

setlocal enabledelayedexpansion

REM Cambiar al directorio del proyecto
cd /d "%~dp0principal"

REM Activar entorno virtual si existe
if exist "..\envs\virtualequipos\Scripts\activate.bat" (
    call ..\envs\virtualequipos\Scripts\activate.bat
    echo Entorno virtual activado
)

REM Procesar argumentos
set OPTION=%1
if "%OPTION%"=="" set OPTION=all

if "%OPTION%"=="users" (
    echo Ejecutando pruebas de users...
    python manage.py test users
) else if "%OPTION%"=="categories" (
    echo Ejecutando pruebas de categories...
    python manage.py test categories
) else if "%OPTION%"=="mantenimiento" (
    echo Ejecutando pruebas de mantenimiento...
    python manage.py test mantenimiento
) else if "%OPTION%"=="verbose" (
    echo Ejecutando todas las pruebas con verbosidad...
    python manage.py test --verbosity=2
) else if "%OPTION%"=="coverage" (
    echo Ejecutando pruebas con cobertura...
    pip install coverage
    coverage run --source="." manage.py test
    echo.
    echo Reporte de cobertura:
    coverage report
    echo.
    echo Generando reporte HTML en htmlcov\...
    coverage html
    echo Reporte generado. Abre htmlcov\index.html para ver detalles
) else if "%OPTION%"=="failfast" (
    echo Ejecutando pruebas (parando en primer error)...
    python manage.py test --failfast
) else if "%OPTION%"=="all" (
    echo Ejecutando todas las pruebas...
    python manage.py test
) else if "%OPTION%"=="help" (
    echo Uso: %0 [opcion]
    echo.
    echo Opciones disponibles:
    echo   all              - Ejecutar todas las pruebas (por defecto)
    echo   users            - Ejecutar pruebas del app users
    echo   categories       - Ejecutar pruebas del app categories
    echo   mantenimiento    - Ejecutar pruebas del app mantenimiento
    echo   verbose          - Ejecutar todas las pruebas con verbosidad
    echo   coverage         - Ejecutar pruebas con reporte de cobertura
    echo   failfast         - Parar en la primera prueba fallida
    echo   help             - Mostrar esta ayuda
) else (
    echo Opcion desconocida: %OPTION%
    echo Escribe: %0 help
    exit /b 1
)

exit /b 0
