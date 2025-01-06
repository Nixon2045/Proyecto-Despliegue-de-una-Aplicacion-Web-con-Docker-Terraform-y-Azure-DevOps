from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

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
    new_id = max(task["id"] for task in tasks) + 1 if tasks else 1
    new_task = {"id": new_id, "title": task.title, "completed": task.completed}
    tasks.append(new_task)
    return new_task

#endporint para obtener una tarea especifica

@app.get("/tasks/{task_id}")
def get_task(task_id: int):
    for task in tasks:
        if task["id"] == task_id:
            return task
    raise HTTPException(status_code=404, detail="Task not found")


#endpoint para actualizar una tarea 

@app.put("/tasks/{task_id}")
def update_task(task_id: int,updated_task: Task):
    for task in tasks:
        if task["id"] == task_id:
            task["title"] = updated_task.title
            task["completed"] =updated_task.completed
            return task
    raise HTTPException(status_code=404, detail="task not found")

#endpoint para eliminar tareas 

@app.delete("/tasks/{task_id}")
def delete_task(task_id: int,):
    for task in tasks:
        if task["id"] == task_id:
            tasks.remove(task)
            return {"message": f"Task with ID {task_id} has been eliminated"}
    raise HTTPException(status_code=404, detail="task no found")

