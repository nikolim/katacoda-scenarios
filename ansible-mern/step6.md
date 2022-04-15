# Set up the backend server

## Node.js and express.js

For demo purposes we created a very simple node.js server connected to a mogoDB database. To make the backend accessible to the frontend we use express.js

`mkdir tasks`{{execute HOST1}}
`cd tasks`{{execute HOST1}}

We start by creating a new file for the task:
`touch node-express.yml`{{execute HOST1}}

Afterwards we open the file
`node-express.yml`{{open}}

### Cloning the git repository

Afterwards we want to clone the repository from Github. We are using the ansible git module to do this.
We have to define the repository url and path where we want to store the repository.
Additionally, we set update to true to make sure we get the latest version of the repository.

<pre class="file" data-target="clipboard">
- name: Clone node-express-mongo repository
  git:
    repo: https://github.com/nikolim/node-express-mongo.git
    dest: ~/node-express-mongo-example
    clone: yes
    update: yes
</pre>

Paste the snippet into the editor.

### Building docker container

Luckily for us the repository contains a Dockerfile, and we can use the docker module to build the container.
Let's have a quick look at the Dockerfile.
`cat ~/node-express-mongo-example/Dockerfile`{{open}}
We are using a node image for our container and install the express.js framework with npm and package.json.

Afterwards lets build the container with a simple command. Note that the docker module contains a build command but is deprecated.
<pre class="file" data-target="clipboard">
- name: Build node container 
  shell: "(cd ~/node-express-mongo-example && docker build -t node .)"
</pre>

Paste the snippet into the editor.

### Running the container

Now it's time to run the container.
We are using the name of the image we just built. Additionally, connect the container to the docker network and expose port 4000.
To make the routing inside the virtual network easier we assign a fixed ip address to the container.

<pre class="file" data-target="clipboard">
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

Paste the snippet into the editor.

### Optional: connect container to Ansible inventory

<pre class="file" data-target="clipboard">
- name: Add node-express container to inventory
  add_host:
    name: Node
    ansible_connection: docker
</pre>
