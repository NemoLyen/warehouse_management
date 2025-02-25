from src.Models.BaseModel import *
from src.Models.Products import Products
from src.Models.SupplyOrders import SupplyOrder


class SupplyOrderDetail(BaseModel):
    id = PrimaryKeyField()
    supply_order_id = ForeignKeyField(SupplyOrder)
    product_id = ForeignKeyField(Products)
    quantity = IntegerField()
    price = DecimalField(10,2)