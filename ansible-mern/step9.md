We have created all the necessary tasks.
Creating the final playbook is easy, we just to include all the tasks in the playbook.


<pre class="file" data-filename="mern.yml" data-target="replace">---

---
- name: Setup backend
  hosts: localhost
  tasks:
    - include: prerequisites.yml
    - include: mongodb.yml
    - include: node.yml
    - include: react.yml
</pre>

## Checking the currently running containers

Since we already started containers in previous steps, lets stop them all.
To see the currently running containers, we can use the following command

`docker ps`{{execute HOST1}}

To stop all the containers, we can use the following command

`docker stop $(docker ps -a -q)`{{execute HOST1}}

Now when we run the command again, the list should be empty

`docker ps`{{execute HOST1}}

## Running the complete playbook

To make sure everything is working fine, we can now run the final playbook, which will execute all the tasks.

`ansible-playbook mern.yml`{{execute HOST1}}


