from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

from app.schemas.auth import Token, UserCreate
from app.models.auth_models import User
from app.database import get_db
from app.utils.security import (
    verify_password,
    create_access_token,
    get_password_hash
)

router = APIRouter(tags=["auth"])


# =========================
# LOGIN
# =========================
@router.post("/token", response_model=Token)
def login_for_access_token(
    form_data: OAuth2PasswordRequestForm = Depends(),
    db: Session = Depends(get_db)
):

    user = db.query(User).filter(User.username == form_data.username).first()

    if not user or not verify_password(form_data.password, user.hashed_password):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Incorrect username or password"
        )

    token = create_access_token(data={"sub": user.username})

    return {
        "access_token": token,
        "token_type": "bearer"
    }


# =========================
# REGISTER
# =========================
@router.post("/register")
def register_user(
    data: UserCreate,
    db: Session = Depends(get_db)
):

    # 🔥 Evitar duplicados
    existing_user = db.query(User).filter(
        (User.username == data.username) | (User.email == data.email)
    ).first()

    if existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="User already exists"
        )

    # 🔐 Hash password
    hashed_password = get_password_hash(data.password)

    # 👤 Crear usuario
    db_user = User(
        username=data.username,
        email=data.email,
        hashed_password=hashed_password
    )

    db.add(db_user)
    db.commit()
    db.refresh(db_user)

    return {
        "message": "User registered successfully",
        "user_id": db_user.id
    }