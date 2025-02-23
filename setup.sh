#!/bin/bash

# Set up AI Ad Copy Generator on macOS

echo "🚀 Setting up your AI Ad Copy Generator..."

# Step 1: Ensure Python is Installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 not found. Installing..."
    brew install python
else
    echo "✅ Python3 is already installed."
fi

# Step 2: Create a Virtual Environment
echo "🔄 Creating a virtual environment..."
python3 -m venv ad_env
source ad_env/bin/activate

# Step 3: Install Dependencies
echo "📦 Installing Flask & OpenAI..."
pip install --upgrade pip
pip install Flask openai

# Step 4: Prompt for OpenAI API Key
echo "🔑 Enter your OpenAI API Key:"
read -s OPENAI_API_KEY
echo "export OPENAI_API_KEY=$OPENAI_API_KEY" >> ~/.bash_profile
source ~/.bash_profile

# Step 5: Create Flask API Script
echo "📜 Creating AI Ad Generator API..."
cat <<EOL > app.py
from flask import Flask, request, jsonify
import openai
import os

app = Flask(__name__)

openai.api_key = os.getenv("OPENAI_API_KEY")

@app.route('/generate_ad', methods=['POST'])
def generate_ad():
    data = request.get_json()
    product = data.get('product')
    audience = data.get('audience')
    platform = data.get('platform')

    if not all([product, audience, platform]):
        return jsonify({'error': 'Missing required parameters'}), 400

    prompt = f"Write an engaging ad for {product} targeting {audience} to be used on {platform}."

    try:
        response = openai.Completion.create(
            engine="text-davinci-003",
            prompt=prompt,
            max_tokens=100
        )
        ad_copy = response.choices[0].text.strip()
        return jsonify({'ad_copy': ad_copy})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
EOL

# Step 6: Run Flask Server
echo "🚀 Starting AI Ad Generator..."
python app.py
