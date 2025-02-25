from src.Models.BaseModel import *

class Customers(BaseModel):
    id = PrimaryKeyField()
    name = CharField()
    contact_info = TextField()