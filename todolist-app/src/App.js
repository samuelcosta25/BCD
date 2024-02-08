import React, { useState, useEffect } from 'react';
import axios from 'axios';

function TodoList() {
  const [tasks, setTasks] = useState([]);
  const [newTask, setNewTask] = useState('');

  useEffect(() => {
    // Carrega as tarefas do backend quando o componente é montado.
    axios.get('http://localhost:5000/tasks')
      .then(response => setTasks(response.data))
      .catch(error => console.error(error));
  }, []);

  const addTask = () => {
    if (newTask.trim() !== '') {
      axios.post('http://localhost:5000/tasks', { task: newTask })
        .then(response => {
          setTasks([...tasks, newTask]);
          setNewTask('');
        })
        .catch(error => console.error(error));
    }
  };

  const deleteTask = (index) => {
    axios.delete(`http://localhost:5000/tasks/${index}`)
      .then(response => {
        const updatedTasks = tasks.filter((_, i) => i !== index);
        setTasks(updatedTasks);
      })
      .catch(error => console.error(error));
  };

  return (
    <div>
      <h1>Lista de Tarefas</h1>
      <input
        type="text"
        placeholder="Digite uma nova tarefa"
        value={newTask}
        onChange={(e) => setNewTask(e.target.value)}
      />
      <button onClick={addTask}>Adicionar Tarefa</button>
      <ul>
        {tasks.map((task, index) => (
          <li key={index}>
            {task}
            <button onClick={() => deleteTask(index)}>Excluir</button>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default TodoList;
