from src.Models.BaseModel import *

class Supplier(BaseModel):
    id = PrimaryKeyField()
    name = CharField(max_length=255)
    contact_info = TextField(blank=True, null=True)