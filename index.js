const express = require('express');

const server = express();

server.use(express.json());

const projects = [];

//Route post / projects
server.post('/projects', (request, response) => {
    const { id, title } = request.body;

    projects.push(id, title);

    return response.json(projects);
});

//Route get / projects
server.get('/projects', (_, response) => {
    return response.json(projects);
});


//Route put / projects:id
server.put('/projects/:id', (request, response) => {
    const { id } = request.params;
    const { title } = request.body;

    projects[id] = title;

    return response.json(projects);
});





server.listen(3000);