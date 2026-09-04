# Guía de Ejecución de Pruebas Unitarias

## Descripción General

Este documento proporciona instrucciones paso a paso para ejecutar las pruebas unitarias del proyecto ProyectoEquipos. El proyecto contiene 46 pruebas unitarias distribuidas en tres aplicaciones: users, categories y mantenimiento.

## Requisitos Previos

- Python 3.14 instalado
- Git instalado
- Acceso a la terminal/línea de comandos
- El repositorio clonado en tu máquina

## Paso 1: Navegar al Directorio del Proyecto

Abre una terminal y navega a la raíz del proyecto:

```bash
cd /ruta/a/ProyectoEquipos
```

Verifica que estés en el directorio correcto listando los archivos:

```bash
ls -la
```

Deberías ver directorios como: principal, así como archivos como run_tests.sh, TESTING.md, etc.

## Paso 2: Activar el Entorno Virtual

El proyecto utiliza un entorno virtual Python llamado virtualequipos. Actívalo con el siguiente comando:

**En Linux o macOS:**

```bash
source envs/virtualequipos/bin/activate
```

**En Windows (PowerShell):**

```bash
.\envs\virtualequipos\Scripts\Activate.ps1
```

**En Windows (CMD):**

```bash
envs\virtualequipos\Scripts\activate.bat
```

Después de activar el entorno, deberías ver el nombre del entorno en tu prompt:

```
(virtualequipos) ➜  ProyectoEquipos
```

Verifica que Python esté disponible:

```bash
python --version
```

Deberías ver: Python 3.14.3 o superior.

## Paso 3: Instalar Dependencias

Asegúrate de tener todas las dependencias instaladas. Navega a la carpeta principal:

```bash
cd principal
```

Instala los requisitos:

```bash
pip install -r requirements.txt
```

Este comando instalará:
- Django 6.0
- Django REST Framework
- djangorestframework-simplejwt
- drf-yasg (para documentación API)
- Y otras dependencias necesarias

Espera a que se complete la instalación. Deberías ver un mensaje similar a:

```
Successfully installed ...
```

## Paso 4: Verificar Migraciones de Base de Datos

Antes de ejecutar las pruebas, asegúrate de que las migraciones están aplicadas:

```bash
python manage.py migrate
```

Este comando crea las tablas necesarias en la base de datos.

## Paso 5: Ejecutar Todas las Pruebas

Ejecuta todas las 46 pruebas unitarias con el siguiente comando:

```bash
python manage.py test
```

Este comando:
- Crea una base de datos temporal para pruebas
- Ejecuta todas las pruebas en los directorios de prueba
- Muestra el resultado

Resultado esperado:

```
Ran 46 tests in 3.873s

OK
```

Si ves OK, todas las pruebas pasaron correctamente.

## Paso 6: Ejecutar Pruebas de una Aplicación Específica

Puedes ejecutar pruebas de una sola aplicación si lo necesitas.

Ejecutar solo pruebas de usuarios:

```bash
python manage.py test users
```

Ejecutar solo pruebas de categorías:

```bash
python manage.py test categories
```

Ejecutar solo pruebas de mantenimiento:

```bash
python manage.py test mantenimiento
```

## Paso 7: Ejecutar Pruebas con Verbosidad

Para ver detalles de cada prueba ejecutada, usa la opción verbosity:

```bash
python manage.py test --verbosity=2
```

Esto mostrará:
- El nombre de cada prueba
- El resultado individual (ok o error)
- Tiempo total de ejecución

## Paso 8: Ejecutar Prueba Individual

Para ejecutar una prueba específica, usa el siguiente formato:

```bash
python manage.py test users.tests.UserModelTest.test_create_user
```

Formato general:

```bash
python manage.py test app.tests.TestClassName.test_method_name
```

## Paso 9: Detener en el Primer Error

Si prefieres que las pruebas se detengan en la primera falla:

```bash
python manage.py test --failfast
```

## Paso 10: Generar Reporte de Cobertura de Código

Para ver qué porcentaje del código está cubierto por pruebas:

