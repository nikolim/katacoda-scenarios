We can now append the newly created task to the playbook and run the following command so that Ansible will execute all these tasks we've written:

<pre class="file" data-filename="mern.yml" data-target="replace">---
- hosts: localhost
  remote_user: root
  tasks:
    - include: tasks/react.yml
</pre>

`ansible-playbook mern.yml`{{execute HOST1}}

We need some patience again for the task to complete.

### Open the webserver

Click on the **+** button at the top of your terminal and select **Select port to view on Host 1**. 
In the new tabs select the port **3000** and click **Open**.
You should see the React frontend running.

Great seems like our front end is also up and running!
