from flask import Flask, request, jsonify
import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
import json
from constants import *


class WeightPredictionModel:
    def __init__(self):
        self.model = LinearRegression()
        self.weight_list = []
        self.deficit_list = []

    def train_model(self):
        # add the data to the DataFrame
        df1 = pd.DataFrame({'Weight': self.weight_list, 'CaloricDeficit': self.deficit_list})
        # y axis represents the weight
        y = np.asanyarray(df1['Weight'])
        # x axis represents the caloric deficit
        x = np.asanyarray(df1['CaloricDeficit'])
        # train the model with the current data
        self.model.fit(x.reshape(-1, 1), y)

    def predict_weight(self, gender, height, age, active, daily_calories):
         # find the predicted deficit based on the BMR calculator
        bmr_result = (self.bmr_calc(gender, self.weight_list[-1], height, age, active) - daily_calories)
        # calculate the deficit for the week
        bmr_deficit = round(bmr_result * NUM_OF_DAYS, ROUND_DECIMAL_PLACES)
        # calculate the accumulated deficit for the week
        total_deficit = bmr_deficit + self.deficit_list[-1]
        # predict the weight based on the deficit by the linear regression model
        prediction = self.model.predict([[total_deficit]])[0]
        return round(prediction, ROUND_DECIMAL_PLACES)


    # Metabolic Rate Calculator
    @staticmethod
    def bmr_calc(gender, weight, height, age, score):
        # woman
        if gender == FEMALE_GENDER:
            # BMR = 655 + (9.6 X weight in kg) + (1.8 x height in cm) - (4.7 x age in years)
            bmr = BMR_BASE_FEMALE + weight * BMR_WEIGHT_FACTOR_FEMALE + height * BMR_HEIGHT_FACTOR_FEMALE - age * BMR_AGE_FACTOR_FEMALE
        # man
        elif gender == MALE_GENDER:
            # BMR = 66 + (13.8 X weight in kg) + (5 x height in cm) - (6.8 x age in years)
            bmr = BMR_BASE_MALE + weight * BMR_WEIGHT_FACTOR_MALE + height * BMR_HEIGHT_FACTOR_MALE - age * BMR_AGE_FACTOR_MALE
        
        # Easy active
        if score == EASY_ACTIVE_SCORE:
            return EASY_ACTIVE_FACTOR * bmr
        # Moderately active
        elif score == MODERATELY_ACTIVE_SCORE:
            return MODERATELY_ACTIVE_FACTOR * bmr
        # Very active
        elif score == VERY_ACTIVE_SCORE:
            return VERY_ACTIVE_FACTOR * bmr
        # An extraordinary activist
        elif score == EXTRAORDINARY_ACTIVE_SCORE:
            return EXTRAORDINARY_ACTIVE_FACTOR * bmr



app = Flask(__name__)


"""
The following variables are global variables that are used 
to store the data that is sent from the client.
"""
weight_model = WeightPredictionModel()
gender = MALE_GENDER
height = ''
age = ''
active = MODERATELY_ACTIVE_SCORE
daily_calories = DEFAULT_CALORIES
weight_list = []
deficit_list = []
new_deficit = DEFAULT_DIFCIT

@app.route("/api", methods=["GET", "POST"])
def index():
    global weight_model
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

        # update the global variables
        gender = FEMALE_GENDER if request_data['gender'] == 'female' else MALE_GENDER
        height = int(request_data['height'])
        age = int(request_data['age'])
        active = int(request_data['active'])
        daily_calories = int(request_data['daily_calories'])
        weight_list = [float(weight) for weight in request_data['weight_list']]
        deficit_list = [float(deficit) for deficit in request_data['deficit_list']]

        # if the list of weight is not empty, calculate the new deficit
        if len(weight_list) > 0:
            new_weight = float(weight_list[-1])
            prv_weight = weight_list[-2]
            caloric_deficit_sum = deficit_list[-2]
            new_deficit = round((prv_weight - new_weight) * TOTAL_CALORIES_IN_KG, ROUND_DECIMAL_PLACES) + caloric_deficit_sum
            weight_list[-1] = new_weight
            deficit_list[-1] = new_deficit

        # update the model with the new data
        weight_model.weight_list = weight_list
        weight_model.deficit_list = deficit_list
        weight_model.train_model()

        return ""
    # method GET
    else:
        # predict the weight based on the deficit by the linear regression model
        prediction = weight_model.predict_weight(gender, height, age, active, daily_calories)
        return jsonify({'prediction': str(prediction), 'new_deficit': str(weight_model.deficit_list[-1])})


# run the server
if __name__ == "__main__":
    app.run(host='0.0.0.0', debug=True)
