from rest_framework.viewsets import ModelViewSet
from categories.api.serializers import CategorySerializer
from categories.models import Category
from rest_framework.permissions import IsAdminUser, IsAuthenticated
# from rest_framework.views import APIView, Response


class CategoryApiViewset(ModelViewSet):
    # permission_classes = [IsAdminUser, IsAuthenticated]
    serializer_class = CategorySerializer
    queryset = Category.objects.all()
