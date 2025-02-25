from src.Connections.connect import *
from src.Models.BaseModel import *
from src.Models.Products import Products
from src.Models.Warehouses import Warehouses
from src.Models.Stock import Stock


def add_stock(product_id, warehouse_id, quantity):
    stock, created = Stock.get_or_create(product_id=product_id, warehouse_id=warehouse_id)
    stock.quantity += quantity
    stock.save()
    print(f'Добавлено {quantity} ед. товара ID {product_id} на склад ID {warehouse_id}')


def remove_stock(product_id, warehouse_id, quantity):
    try:
        stock = Stock.get(Stock.product_id == product_id, Stock.warehouse_id == warehouse_id)
        if stock.quantity >= quantity:
            stock.quantity -= quantity
            stock.save()
            print(f'Списано {quantity} ед. товара ID {product_id} со склада ID {warehouse_id}')
        else:
            print('Недостаточно товара на складе')
    except Stock.DoesNotExist:
        print('Товар отсутствует на складе')


def get_product_stock():
    query = (Stock
             .select(Products.name.alias('product_name'), Stock.quantity, Warehouses.name.alias('warehouse_name'))
             .join(Products, on=(Stock.product_id == Products.id))
             .switch(Stock)
             .join(Warehouses, on=(Stock.warehouse_id == Warehouses.id))
             .dicts())  # Возвращает результат как словарь

    for stock in query:
        print(f'Товар: {stock["product_name"]}, Количество: {stock["quantity"]}, Склад: {stock["warehouse_name"]}')





def get_current_stock():
    query = Stock.select(Products.name, Stock.quantity).join(Products)
    for stock in query:
        print(f'Товар: {stock.product_id.name}, Остаток: {stock.quantity}')


def get_products_to_restock(threshold=10):
    query = Stock.select(Products.name, Stock.quantity).join(Products).where(Stock.quantity < threshold)
    for stock in query:
        print(f'Товар: {stock.product_id.name} нужно пополнить, Остаток: {stock.quantity}')


def main():
    while True:
        print("\nВыберите действие:")
        print("1. Добавить поступление товара")
        print("2. Добавить списание товара")
        print("3. Показать название товара и его количество на складе")
        print("4. Показать текущие остатки на складе")
        print("5. Список товаров, которые нужно пополнить")
        print("6. Выйти")

        choice = input("Введите номер действия: ")

        if choice == "1":
            product_id = int(input("Введите ID товара: "))
            warehouse_id = int(input("Введите ID склада: "))
            quantity = int(input("Введите количество: "))
            add_stock(product_id, warehouse_id, quantity)
        elif choice == "2":
            product_id = int(input("Введите ID товара: "))
            warehouse_id = int(input("Введите ID склада: "))
            quantity = int(input("Введите количество: "))
            remove_stock(product_id, warehouse_id, quantity)
        elif choice == "3":
            get_product_stock()
        elif choice == "4":
            get_current_stock()
        elif choice == "5":
            get_products_to_restock()
        elif choice == "6":
            print("Выход...")
            break
        else:
            print("Некорректный ввод, попробуйте снова.")


if __name__ == "__main__":
    main()
