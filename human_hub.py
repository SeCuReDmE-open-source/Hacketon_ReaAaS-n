
# ...existing imports...
from flask import Flask, render_template, request, jsonify
import pandas as pd
# ...existing code...

@app.route('/extract_features', methods=['POST'])
def extract_features():
    data = request.get_json()
    time_series_data = pd.DataFrame(data['time_series_data'])
    neuucro = NeuUuR_o()
    features = neuucro.extract_time_series_features(time_series_data)
    return jsonify(features.to_dict())

# ...existing code...