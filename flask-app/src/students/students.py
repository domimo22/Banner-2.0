from flask import Blueprint, request, jsonify, make_response
import json
from src import db

students = Blueprint('students', __name__)

@students.route('/test')
def get_studentTest():
    return ('<h1>Students route works</h1>')

@students.route('/info/<studentID>', methods=['GET'])
def get_studentInfo(studentID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from student_table')
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)



# @products.route('/products', methods=['GET'])
# def get_products():
#     # get a cursor object from the database
#     cursor = db.get_db().cursor()

#     # use cursor to query the database for a list of products
#     cursor.execute('select productCode, productName, productVendor from products')

#     # grab the column headers from the returned data
#     column_headers = [x[0] for x in cursor.description]

#     # create an empty dictionary object to use in 
#     # putting column headers together with data
#     json_data = []

#     # fetch all the data from the cursor
#     theData = cursor.fetchall()

#     # for each of the rows, zip the data elements together with
#     # the column headers. 
#     for row in theData:
#         json_data.append(dict(zip(column_headers, row)))

#     return jsonify(json_data)