Ansible follows the concept of "infrastrcuture as code". As you write everything down in simple script form, ansible will follow your instrcutions and take care of application deployment, updates, etc on your servers and workstations.

Ansible works by connecting and pushing out small programs(modules) to your nodes. These modules are written in playbook files, so that they can be saved and re-used. It's also possible to use Ansible directly with ad-hoc commands and scripting to perform tasks. To do this, you will need to run a command or call a module directly from the command line.

In this tutorial, Ansible has already been installed on the machine. We can verify the installation by running the command:

`ansible --version`{{execute HOST1}}

## Connect Ansible to your nodes

Ansible is agentless, which means you don't need any software installed on your nodes to use Ansible. It uses SSH protocol to connects and run tasks on remote nodes. However, in this tutorial, all the operations of Ansible are on the local machine, so no connection needs to be made.

You can learn how to handle the connection between Ansible and remote nodes with tutorial: [Ansible Bootstrapping](https://www.katacoda.com/oliverveits/scenarios/ansible-bootstrap).

## Set up inventory

Ansible manages hosts by inventory. When executed, Ansible will look up for target hosts listed in inventory files. Ansible will generate a default inventory at /etc/ansible/hosts. You can manage hosts in this default file or create your own inventories.

We can add our localhost to the default inventory by editing the file **/etc/ansible/hosts**:

```
cat << ... > /etc/ansible/hosts
[local]
localhost ansible_connection=local
...
```{{execute HOST1}}
```

To test your inventory, simply run the command:\
`ansible local -m ping`{{execute HOST1}}

You see that we have successfully pinged our target host.

## Write example playbook

Ansible playbooks are consisted of modules of tasks you want to run. They are implemented in YAML format. 

Below is a playbook example. Paste it to the editor and run it.

<pre class="file" data-filename="example.yml" data-target="append">---
- hosts: localhost
  remote_user: root
  tasks:
    - name: connection test
      ping:
      register: result
    - name: show result
      debug:
        var: result
</pre>

`ansible-playbook example.yml`{{execute HOST1}}

Before writing tasks, you need to declare which machines are the operating targets and as what user you are operating.

## Write MERN playbook

Let's create a template playbook for the tasks which we are going to extend in the course of this tutorial.

`touch mern.yml`{{execute HOST1}}

And paste it to the editor.

<pre class="file" data-filename="mern.yml" data-target="append">---
- hosts: localhost
  remote_user: root
  tasks:
    # - include: prerequisites.yml
    # - include: mongodb.yml
    # - include: node.yml  
    # - include: react.yml
</pre>

For simplicity, we will create separate files for each step.