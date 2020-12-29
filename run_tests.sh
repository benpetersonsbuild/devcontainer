sleep 5
export PATH="$PATH:/home/dev/.local/bin"
if terraform --version | grep -q 'Terraform'; then
  echo "Tests passed!"
  exit 0
else
  echo "Tests failed!"
  exit 1
fi