from flask import Blueprint, request, jsonify, make_response
import json
from src import db

advisors = Blueprint('advisors', __name__)