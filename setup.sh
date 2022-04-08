# !/bin/sh

link_files=(".zshrc.template" ".zshrc.option" ".zshrc.alias")

for link_file in ${link_files[@]}
do
  if [ ! -f ~/$link_file ]; then
    ln -s "$(pwd)/$link_file" ~/$link_file
  fi
done

source_template_str="[ -f '~/.zshrc.template' ] && source ~/.zshrc.template"

if ! grep -q "$source_template_str" ~/.zshrc; then
  echo "# zshrc template alias\n$source_template_str\n\n$(cat ~/.zshrc)" > ~/.zshrc
fi
