from flask import Flask, render_template, request

app = Flask(__name__) 

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/career')
def career():
    return render_template('career.html')

@app.route('/contact')
def contact():
    return render_template('contact.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        if username == 'admin' and password == 'admin':
            return "Login Successful!"
        else:
            return "Invalid Credentials"
    return render_template('login.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)