// ...existing code...
document.getElementById('extract_features_button').addEventListener('click', function() {
    const data = document.getElementById('time_series_data').value;
    fetch('/extract_features', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ time_series_data: JSON.parse(data) })
    })
    .then(response => response.json())
    .then(features => {
        document.getElementById('features_result').innerText = JSON.stringify(features, null, 2);
    })
    .catch(error => {
        console.error('Error:', error);
    });
});

document.getElementById('analyze_data_button').addEventListener('click', function() {
    const data = document.getElementById('time_series_data').value;
    try {
        const parsedData = JSON.parse(data);
        if (!validateClusterData(parsedData)) {
            throw new Error('Invalid cluster data format');
        }
        fetch('/analyze_data', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ time_series_data: parsedData })
        })
        .then(response => response.json())
        .then(analysis => {
            document.getElementById('analysis_result').innerText = JSON.stringify(analysis, null, 2);
        })
        .catch(error => {
            console.error('Error:', error);
        });
    } catch (error) {
        console.error('Error processing cluster data:', error);
        document.getElementById('analysis_result').innerText = 'Error: ' + error.message;
    }
});

function validateClusterData(data) {
    return Array.isArray(data) && data.every(cluster => 
        cluster.hasOwnProperty('position') && 
        cluster.hasOwnProperty('charge') &&
        Array.isArray(cluster.charge));
}

document.getElementById('neuuro_process_button').addEventListener('click', function() {
    const data = document.getElementById('time_series_data').value;
    fetch('/neuuro/process', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ 
            data: JSON.parse(data),
            emotional_context: true 
        })
    })
    .then(response => response.json())
    .then(result => {
        document.getElementById('neuuro_result').innerText = JSON.stringify(result, null, 2);
    })
    .catch(error => {
        console.error('Error:', error);
    });
});

document.getElementById('setup_button').addEventListener('click', function() {
    fetch('/setup', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ mode: 'development' })
    })
    .then(response => response.json())
    .then(result => {
        console.log('Setup Result:', result);
    })
    .catch(error => {
        console.error('Error:', error);
    });
});
// ...existing code...