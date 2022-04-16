After setting up the workspace and learning the basic operations of Ansible, we are going to write playbooks to automate the building of MERN on our machine. In reality, MERN is most likely built on remote hosts. But the process is mostly the same. The only difference is you need to change the `hosts` from localhost to your remote nodes.

We are going to use Docker to build MERN. Docker provides lightweight containers to run services in isolation from our infrastructure, making it more convenient to automate setup. We will create 3 containers for MERN: one for MongoDB, one for Express and Node.JS, and one for React.

Our machine has already installed Docker. But before starting with the real work, we need to use Ansible to make some preparations.

First create a directory **tasks**, where all the tasks will be stored:
`mkdir tasks`{{execute HOST1}}

Create a new file **prerequisites.yml** and open it:
`touch tasks/prerequisites.yml`{{execute HOST1}}

`tasks/prerequisites.yml`{{open}}

## Install Git and Docker-py

The first task we are going to write in **tasks/prerequisites.yml** is installing Git.
Copy the following YAML to **tasks/prerequisites.yml**:

<pre class="file" data-filename="tasks/prerequisites.yml" data-target="replace">
- name: Install git 
  apt: 
    name: git
</pre>

Then install docker-py, a Python library for the Docker Remote API. It does everything the docker command does, but from within Python – run containers, manage them, pull/push images, etc.

Copy the following YAML to **tasks/prerequisites.yml**:

<pre class="file" data-filename="tasks/prerequisites.yml" data-target="append">

- name: Install Docker-py
  pip:
    name: docker-py
</pre>

## Create docker network

As the MERN stack will be deployed on multiple containers, a network needs to be established among containers for data transmission. Our next task is to create a docker network for containers.

Copy the following YAML to **tasks/prerequisites.yml**:

<pre class="file" data-filename="tasks/prerequisites.yml" data-target="append">

- name: Create docker network
  docker_network:
    name: mynetwork
    ipam_config:
      - subnet: 173.18.0.0/28
</pre>

## Run the playbook

At the end of this step, as we've finished writing **prerequisites.yml**, we put these steps into the playbook and execute them.

<pre class="file" data-filename="mern.yml" data-target="replace">---
- hosts: localhost
  remote_user: root
  tasks:
    - include: tasks/prerequisites.yml
</pre>

`ansible-playbook mern.yml`{{execute HOST1}}