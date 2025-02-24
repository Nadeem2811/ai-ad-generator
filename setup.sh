#!/bin/bash

echo "🚀 Setting up AI Ad Generator..."

# Step 1: Update and Install Dependencies
echo "🔄 Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Step 2: Install Python and Virtual Environment
echo "🐍 Installing Python 3 and pip..."
sudo apt install -y python3 python3-pip python3-venv

# Step 3: Clone GitHub Repository
echo "🔄 Cloning your GitHub repository..."
git clone https://github.com/nadeem2811/ai-ad-generator.git
cd ai-ad-generator

# Step 4: Create Virtual Environment
echo "🌎 Creating virtual environment..."
python3 -m venv venv
source venv/bin/activate

# Step 5: Install Dependencies
echo "📦 Installing required Python packages..."
pip install --upgrade pip
pip install flask openai gunicorn

# Step 6: Create `requirements.txt`
echo "📜 Generating requirements.txt..."
pip freeze > requirements.txt

# Step 7: Push `requirements.txt` to GitHub
echo "📤 Pushing requirements.txt to GitHub..."
git add requirements.txt
git commit -m "Added requirements.txt"
git push origin main

# Step 8: Deploy on Render
echo "🚀 Deployment to Render..."
echo "✅ Go to https://dashboard.render.com/ and redeploy your service."

echo "🎉 Setup complete! Your AI Ad Generator is now ready."

