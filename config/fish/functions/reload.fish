function reload -d 'sources all fish config files'
  for file in $(fd . "$HOME"/.config/fish{,.local}/ --extension 'fish')
    . $file
  end
end

