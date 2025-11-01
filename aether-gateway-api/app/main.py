# app/main.py
from fastapi import FastAPI
from app.models.base import create_db_and_tables

app = FastAPI()

@app.on_event("startup")
def on_startup():
    create_db_and_tables()
