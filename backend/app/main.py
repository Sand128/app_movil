from fastapi import FastAPI, Depends
from fastapi.middleware.cors import CORSMiddleware
from app.routers import auth
from app.database import Base, engine
from app.models import auth_models
from app.init_db import init_db

# Create database tables
Base.metadata.create_all(bind=engine)

app = FastAPI()

# CORS configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allow all origins for development
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(auth.router)
app.include_router(inventory.router)


@app.on_event("startup")
def startup():
    init_db()

@app.get("/")
def read_root():
    return {"message": "Welcome to the Inventory Management API!"}






