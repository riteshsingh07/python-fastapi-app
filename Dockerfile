FROM python:3.9-slim

WORKDIR /app

COPY requirement.txt .

RUN pip install --no-cache-dir -r requirement.txt

COPY . .

EXPOSE 5555

#CMD Command
CMD ["python", "app.py"]
