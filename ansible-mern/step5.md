## Node.js and express.js

For demo purposes we created a very simple Node.js server connected to a mongo-database ([Repo](https://github.com/nikolim/node-express-mongo))
To make the backend accessible to the frontend we use Express.js

We start by creating a new file for the task:
`touch tasks/node`{{execute HOST1}}

Afterwards we open the file
`tasks/node.yml`{{open}}

### Cloning the git repository

Afterwards we want to clone the repository from Github. 
We are using the ansible git module to do this.
We have to define the repository url and path where we want to store the repository.
Additionally, we set update to true to make sure we get the latest version of the repository.

Copy the following YAML to **tasks/node.yml**:

<pre class="file" data-filename="tasks/node.yml" data-target="replace">
- name: Clone node-express-mongo repository
  git:
    repo: https://github.com/nikolim/node-express-mongo.git
    dest: ~/node-express-mongo-example
    clone: yes
    update: yes
</pre>

### Building docker container

Luckily for us the repository contains a Dockerfile, and we can use the docker module to build the container.
Let's have a quick look at the Dockerfile.
`cat ~/node-express-mongo-example/Dockerfile`{{execute HOST1}}
We are using the node image for our container and install Express.js with npm using package.json.

Copy the following YAML to **tasks/node.yml**:

Afterwards we can build the container with a simple shell command.
<pre class="file" data-filename="tasks/node.yml" data-target="append">

- name: Build node container 
  shell: "(cd ~/node-express-mongo-example && docker build -t node .)"
</pre>

### Running the container

Now it's time to run the container. We are using the name of the image we just built. Additionally, connect the container to the docker network and expose port 4000.
To make the routing inside the virtual network easier we assign a fixed ip address to the container.

Copy the following YAML to **tasks/node.yml**:

<pre class="file" data-filename="tasks/node.yml" data-target="append">
- name: Run node docker container
  docker_container:
    name: Node
    image: node
    ports: 
      - 4000:4000
    networks:
      - name: mynetwork
        ipv4_address: 173.18.0.3
</pre>

### Optional: connect container to Ansible inventory

Similar to the previous steps, we can connect the container to the Ansible inventory.

Copy the following YAML to **tasks/node.yml**:

<pre class="file" data-filename="tasks/node.yml" data-target="append">
- name: Add node-express container to inventory
  add_host:
    name: Node
    ansible_connection: docker
</pre>
