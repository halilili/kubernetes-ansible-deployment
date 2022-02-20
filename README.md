# kubernetes-ansible-deployment
Using ansible playbook to deploy to kubernetes cluster

Many Problems were faced as solved as the below:


Error1:
--------
ERROR! couldn't resolve module/action 'kubernetes.core.k8s'. This often indicates a misspelling, missing collection, or incorrect module path.
he error appears to be in '/home/ubuntu/k8s/ansible/ansible-playbook-deployment.yml': line 9, column 7, but may
be elsewhere in the file depending on the exact syntax problem.

The offending line appears to be:

  pre_tasks:
    - name: Create a Namespace
      ^ here

<<<<<<<<<<<<<<<<<<<<<<<<<<<------------------Solution: ------------------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
ansible-galaxy collection install community.kubernetes



Error2:
-------
fatal: [localhost]: FAILED! => {
    "msg": "Could not find imported module support code for ansiblemodule.  Looked for either AnsibleTurboModule.py or module.py"
}

<<<<<<<<<<<<<<<<<<<<<<<<<<<------------------Solution: ------------------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
ansible-galaxy collection install cloud.common

Error 3:
--------
"error": "No module named 'kubernetes'",
msg: "Failed to import the required Python library (kubernetes) on ip-172-31-11-22's Python /usr/bin/python3. Please read module documentation and install in the appropriate location. If the required library is installed, but Ansible is using the wrong Python interpreter, please consult the documentation on ansible_python_interpreter"

<<<<<<<<<<<<<<<<<<<<<<<<<<<------------------Solution: ------------------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
pip install openshift pyyaml kubernetes
