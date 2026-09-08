from django.urls import path
from rest_framework.routers import DefaultRouter
from .views import UserApiViewset, UserView
from rest_framework_simplejwt.views import TokenObtainPairView # uso de simpleJWT


router_user = DefaultRouter()
router_user.register(prefix="users",
                     viewset=UserApiViewset,
                     basename="users")

urlpatterns = [
    path('auth/me', UserView.as_view()),
    path('auth/signIn/', TokenObtainPairView.as_view(), name='token_obtain_pair') # uso de simpleJWT
]
