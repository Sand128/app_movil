FROM python:3.10-slim

WORKDIR /app

# Copiar dependencias primero (mejor cache)
COPY requirements.txt .

# Instalar dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copiar todo el proyecto
COPY . .

# Exponer puerto (opcional pero recomendado)
EXPOSE 8000

# Ejecutar FastAPI
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]