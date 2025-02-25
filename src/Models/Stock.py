from src.Models.BaseModel import *
from src.Models.Products import Products
from src.Models.Warehouses import Warehouses


class Stock(BaseModel):
    id = PrimaryKeyField()
    product_id = ForeignKeyField(Products)
    warehouse_id = ForeignKeyField(Warehouses)
    quantity = IntegerField(default=0)