from fastapi import FastAPI, HTTPException
from pydantyc import BaseModel

# Crear instancias de la app

app = FastAPI()

# Datos de ejemplo ( base de datos momentanea )

tasks = [
    {"id": 1, "title": "comprar mercado", "completed": False},
    {"id": 2, "title": "sacar a mi perrito", "completed": True},
    {"id": 3, "title": "preguntar por las repisas", "completed": False},
    {"id": 4, "title": "avisar para el paquete en la casa de mis padres", "completed": False},
]

# modelo de datos de todas las task 

class Task(BaseModel):
    title : str
    completed: bool = False

# endpoint para obtener todas las tareas

@app.get("/tasks")
def get_tasks():
    return tasks

#endpoint para agregar una nueva tarea

@app.post("/tasks")
def create_task(task: Task):
    # Generar nuevi ID considerando las tareas anteriores
    new_id = max(task["id"] for task in tasks) +1 else 1
    new_task = {"id": new_id, "title": task.title, "completed": task.completed}
    tasks.append(new_task)
    return new_task