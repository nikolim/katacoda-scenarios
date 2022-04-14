# JUST FOR DEMO PURPOSE

Create file mern.yml	
`touch mern.yml`{{execute HOST1}}

Copy playbook.yml to mern.yml

Run playbook
`ansible-playbook mern.yml`{{execute HOST1}}

## Test the node-api with mongodb database

`server=127.0.0.1`{{execute HOST1}}

`msg="DevOps rocks!"`{{execute HOST1}}


Sending request to nodejs express server which will insert the data into mongodb
`curl -X POST -H "Content-Type: application/json"     -d '{"name": "DevOps rocks!"}' $server:4000/data`{{execute HOST1}}

Get request to retrieve the data from mongodb 
`curl -X GET $server:4000/data`{{execute HOST1}}


## Test the react app

Press on "+" button and "Select port to view on Host1" and then select port 3000. 