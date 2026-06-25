import os
from http.server import BaseHTTPRequestHandler, HTTPServer
import json

class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        # Fetch the APP_VERSION injected by the Dockerfile ENV block
        app_version = os.getenv("APP_VERSION", "local-dev")

        # Build the payload response matches common REST API patterns
        payload = {
            "status": "success",
            "message": "Hello World from AWS Fargate!",
            "version": app_version,
            "environment": "production"
        }

        # Send headers
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.end_headers()

        # Write JSON payload response back to connection socket stream
        self.wfile.write(json.dumps(payload).encode("utf-8"))

def run():
    server_address = ('', 8080) # Listens on all interfaces on port 8080
    httpd = HTTPServer(server_address, SimpleHTTPRequestHandler)
    print("Application successfully starting up on port 8080...")
    httpd.serve_forever()

if __name__ == '__main__':
    run()