We can now append the newly created task to the playbook and run the following command so that Ansible will execute all these tasks we've written:

<pre class="file" data-filename="mern.yml" data-target="replace">---
- hosts: localhost
  remote_user: root
  vars:
     ansible_python_interpreter: /usr/bin/python3
  tasks:
    - include: tasks/node.yml
</pre>

`ansible-playbook mern.yml`{{execute HOST1}}

Since we have to pull the docker image this can take a while (~60 seconds).

## Test the Backend

Now we can send a POST request to our backend which will insert the data into the database:

`curl -X POST -H "Content-Type: application/json" -d '{"name": "DevOps rocks!"}' 173.18.0.3:4000/data`{{execute HOST1}}

By sending a GET request we retrieve the data from the database:

`curl -X GET 127.0.0.1:4000/data`{{execute HOST1}}

Great our node-express backend is working!

