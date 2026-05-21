from flask import Flask,jsonify

app=Flask(__name__)

@app.route('/leaderboard')

def leaderboard():

    return jsonify([

        {
            "rank":1,
            "team":"Barcelona"
        },

        {
            "rank":2,
            "team":"Arsenal"
        }

    ])

@app.route('/health')
def health():

    return {"status":"healthy"}

app.run(host='0.0.0.0',port=5000)
