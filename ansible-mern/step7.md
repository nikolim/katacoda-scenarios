# Create and test backend

## Create minimal playbook 

We start by creating a new file for the task:
`touch play.yml`{{execute HOST1}}

Afterwards we open the file
`play.yml`{{open}}

Copy the following commands into the file:
<pre class="file" data-target="clipboard">

---
- name: Setup backend
  hosts: localhost
  tasks:
    - include: node-express.yml
</pre>

Afterwards we can run the playbook: 
`ansible-playbook play.yml`{{execute HOST1}}

## Verify the docker container is running

First we verify that the backend container is running:
`docker ps`{{execute HOST1}}
We should be able to see our node container

## Test the node-api with mongodb database

We set the ip address of the backend container. 
`server=173.18.0.3`{{execute HOST1}}

Now we can send a POST request to our backend which will insert the data into the database:
`curl -X POST -H "Content-Type: application/json" -d '{"name": "DevOps rocks!"}' $server:4000/data`{{execute HOST1}}

By sending a GET request we retrieve the data from the database:
`curl -X GET $server:4000/data`{{execute HOST1}}

Great seems like our backend is working!