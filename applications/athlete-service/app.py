from flask import Flask,jsonify

app=Flask(__name__)

@app.route('/athletes')

def athletes():

    return jsonify([

        {
        "name":"John Doe",
        "country":"USA"
        },

        {
        "name":"Michael",
        "country":"Qatar"
        }

    ])

@app.route('/health')
def health():

    return {"status":"healthy"}

app.run(host='0.0.0.0',port=5000)
