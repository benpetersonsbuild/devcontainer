#!/bin/bash -e
sleep 5
# Test to check aws executable installed. Path needed for tfenv.
export PATH="$PATH:/home/dev/.local/bin"
terraform --version
if terraform --version | grep -q 'Terraform'; then
  echo "Terraform tests passed!"
else
  echo "Terraform tests failed!"
  exit 1
fi
# Test to check aws executable installed
aws --version
if aws --version | grep -q 'aws'; then
  echo "AWS cli tests passed!"
else
  echo "AWS cli tests failed!"
  exit 1
fi
# Test to check python is installed
python3 --version
if python3 --version | grep -q 'Python'; then
  echo "Python tests passed!"
else
  echo "Python tests failed!"
  exit 1
fi
# Test to check pip3 is installed
python3 -m pip --version
if python3 -m pip --version | grep -q 'pip'; then
  echo "Pip tests passed!"
  exit 0
else
  echo "Pip tests failed!"
  exit 1
fi