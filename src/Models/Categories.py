from src.Models.BaseModel import *

class Category(BaseModel):
    id = PrimaryKeyField()
    name = CharField()