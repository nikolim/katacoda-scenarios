# Create and test backend

## Create minimal playbook

We change the playbook to now include the newly create tasks.
`play.yml`{{open}}

Copy the following commands into the file (overwrite the old content):

<pre class="file" data-target="clipboard">

---
- name: Setup backend
  hosts: localhost
  tasks:
    - include: react.yml
</pre>

Afterwards we can run the playbook:
`ansible-playbook play.yml`{{execute HOST1}}

## Verify the docker container is running

First we verify that the frontend container is running (we should also still the backend):
`docker ps`{{execute HOST1}}
We should be able to see our React container

### Open the webserver

Click on the "+" button in your terminal and select "Select port to view on Host 1". 
In the new tabs select the port "3000" and click "Open".
You should be see the React frontend running.

Great seems like our frontend is also up and running!
