# Set up frontend

## React.js

For demo purposes, we create a very basic React.js app.

We start by creating a new file for the task:
`touch react.yml`{{execute HOST1}}

Afterwards we open the file
`react.yml`{{open}}

### Cloning the git repository

Analogously to the previous step, we clone the repository using the Ansible git module.

<pre class="file" data-target="clipboard">
  - name: Clone react-frontend repository
    git:
      repo: https://github.com/nikolim/minimal-react
      dest: ~/react-frontend
      clone: yes
      update: yes
</pre>
Paste the snippet into the editor.

### Building docker container

Luckily also this repository contains a Dockerfile.
Let's have a quick look at the Dockerfile.
`cat ~/react-frontend/Dockerfile`{{execute HOST1}}
We are using the alpine image for our container and install React with npm using package.json.

Afterwards lets build the container with a simple command. Note that the docker module contains a build command but is deprecated.
<pre class="file" data-target="clipboard">
- name: Build react container 
  shell: "(cd ~/react-frontend && docker build -t react .)"
</pre>

Paste the snippet into the editor.

### Running the container

Now it's time to run the container.
We are using the name of the image we just built. Additionally, connect the container to the docker network and expose port 4000.
To make the routing inside the virtual network easier we assign a fixed ip address to the container.

<pre class="file" data-target="clipboard">
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

Paste the snippet into the editor.

### Optional: connect container to Ansible inventory

<pre class="file" data-target="clipboard">
- name: Add react container to inventory
  add_host:
    name: React
    ansible_connection: docker
</pre>

