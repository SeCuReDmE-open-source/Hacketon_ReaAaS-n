import requests
import time

def test_ffed_server():
    try:
        response = requests.get('http://ffed_server:32168/health')
        assert response.status_code == 200
        print("ffed_server is healthy.")
    except Exception as e:
        print(f"ffed_server health check failed: {e}")

def test_mindsdb():
    try:
        response = requests.get('http://mindsdb:47334/health')
        assert response.status_code == 200
        print("MindsDB is healthy.")
    except Exception as e:
        print(f"MindsDB health check failed: {e}")

def test_database():
    try:
        response = requests.get('http://database:5432/health')
        assert response.status_code == 200
        print("Database is healthy.")
    except Exception as e:
        print(f"Database health check failed: {e}")

def test_redis():
    try:
        response = requests.get('http://redis:6379/health')
        assert response.status_code == 200
        print("Redis is healthy.")
    except Exception as e:
        print(f"Redis health check failed: {e}")

def test_neuuro_actuator():
    try:
        response = requests.get('http://neuuro_actuator:32168/health')
        assert response.status_code == 200
        print("NeuUuR-o Actuator is healthy.")
    except Exception as e:
        print(f"NeuUuR-o Actuator health check failed: {e}")

def test_airbyte_server():
    try:
        response = requests.get('http://airbyte-server:8000/health')
        assert response.status_code == 200
        print("Airbyte Server is healthy.")
    except Exception as e:
        print(f"Airbyte Server health check failed: {e}")

def main():
    # Wait for services to be up
    time.sleep(20)
    test_ffed_server()
    test_mindsdb()
    test_database()
    test_redis()
    test_neuuro_actuator()
    test_airbyte_server()
    print("Live testing completed.")

if __name__ == "__main__":
    main()
