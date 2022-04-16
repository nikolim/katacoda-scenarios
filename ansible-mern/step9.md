We have created all the necessary tasks.
Creating the final playbook is easy, we just have to include all the tasks in the playbook.


<pre class="file" data-filename="mern.yml" data-target="replace">---
- name: Setup backend
  hosts: localhost
  vars:
     ansible_python_interpreter: /usr/bin/python3
  tasks:
    - include: tasks/prerequisites.yml
    - include: tasks/mongodb.yml
    - include: tasks/node.yml
    - include: tasks/react.yml
</pre>

## Checking the currently running containers

Since we already started containers in previous steps, let's stop them all.
To see the currently running containers, we can use the following command

`docker ps`{{execute HOST1}}

To stop all the containers, we can use the following command

`docker stop $(docker ps -a -q)`{{execute HOST1}}

Now when we run the command again, the list should be empty

`docker ps`{{execute HOST1}}

## Optional: Running the complete playbook with all tasks

To make sure everything is working fine, we can now run the final playbook, which will execute all the tasks.
Grab a cup of coffee, this can take a while.

`ansible-playbook mern.yml`{{execute HOST1}}


