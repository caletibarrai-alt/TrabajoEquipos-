#!/bin/bash

# Script para ejecutar pruebas unitarias - ProyectoEquipos
# Uso: ./run_tests.sh [opción]
# Opciones: all, users, categories, mantenimiento, verbose, coverage

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Cambiar al directorio del proyecto
cd "$(dirname "$0")/principal"

# Activar entorno virtual si existe
if [ -d "../envs/virtualequipos/bin" ]; then
    source ../envs/virtualequipos/bin/activate
    echo -e "${GREEN}✓ Entorno virtual activado${NC}"
fi

# Función para mostrar ayuda
show_help() {
    echo "Uso: $0 [opción]"
    echo ""
    echo "Opciones disponibles:"
    echo "  all              - Ejecutar todas las pruebas (por defecto)"
    echo "  users            - Ejecutar pruebas del app users"
    echo "  categories       - Ejecutar pruebas del app categories"
    echo "  mantenimiento    - Ejecutar pruebas del app mantenimiento"
    echo "  verbose          - Ejecutar todas las pruebas con verbosidad"
    echo "  coverage         - Ejecutar pruebas con reporte de cobertura"
    echo "  failfast         - Parar en la primera prueba fallida"
    echo "  help             - Mostrar esta ayuda"
}

# Procesar argumentos
OPTION=${1:-all}

case $OPTION in
    users)
        echo -e "${YELLOW}Ejecutando pruebas de users...${NC}"
        python manage.py test users
        ;;
    categories)
        echo -e "${YELLOW}Ejecutando pruebas de categories...${NC}"
        python manage.py test categories
        ;;
    mantenimiento)
        echo -e "${YELLOW}Ejecutando pruebas de mantenimiento...${NC}"
        python manage.py test mantenimiento
        ;;
    verbose)
        echo -e "${YELLOW}Ejecutando todas las pruebas con verbosidad...${NC}"
        python manage.py test --verbosity=2
        ;;
    coverage)
        echo -e "${YELLOW}Ejecutando pruebas con cobertura...${NC}"
        if ! command -v coverage &> /dev/null; then
            echo -e "${RED}coverage no está instalado. Instalando...${NC}"
            pip install coverage
        fi
        coverage run --source='.' manage.py test
        echo ""
        echo -e "${GREEN}Reporte de cobertura:${NC}"
        coverage report
        echo ""
        echo -e "${YELLOW}Generando reporte HTML en htmlcov/...${NC}"
        coverage html
        echo -e "${GREEN}✓ Reporte generado. Abre htmlcov/index.html para ver detalles${NC}"
        ;;
    failfast)
        echo -e "${YELLOW}Ejecutando pruebas (parando en primer error)...${NC}"
        python manage.py test --failfast
        ;;
    all)
        echo -e "${YELLOW}Ejecutando todas las pruebas...${NC}"
        python manage.py test
        ;;
    help)
        show_help
        exit 0
        ;;
    *)
        echo -e "${RED}Opción desconocida: $OPTION${NC}"
        show_help
        exit 1
        ;;
esac

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Pruebas completadas exitosamente${NC}"
else
    echo -e "${RED}✗ Algunas pruebas fallaron${NC}"
    exit 1
fi
