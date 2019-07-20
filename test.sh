#!/bin/sh

# Basic role syntax check
ansible-playbook tests/test.yml -i tests/inventory --syntax-check || exit 1

# Run the role/playbook with ansible-playbook
ansible-playbook tests/test.yml -i tests/inventory --connection=local --become || exit 1

# Run the role/playbook again, checking to make sure it's idempotent
ansible-playbook tests/test.yml -i tests/inventory --connection=local --become || exit 1
    | grep -q 'changed=0.*failed=0'
    && (echo 'Idempotence test: pass' && exit 0)
    || (echo 'Idempotence test: fail' && exit 1)

