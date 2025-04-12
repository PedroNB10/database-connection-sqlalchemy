import subprocess
from app import create_app, wait_for_db

if __name__ == "__main__":
    print("Starting Docker Compose...")
    subprocess.run(["docker", "compose", "up", "-d"], check=True)

    wait_for_db()

    app = create_app()
    app.run(debug=True, host="0.0.0.0", port=3000)
