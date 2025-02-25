from enum import EnumType, EnumMeta

from src.Models.BaseModel import *
from src.Models.Customers import Customers


class SalesOrder(BaseModel):
    id = PrimaryKeyField()
    customer_id = ForeignKeyField(Customers)
    order_date = DateTimeField()
    status = EnumType('pending', 'shipped', 'delivered', 'cancelled')