from rest_framework.routers import DefaultRouter
from .views import MantenimientoApiViewSet

router_mantenimiento = DefaultRouter()
router_mantenimiento.register(prefix="mantenimiento", viewset=MantenimientoApiViewSet, basename="mantenimiento")

urlpatterns = []
