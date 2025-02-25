from src.Models.BaseModel import *
from src.Models.Categories import Category

class Products(BaseModel):
    id = PrimaryKeyField()
    name = CharField(max_length=255)
    description = TextField(null=True)  # Убрали blank=True
    category_id = ForeignKeyField(Category, null=True)  # Убрали blank=True
    price = DecimalField(max_digits=10, decimal_places=2)
    unit = CharField(max_length=50, default='')  # Убрали blank=True и добавили default=''
    barcode = CharField(max_length=50, unique=True, null=True)  # Убрали blank=True
