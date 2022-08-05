#!/bin/bash

tool_name="$1"
shebang="#!/bin/bash"
init_script_path="${tool_name}/init.sh"
install_script_path="${tool_name}/install.sh"

mkdir "${tool_name}"
touch "${init_script_path}"
touch "${install_script_path}"

echo "${shebang}" > "${init_script_path}"
echo "${shebang}" > "${install_script_path}"
