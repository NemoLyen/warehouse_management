from src.Models.BaseModel import *

class Warehouses(BaseModel):
    id = PrimaryKeyField()
    name = CharField(max_length=255)
    location = CharField(max_length=255, null=True, default='')  # Убрали blank=True, добавили default=''
