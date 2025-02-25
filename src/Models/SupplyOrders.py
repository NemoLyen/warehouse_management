from src.Models.BaseModel import *
from src.Models.Suppliers import Supplier
from src.Models.Warehouses import Warehouses


class SupplyOrder(BaseModel):
    id = PrimaryKeyField()
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('completed', 'Completed'),
        ('cancelled', 'Cancelled')
    ]
    supplier_id = ForeignKeyField(Supplier)
    warehouse_id = ForeignKeyField(Warehouses)
    order_date = DateTimeField(auto_now_add=True)
    status = CharField(max_length=10, choices=STATUS_CHOICES, default='pending')