from rest_framework import serializers
from mantenimiento.models import Mantenimiento


class MantenimientoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Mantenimiento
        fields = [
            'id', 'nombre', 'fecha', 'diagnostico'
        ]