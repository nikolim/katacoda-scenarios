To start, we first create a new file **mongodb.yml** for this task, and open it:

`touch tasks/mongodb.yml`{{execute HOST1}}

`tasks/mongodb.yml`{{open}}

## Create MongoDB container

Docker provides a MongoDB container, which makes it extremely convenient to set up MongoDB. To do this task with Ansible, simply copy the following YAML to **tasks/mongodb.yml**:

<pre class="file" data-filename="tasks/mongodb.yml" data-target="replace">
- name: Create Mongo Container
  docker_container:
    name: MongoDB
    image: mongo
    ports: 
      - 28017:28017
    networks: 
      - name: mynetwork
        ipv4_address: 173.18.0.2
</pre>

We connected the container to the docker network with a fixed IP and expose port 28017. This task will create and start the container.


## Add container to inventory

To manage MongoDB container more easily in the future, we can also add this container to inventory. 

Copy the following YAML to **tasks/mongodb.yml**:

<pre class="file" data-filename="tasks/mongodb.yml" data-target="append">

- name: Add MongoDB container to inventory
  add_host:
    name: MongoDB
    ansible_connection: docker
  changed_when: false
</pre>

## Test the database

Now let's test whether our MongoDB is actually created and running.

Copy the following YAML to **tasks/mongodb.yml**:

<pre class="file" data-filename="tasks/mongodb.yml" data-target="append">

- name: Show MongoDB version
  delegate_to: MongoDB
  raw: mongod --version
  register: result

- name: Print result
  debug: 
    var: result.stdout
</pre>

## Run the playbook

At the end of this step, as we've finished writing **mongodb.yml**, we put these steps to the playbook and execute them:

<pre class="file" data-filename="mern.yml" data-target="replace">---
- hosts: localhost
  remote_user: root
  tasks:
    - include: tasks/mongodb.yml
</pre>

Since we have to pull the docker image this can take a while (~60 seconds).

`ansible-playbook mern.yml`{{execute HOST1}}