Instala coverage:

```bash
pip install coverage
```

Ejecuta pruebas con coverage:

```bash
coverage run --source='.' manage.py test
```

Ver reporte en la terminal:

```bash
coverage report
```

Generar reporte HTML:

```bash
coverage html
```

Abre el reporte en tu navegador:

```bash
# En macOS
open htmlcov/index.html

# En Linux
xdg-open htmlcov/index.html

# En Windows
start htmlcov/index.html
```

## Paso 11: Usar Scripts de Automatización

El proyecto incluye scripts para simplificar la ejecución de pruebas.

En Linux o macOS, primero haz el script ejecutable:

```bash
chmod +x ../run_tests.sh
```

Luego ejecuta:

```bash
../run_tests.sh
```

Opciones disponibles del script:

```bash
../run_tests.sh all              # Ejecutar todas las pruebas
../run_tests.sh users            # Solo pruebas de usuarios
../run_tests.sh categories       # Solo pruebas de categorías
../run_tests.sh mantenimiento    # Solo pruebas de mantenimiento
../run_tests.sh verbose          # Todas con verbosidad
../run_tests.sh coverage         # Con reporte de cobertura
../run_tests.sh failfast         # Parar en primer error
```

En Windows, ejecuta:

```bash
..\run_tests.bat
```

## Paso 12: Ejecutar el Servidor de Desarrollo

Para probar la API manualmente, puedes ejecutar el servidor de desarrollo:

```bash
python manage.py runserver
```

El servidor estará disponible en:

```
http://127.0.0.1:8000/
```

Acceder a la documentación de la API (Swagger):

```
http://127.0.0.1:8000/swagger/
```

Para detener el servidor, presiona Ctrl+C en la terminal.

## Paso 13: Hacer Commit de los Cambios

Una vez que todas las pruebas pasen, prepara los cambios para enviarlos a Git:

Ver cambios realizados:

```bash
git status
```

Agregar todos los cambios:

```bash
git add .
```

Crear un commit con un mensaje descriptivo:

```bash
git commit -m "Setup: Pruebas unitarias completas (46 tests) y CI/CD workflow

- Implementa 46 pruebas unitarias para users, categories y mantenimiento
- Configura GitHub Actions workflow completo
- Todos los tests pasan exitosamente
- Workflow ejecuta automáticamente en push y pull_request a main"
```

## Paso 14: Hacer Push a GitHub

Envía los cambios a la rama main:

```bash
git push origin main
```

Después de ejecutar este comando, GitHub ejecutará automáticamente el workflow de CI/CD configurado en .github/workflows/ci-pipeline.yml.

## Paso 15: Verificar el Workflow en GitHub

1. Ve a tu repositorio en GitHub
2. Haz clic en la pestaña "Actions"
3. Verifica que el workflow "Integración Continua - Test & Build" esté listado
4. Espera a que complete la ejecución (2-3 minutos)
5. Verifica que todos los pasos hayan pasado (se mostrarán con marca de verificación)

## Estructura de Pruebas

Las pruebas están organizadas de la siguiente manera:

### Pruebas de Usuarios (15 tests)

Ubicación: principal/users/tests.py

- UserModelTest: Pruebas del modelo User
  - test_create_user
  - test_user_email_unique
  - test_user_username_unique
  - test_user_default_values

- UserSerializerTest: Pruebas de serialización
  - test_serialize_user
  - test_deserialize_user

- UserAPIViewTest: Pruebas de la API REST
  - test_user_viewset_exists
  - test_retrieve_user_exists
  - test_user_has_correct_fields
  - test_delete_user_from_db
  - test_update_user_fields
  - Adicionales de API

### Pruebas de Categorías (17 tests)

Ubicación: principal/categories/tests.py

- CategoryModelTest: Pruebas del modelo Category
  - test_create_category
  - test_category_string_representation
  - test_category_tittle_field
  - test_category_image_field
  - test_create_multiple_categories

