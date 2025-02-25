import tkinter as tk
from tkinter import messagebox
from src.Models.Products import Products
from src.Models.Warehouses import Warehouses
from src.Models.Stock import Stock
from peewee import *


def add_stock():
    try:
        product_id = int(product_id_entry.get())
        warehouse_id = int(warehouse_id_entry.get())
        quantity = int(quantity_entry.get())

        stock, created = Stock.get_or_create(product_id=product_id, warehouse_id=warehouse_id)
        stock.quantity += quantity
        stock.save()
        messagebox.showinfo("Успех", f'Добавлено {quantity} ед. товара ID {product_id} на склад ID {warehouse_id}')
    except Exception as e:
        messagebox.showerror("Ошибка", str(e))


def remove_stock():
    try:
        product_id = int(product_id_entry.get())
        warehouse_id = int(warehouse_id_entry.get())
        quantity = int(quantity_entry.get())

        stock = Stock.get(Stock.product_id == product_id, Stock.warehouse_id == warehouse_id)
        if stock.quantity >= quantity:
            stock.quantity -= quantity
            stock.save()
            messagebox.showinfo("Успех", f'Списано {quantity} ед. товара ID {product_id} со склада ID {warehouse_id}')
        else:
            messagebox.showwarning("Ошибка", 'Недостаточно товара на складе')
    except Stock.DoesNotExist:
        messagebox.showwarning("Ошибка", 'Товар отсутствует на складе')
    except Exception as e:
        messagebox.showerror("Ошибка", str(e))


def get_product_stock():
    try:
        query = (Stock
                 .select(Products.name.alias('product_name'), Stock.quantity, Warehouses.name.alias('warehouse_name'))
                 .join(Products, on=(Stock.product_id == Products.id))
                 .switch(Stock)
                 .join(Warehouses, on=(Stock.warehouse_id == Warehouses.id))
                 .dicts())
        result_text.delete(1.0, tk.END)
        for stock in query:
            result_text.insert(tk.END,
                               f'Товар: {stock["product_name"]}, Количество: {stock["quantity"]}, Склад: {stock["warehouse_name"]}\n')
    except Exception as e:
        messagebox.showerror("Ошибка", str(e))


def get_current_stock():
    try:
        query = Stock.select(Products.name.alias('product_name'), Stock.quantity).join(Products).dicts()
        result_text.delete(1.0, tk.END)
        for stock in query:
            result_text.insert(tk.END, f'Товар: {stock["product_name"]}, Остаток: {stock["quantity"]}\n')
    except Exception as e:
        messagebox.showerror("Ошибка", str(e))


def get_products_to_restock():
    try:
        query = Stock.select(Products.name.alias('product_name'), Stock.quantity).join(Products).where(
            Stock.quantity < 10).dicts()
        result_text.delete(1.0, tk.END)
        for stock in query:
            result_text.insert(tk.END,
                               f'Товар: {stock["product_name"]} нужно пополнить, Остаток: {stock["quantity"]}\n')
    except Exception as e:
        messagebox.showerror("Ошибка", str(e))


# Создание окна
root = tk.Tk()
root.title("Управление складом")
root.geometry("500x500")

# Поля ввода
tk.Label(root, text="ID товара").pack()
product_id_entry = tk.Entry(root)
product_id_entry.pack()

tk.Label(root, text="ID склада").pack()
warehouse_id_entry = tk.Entry(root)
warehouse_id_entry.pack()

tk.Label(root, text="Количество").pack()
quantity_entry = tk.Entry(root)
quantity_entry.pack()

# Кнопки
tk.Button(root, text="Добавить поступление", command=add_stock).pack()
tk.Button(root, text="Списать товар", command=remove_stock).pack()
tk.Button(root, text="Показать товары на складе", command=get_product_stock).pack()
tk.Button(root, text="Текущие остатки", command=get_current_stock).pack()
tk.Button(root, text="Товары для пополнения", command=get_products_to_restock).pack()

# Поле для вывода результатов
result_text = tk.Text(root, height=10)
result_text.pack()

# Запуск Tkinter
root.mainloop()
