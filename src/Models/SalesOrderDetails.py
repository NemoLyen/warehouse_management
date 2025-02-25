from src.Models.BaseModel import *
from src.Models.Products import Products
from src.Models.SalesOrders import SalesOrder


class SalesOrderDetail(BaseModel):
    id = PrimaryKeyField()
    sales_order_id = ForeignKeyField(SalesOrder)
    product_id = ForeignKeyField(Products)
    quantity =IntegerField()
    price = DecimalField(10,2)