
import './App.css'
import { useEffect, useState } from 'react';

const App = () => {
  const [message, setMessage] = useState('');

  useEffect(() => {
    fetch('http://localhost:3000/api/test') // Asegúrate de que el puerto sea 3000
      .then(response => {
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        return response.json();
      })
      .then(data => setMessage(data.message))
      .catch(error => console.error('Error fetching data:', error));
  }, []);

  return (
    <div>
      <h1>Frontend and Backend Test</h1>
      <p>Backend says: {message}</p>
    </div>
  );
};

export default App;