import os

def main():
    # Fetching version from environment variable if available
    version = os.getenv("APP_VERSION", "1.0.0")
    print(f"Hello from CI/CD! Running version: {version}")

if __name__ == "__main__":
    main()