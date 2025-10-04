# zstd
function taz
  if test (count $argv) -ne 1
    echo "command to compress directory using zstd"
    echo "Usage: taz <dir>"
    return 1
  end

  set dir $argv[1]
  set archive "$dir.tar.zst"

  tar -I zstd -cvf $archive $dir
end
