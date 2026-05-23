from flask import Flask
import oracledb
oracledb.init_oracle_client(
    lib_dir=r"C:\oracle\instantclient-basic-windows.x64-23.26.1.0.0\instantclient_23_0"
)

app = Flask(__name__)

connection = oracledb.connect(
    user="system",
    password="oracle123",
    dsn="localhost/XE"
)

@app.route('/')
def home():
    return "User Service Running"

@app.route('/users')
def users():

    cursor = connection.cursor()

    cursor.execute("SELECT * FROM users")

    rows = cursor.fetchall()

    return str(rows)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)