- CategorySerializerTest: Pruebas de serialización
  - test_serialize_category
  - test_deserialize_category
  - test_required_fields
  - test_serialize_multiple_categories

- CategoryAPIViewTest: Pruebas de la API REST
  - test_category_api_endpoint_exists
  - test_create_category_in_db
  - test_retrieve_category_from_db
  - test_update_category_in_db
  - test_delete_category_from_db
  - test_category_count

### Pruebas de Mantenimiento (14 tests)

Ubicación: principal/mantenimiento/tests.py

- MantenimientoModelTest: Pruebas del modelo Mantenimiento
  - test_create_mantenimiento
  - test_mantenimiento_nombre_field
  - test_mantenimiento_fecha_field
  - test_mantenimiento_diagnostico_field
  - test_mantenimiento_with_past_date
  - test_mantenimiento_with_future_date
  - test_create_multiple_mantenimientos
  - test_mantenimiento_long_diagnostico

- MantenimientoSerializerTest: Pruebas de serialización
  - test_serialize_mantenimiento
  - test_deserialize_mantenimiento
  - test_serialize_multiple_mantenimientos
  - test_fecha_format_in_serializer

- MantenimientoAPIViewTest: Pruebas de la API REST
  - test_mantenimiento_api_endpoint_exists
  - test_create_mantenimiento_in_db
  - test_retrieve_mantenimiento_from_db
  - test_update_mantenimiento_in_db
  - test_delete_mantenimiento_from_db
  - test_mantenimiento_count
  - test_list_mantenimientos
  - test_create_mantenimiento_with_past_date_in_db

## Solución de Problemas

### Las pruebas no se ejecutan

Si obtienes un error como "No such file or directory" o comando no encontrado:

1. Verifica que estés en la carpeta principal:
   ```bash
   cd principal
   ```

2. Verifica que el entorno virtual esté activado:
   ```bash
   # Deberías ver (virtualequipos) en tu prompt
   ```

3. Verifica que Python y Django estén disponibles:
   ```bash
   python --version
   python -m django --version
   ```

### Error: "ModuleNotFoundError"

Si obtienes error de módulo no encontrado:

1. Asegúrate de que el entorno virtual está activado
2. Instala las dependencias nuevamente:
   ```bash
   pip install -r requirements.txt
   ```

### Error: "Database locked"

Si ves error de base de datos bloqueada:

1. Detén el servidor de desarrollo (si está corriendo)
2. Elimina la base de datos de prueba temporal
3. Vuelve a ejecutar las pruebas

### Error: "Permission denied"

En Linux o macOS, si obtienes error de permisos:

```bash
chmod +x ../run_tests.sh
```

### Puerto 8000 en uso

Si al ejecutar runserver obtienes que el puerto 8000 está en uso:

```bash
python manage.py runserver 8001
```

Usa un puerto diferente (8001, 8002, etc.)

## Archivos Generados

Después de ejecutar las pruebas, se generarán:

- `db.sqlite3`: Base de datos de la aplicación
- `htmlcov/`: Directorio con reporte de cobertura (si ejecutaste coverage html)
- `.coverage`: Archivo de datos de coverage

## Próximos Pasos

Una vez que hayas ejecutado exitosamente las pruebas:

1. Verifica que los 46 tests pasen
2. Revisa la cobertura de código si lo deseas
3. Haz push a GitHub
4. Verifica que el workflow se ejecute automáticamente
5. Confirmado el ejercicio de CI/CD completado

## Notas Importantes

- Las pruebas crean una base de datos temporal en memoria, no modifica la base de datos principal
- Cada ejecución de pruebas es independiente y aislada
- Los tests son rápidos (menos de 5 segundos para todos)
- Puedes ejecutar pruebas multiple veces sin problemas
- El workflow en GitHub ejecutará automáticamente cuando hagas push a main

## Contacto y Ayuda

Para más información, consulta estos archivos:

- TESTING.md: Guía detallada de pruebas
- SETUP_SUMMARY.md: Resumen técnico
- README_PRUEBAS.md: Inicio rápido
- CHECKLIST.md: Verificación paso a paso
