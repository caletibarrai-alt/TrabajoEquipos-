from rest_framework.viewsets import ModelViewSet
from users.api.serializers import UserSerializer
from users.models import User
from django.contrib.auth.hashers import make_password
from rest_framework.permissions import IsAdminUser, IsAuthenticated
from rest_framework.views import APIView, Response


class UserApiViewset(ModelViewSet):
    permission_classes = [IsAdminUser, IsAuthenticated]
    serializer_class = UserSerializer
    queryset = User.objects.all()

    # POST - guardar nuevo usuario
    def create(self, request, *args, **kwargs):
        request.data['password'] = make_password(request.data['password'])
        return super().create(request, *args, **kwargs)

    # PATCH - actualizar parcialmente un usuario
    def partial_update(self, request, *args, **kwargs):
        password = request.data['password']
        if password:
            request.data['password'] = make_password(password)
        else:
            request.data['password'] = request.user.password
        return super().update(request, *args, **kwargs)


class UserView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        serializer = UserSerializer(request.user)
        return Response(serializer.data)
