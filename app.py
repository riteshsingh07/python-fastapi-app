from fastapi import FastAPI
import uvicorn

# Create FastAPI instance
app = FastAPI()

# Root endpoint
@app.get("/")
async def root():
    return {"message": "Hey this is my FastAPI app and it is up and running!"}

# Health check endpoint
@app.get("/health")
async def health_check():
    return {"status": "healthy", "message": "FastAPI app is running smoothly"}

if __name__ == "__main__":
    # Run the app on port 5555
    uvicorn.run(app, host="0.0.0.0", port=5555)