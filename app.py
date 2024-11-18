from flask import Flask, request, render_template
import mysql.connector

app = Flask(__name__)

# Configuração do banco de dados
db = mysql.connector.connect(
    host="endpointrds",
    user="admin",
    password="adminpassword",
    database="hamburgueriadb"
)

@app.route('/')
def index():
    return render_template('index.html')  # Certifique-se que o arquivo HTML está na pasta templates

@app.route('/submit_order', methods=['POST'])
def submit_order():
    if request.method == 'POST':
        burger = request.form['burger']
        quantity = request.form['quantity']
        name = request.form['name']
        
        # Inserir no banco de dados
        cursor = db.cursor()
        query = "INSERT INTO pedidos (nome_cliente, burger, quantidade) VALUES (%s, %s, %s)"
        values = (name, burger, quantity)
        cursor.execute(query, values)
        db.commit()
        
        cursor.close()
        return "Pedido recebido com sucesso!"

if __name__ == '__main__':
     app.run(host='0.0.0.0', port=80, debug=True)
