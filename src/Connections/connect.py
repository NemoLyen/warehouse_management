from peewee import *

# Подключение к базе данных на локальном сервере
mysql_db = MySQLDatabase('warehouse_management', user='root', host='Localhost', port=3306)

if __name__ == "__main__":
    mysql_db.connect()
    print("Соединение с базой данных установлено")
