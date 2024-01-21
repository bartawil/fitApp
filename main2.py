import pandas as pd
import numpy as np
from sklearn import linear_model
import matplotlib.pyplot as plt

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
    for i in range(4):
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

        bmr_predication =  (bmr_deficit / TOTAL_CALORIES_IN_KG)

        # predict the weight based on the deficit by the linear regression model
        prediction = reg.predict([[total_deficit]])[0]
        prediction = round(prediction, 2)
        print("Your predicted weight according to your deficit: {}".format(prediction))
        print("Weight loose of {} kg".format(round(prv_weight - prediction, 4)))

        # get the real weight
        print("Please enter you weight in scale: ")
        real_weight = float(input())

        # check the accuracy
        accuracy = (1 - (abs(prediction - real_weight) / real_weight)) * 100
        accuracy = round(accuracy, 2) 
        print("Your models accuracy is % {}".format(accuracy))

        # update the data based on the *real* new info
        new_deficit = round((prv_weight - real_weight) * TOTAL_CALORIES_IN_KG, 2) + caloric_deficit_sum
        # create a new DataFrame for the current row
        new_row = pd.DataFrame({'Weight': [real_weight], 'CaloricDeficit': [new_deficit]})

        # concatenate the new row with the existing DataFrame
        df1 = pd.concat([df1, new_row], ignore_index=True)



if __name__ == "__main__":
    gender = 0 # 0 - female, 1 - male
    height = 167
    age = 24
    active = 2 # 1 - easy, 2 - moderate, 3 - very, 4 - extraordinary
    weight_list = [74.5, 73.7, 73.3, 73, 72.2, 72.4, 72.5, 70.1]
    deficit_list = [0.0, 6160.0, 9240.0, 11550.0, 17710.0, 16170.0, 15400.0, 33880.0]
    daily_calories = 1500
    prdicted_weight(gender, height, age, active, weight_list, deficit_list, daily_calories)

