from django.db import models


class Mantenimiento(models.Model):
    nombre = models.TextField()
    fecha = models.DateField()
    diagnostico = models.TextField()
