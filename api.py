from flask import Flask, request, jsonify
import pandas as pd
import numpy as np
from sklearn import linear_model
import matplotlib.pyplot as plt
import json

# constants
TOTAL_CALORIES_IN_KG = 7700
NUM_OF_DAYS = 7


# Metabolic Rate Calculator
def bmr_calc(gender, weight, height, age, score):
    # woman
    if gender == 0:
        bmr = 655 + weight * 9.6 + height * 1.8 - age * 4.7
    # man
    elif gender == 1:
        bmr = 66 + weight * 13.8 + height * 5 - age * 6.8

    # Easy active
    if score == 1:
        return 1.2 * bmr
    # Moderately active
    elif score == 2:
        return 1.375 * bmr
    # Very active
    elif score == 3:
        return 1.725 * bmr
    # An extraordinary activist
    elif score == 4:
        return 1.9 * bmr


def prdicted_weight(gender, height, age, active, weight_list, deficit_list, daily_calories):
    # create an empty DataFrame
    df1 = pd.DataFrame({'Weight': [], 'CaloricDeficit': []})
    # add the data to the DataFrame
    df1 = df1.assign(Weight=weight_list, CaloricDeficit=deficit_list)

    # linear regression algorithm
    # create an instance of the model
    reg = linear_model.LinearRegression()
    # y axis represents the weight
    y = np.asanyarray(df1['Weight'])
    # x axis represents the caloric deficit
    x = np.asanyarray(df1['CaloricDeficit'])
    # train the model with the current data
    reg.fit(x.reshape(-1, 1), y)

    # most recent user data
    last_data = df1.tail(1).iloc[0]
    prv_weight = last_data['Weight']
    caloric_deficit_sum = last_data['CaloricDeficit']

    # find the predicted deficit based on the BMR calculator
    bmr_result = (bmr_calc(gender=gender, weight=prv_weight, height=height, age=age,
                        score=active) - daily_calories)
    # calculate the deficit for the week
    bmr_deficit = round(bmr_result * NUM_OF_DAYS, 2)
    # calculate the accumulated deficit for the week
    total_deficit = bmr_deficit + caloric_deficit_sum

    # predict the weight based on the deficit by the linear regression model
    prediction = reg.predict([[total_deficit]])[0]
    prediction = round(prediction, 2)
    return prediction

app = Flask(__name__)

gender = 1
height = ''
age = ''
active = 2
daily_calories = 0
weight_list = []
deficit_list = []
new_deficit = 0

@app.route("/api", methods=["GET", "POST"])
def index():
    global gender
    global height
    global age
    global active
    global daily_calories
    global weight_list
    global deficit_list
    global new_deficit
    if request.method == "POST":
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        gender = 0 if request_data['gender'] == 'female' else 1
        height = int(request_data['height'])
        age = int(request_data['age'])
        active = int(request_data['active'])
        daily_calories = int(request_data['daily_calories'])
        weight_list = request_data['weight_list']
        weight_list = [float(weight) for weight in weight_list]
        deficit_list = request_data['deficit_list']
        deficit_list = [float(deficit) for deficit in deficit_list]
        if len(weight_list) > 1:
            new_weight = float(weight_list[-1])
            prv_weight = weight_list[-2]
            caloric_deficit_sum = deficit_list[-2]
            new_deficit = round((prv_weight - new_weight) * TOTAL_CALORIES_IN_KG, 2) + caloric_deficit_sum
            weight_list[-1] = new_weight
            deficit_list[-1] = new_deficit
        return ""
    else:
        prediction = prdicted_weight(gender, height, age, active, weight_list, deficit_list, daily_calories)
        # return jsonify({'gender': str(gender),
        #                 'height': str(height),
        #                 'age': str(age),})
        # return jsonify(prediction)
        return jsonify({'prediction': str(prediction),
                        'new_deficit': str(new_deficit)})

if __name__ == "__main__":
    app.run(host='0.0.0.0', debug=True)
