from rest_framework.viewsets import ModelViewSet
from mantenimiento.api.serializers import MantenimientoSerializer
from mantenimiento.models import Mantenimiento


class MantenimientoApiViewSet(ModelViewSet):
    serializer_class = MantenimientoSerializer
    queryset = Mantenimiento.objects.all()
