from app.database import engine, Base
from sqlalchemy import text
from app.models.auth_models import User  # importante importar modelos

def init_db():
    with engine.begin() as conn:
        conn.execute(text("CREATE SCHEMA IF NOT EXISTS auth"))

    Base.metadata.create_all(bind=engine)