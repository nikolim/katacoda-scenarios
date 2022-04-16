To start, we first create a new playbook **mongodb.yml** for this task, and open it:

`touch mongodb.yml`{{execute HOST1}}

`mongdb.yml`{{open}}

## Create MongoDB container

Docker provides a MongoDB container, which makes it extremely convenient to set up MongoDB. To do this task with Ansible, simply copy the following YAML to **mongodb.yml**:

<pre class="file" data-filename="mongodb.yml" data-target="replace">---
- name: Setup MongoDB
  hosts: localhost
  tasks:
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

We connected the container to the docker network with a fixed ip and expose port 28017. This task will create and start the container.


## Add container to inventory

To manage MangoDB container more easily in the future, we can also add this container to inventory. 

Copy the following YAML to **mongodb.yml**:

<pre class="file" data-filename="mongodb.yml" data-target="append">

    - name: Add MongoDB container to inventory
      add_host:
        name: MongoDB
        ansible_connection: docker
      changed_when: false
</pre>

## Test the database

Now lets test whether our MongDB is actually created and running.

Copy the following YAML to **mongodb.yml**:

<pre class="file" data-filename="mongodb.yml" data-target="append">

    - name: Show MongoDB version
      delegate_to: MongoDB
      raw: mongod --version
      register: result
    
    - name: Print result
      debug: 
        var: result.stdout
</pre>

Finally, run the following command so that Ansible will execute all these tasks we've written:

`ansible-playbook mongodb.yml`{{execute HOST1}}