from flask import Flask,request,jsonify

app=Flask(__name__)

@app.route('/score',methods=['POST'])
def score():

    data=request.json 

    return jsonify({
        "message":"score received",
        "data":data
    })

@app.route('/health')
def health():

    return {"status":"healthy"}

app.run(host='0.0.0.0',port=5000)
