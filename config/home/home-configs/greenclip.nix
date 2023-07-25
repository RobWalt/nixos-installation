{ ... }:
let
  names = import ../../names.nix { };
in
''
  [greenclip]
  history_file = "/home/${names.userName}/.cache/greenclip.history"
  max_history_length = 50
  max_selection_size_bytes = 0
  trim_space_from_selection = true
  use_primary_selection_as_input = false
  blacklisted_applications = []
  enable_image_support = true
  # path without ending / will generate mktemp directory at the prefix location
  image_cache_directory = "/tmp/greenclip"
  static_history = [ '''¯\_(ツ)_/¯''' ]
''
