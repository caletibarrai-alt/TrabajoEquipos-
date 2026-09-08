from django.urls import path
from rest_framework.routers import DefaultRouter
from .views import CategoryApiViewset


router_category = DefaultRouter()
router_category.register(prefix="categories",
                     viewset=CategoryApiViewset,
                     basename="categories")


urlpatterns = [
]
