import requests
import json
import os
import time
import jwt

# ANSI colors
GREEN = "\033[92m"
BLUE = "\033[94m"
YELLOW = "\033[93m"
RED = "\033[91m"
RESET = "\033[0m"

def print_step(step, message):
    print(f"\n{BLUE}[STEP {step}]{RESET} {message}")

def print_success(message):
    print(f"{GREEN}✓ {message}{RESET}")

def print_info(message):
    print(f"{YELLOW}➜ {message}{RESET}")

# Demo the ReaAaS-n pipeline
def demo_pipeline():
    print(f"\n{BLUE}{'=' * 50}{RESET}")
    print(f"{BLUE}ReaAaS-n: Real-time Analytics as a Service Demo{RESET}")
    print(f"{BLUE}{'=' * 50}{RESET}")
    
    # Step 1: Generate JWT token for authentication
    print_step(1, "Generating JWT token for service authentication")
    secret_key = "hackathon-demo-secret"
    payload = {
        'service': 'demo',
        'scopes': ['airbyte', 'postgres', 'mindsdb'],
        'exp': int(time.time()) + 3600
    }
    token = jwt.encode(payload, secret_key, algorithm='HS256')
    print_success(f"JWT token generated")
    print_info(f"Token: {token[:20]}...{token[-10:]}")
    
    # Step 2: Simulate Discord webhook trigger
    print_step(2, "Simulating Discord webhook trigger")
    print_info("Sending webhook notification...")
    time.sleep(1)
    print_success("Discord webhook received")
    
    # Step 3: Simulate Airbyte data ingestion
    print_step(3, "Initiating Airbyte sync operation")
    print_info("Starting sync job from source to destination...")
    time.sleep(2)
    print_success("Airbyte sync completed - 234 records processed")
    
    # Step 4: Simulate PostgreSQL data processing
    print_step(4, "Processing data in PostgreSQL")
    print_info("Running transformation queries...")
    time.sleep(1.5)
    print_success("Data processed and stored in analytics_ready table")
    
    # Step 5: Simulate MindsDB prediction
    print_step(5, "Generating predictions with MindsDB")
    print_info("Executing prediction model on processed data...")
    time.sleep(2.5)
    
    # Generate some fake prediction results
    predictions = [
        {"id": 1, "prediction": 0.87, "confidence": 0.92},
        {"id": 2, "prediction": 0.34, "confidence": 0.78},
        {"id": 3, "prediction": 0.96, "confidence": 0.95}
    ]
    print_success("Predictions generated:")
    for pred in predictions:
        print(f"  • Record {pred['id']}: {pred['prediction']:.2f} (confidence: {pred['confidence']:.2f})")
    
    # Step 6: Sending results back to Discord
    print_step(6, "Sending results back to Discord")
    print_info("Formatting results message...")
    time.sleep(1)
    print_success("Results posted to Discord channel")
    
    print(f"\n{GREEN}{'=' * 50}{RESET}")
    print(f"{GREEN}ReaAaS-n Pipeline Demo Completed Successfully!{RESET}")
    print(f"{GREEN}{'=' * 50}{RESET}")

if __name__ == "__main__":
    try:
        demo_pipeline()
    except Exception as e:
        print(f"{RED}Error: {str(e)}{RESET}")