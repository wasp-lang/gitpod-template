import './Main.css';
import React from 'react';
import logout from '@wasp/auth/logout.js';
import useAuth from '@wasp/auth/useAuth.js';
import { useQuery } from '@wasp/queries'; // Wasp uses a thin wrapper around react-query
import getTasks from '@wasp/queries/getTasks';
import createTask from '@wasp/actions/createTask';
import updateTask from '@wasp/actions/updateTask';
import waspLogo from './waspLogo.png';

const MainPage = () => {
  const { data: tasks, isLoading, error } = useQuery(getTasks);
  const { data: user } = useAuth();

  React.useEffect(() => {
    console.log(user);
  }, [user]);

  if (isLoading) return 'Loading...';
  if (error) return 'Error: ' + error;

  return (
    <main>
      <img src={waspLogo} alt='wasp logo' />
      <h1>
        {user.username}
        {`'s tasks :)`}
      </h1>
      <NewTaskForm />
      {tasks && <TasksList tasks={tasks} />}
      <button onClick={logout}> Logout </button>
    </main>
  );
};

const Task = (props) => { 
  const handleIsDoneChange = async (event) => {
    try {
      await updateTask({
        taskId: props.task.id,
        data: { isDone: event.target.checked },
      });
    } catch (error) {
      window.alert('Error while updating task: ' + error.message);
    }
  };

  return (
    <div>
      <span>
        {props.number + 1}
        {''}
      </span>
      <input type='checkbox' id={props.task.id} checked={props.task.isDone} onChange={handleIsDoneChange} />
      <span>{props.task.description}</span>{' '}
    </div>
  );
};

const TasksList = (props) => {
  if (!props.tasks?.length) return 'No tasks';
  
  return (
    <div className='tasklist'>
      {props.tasks.map((task, idx) => <Task task={task} number={idx} key={idx} />)}
    </div>
  );
};

const NewTaskForm = () => {
  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      const description = event.target.description.value;
      event.target.reset();
      await createTask({ description });
    } catch (err) {
      window.alert('Error: ' + err.message);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <input name='description' type='text' defaultValue='' />
      <input type='submit' value='Create task' />
    </form>
  );
};

export default MainPage;
