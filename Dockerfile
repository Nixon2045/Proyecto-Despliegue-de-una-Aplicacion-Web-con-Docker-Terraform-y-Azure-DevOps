# 1. establecer una imagen base de python
FROM python:3.11-slim

# 2. establecer el directorio de trabajo 
WORKDIR /app

# 3. copiar el archivo de dependencias
COPY requerimientos.txt .

# 4. instalar dependencias 
RUN pip3 install --no-cache-dir -r requerimientos.txt

# 5. copiar el codigo de la app
COPY . .

# 6. exponer el puerto donde correra la API
EXPOSE 8080

# 7. comando para ejecutar la app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]