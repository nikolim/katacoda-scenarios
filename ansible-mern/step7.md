## React.js

For demo purposes, we create a very basic React app ([Repo](https://github.com/nikolim/minimal-react)).

We start by creating a new file for the task:
`touch tasks/react.yml`{{execute HOST1}}

Afterwards we open the file
`tasks/react.yml`{{open}}

### Cloning the git repository

Analogously to the previous step, we clone the repository using the Ansible git module.

Copy the following YAML to **tasks/react.yml**:

<pre class="file" data-filename="tasks/react.yml" data-target="replace">
- name: Clone react-frontend repository
  git:
    repo: https://github.com/nikolim/minimal-react
    dest: ~/react-frontend
    clone: yes
    update: yes
</pre>

### Building docker container

Luckily also this repository contains a Dockerfile.
Let's have a quick look at the Dockerfile.
`cat ~/react-frontend/Dockerfile`{{execute HOST1}}
We are using the alpine image for our container and install React with npm using package.json.

Copy the following YAML to **tasks/react.yml**:

<pre class="file" data-filename="tasks/react.yml" data-target="append">

- name: Build react container 
  shell: "(cd ~/react-frontend && docker build -t react .)"
</pre>


### Running the container

Now it's time to create the task to run the container.
We are using the name of the image we just built. 
Additionally, we connect the container to the docker network and expose port 3000.

Copy the following YAML to **tasks/react.yml**:

<pre class="file" data-filename="tasks/react.yml" data-target="append">

- name: Run react docker container
  docker_container:
    name: React
    image: react
    ports: 
      - 3000:3000
    networks:
      - name: mynetwork
        ipv4_address: 173.18.0.4
</pre>

### Optional: connect container to Ansible inventory

Copy the following YAML to **tasks/react.yml**:

<pre class="file" data-filename="tasks/react.yml" data-target="append">

- name: Add react container to inventory
  add_host:
    name: React
    ansible_connection: docker
</pre>

