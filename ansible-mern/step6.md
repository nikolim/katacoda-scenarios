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

## Test the node-api with mongodb database

We have set the IP of our node-express server to the following address:

`server=173.18.0.3`{{execute HOST1}}

`msg="DevOps rocks!`{{execute HOST1}}

Now we can send a POST request to our backend which will insert the data into the database:

`curl -X POST -H "Content-Type: application/json" -d '{"name": "$msg"}' $server:4000/data`{{execute HOST1}}

By sending a GET request we retrieve the data from the database:

`curl -X GET $server:4000/data`{{execute HOST1}}

Great our node-express backend is working!

