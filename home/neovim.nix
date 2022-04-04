{ pkgs, lib, ... }:
let
  pluginGit = ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };
  plugin = pluginGit "HEAD";
in
{
  programs.neovim =
    {
      enable = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraConfig = ''
          "general settings
          set nocompatible
          set showmatch
          set hlsearch
          set incsearch
          set background=dark
          set clipboard=unnamedplus
          set completeopt=menu,menuone,noselect
          set cursorline
          set hidden
          set inccommand=split
          set number relativenumber
          set splitbelow splitright
          set termguicolors
          set title
          set wildmenu
          set cc=120
          set expandtab
          set shiftwidth=4
          set tabstop=4
          set softtabstop=4
          set autoindent
          filetype plugin indent on
          
          "Key bindings
          nnoremap <silent> <C-f> :NvimTreeFindFileToggle<CR>
          nnoremap <silent> <C-K> <cmd>lua vim.lsp.buf.signature_help()<CR>
          nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
          nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
          nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
          nnoremap <silent> gD <cmd>Telescope diagnostics theme=ivy initial_mode=normal<CR>
          nnoremap <silent> gd <cmd>Telescope lsp_definitions theme=ivy initial_mode=normal<CR>
          nnoremap <silent> gi <cmd>Telescope lsp_implementations theme=ivy initial_mode=normal<CR>
          nnoremap <silent> gr <cmd>Telescope lsp_references theme=ivy initial_mode=normal<CR>
          nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action()<CR>
          nnoremap <silent> <C-m> <cmd>lua vim.lsp.buf.rename()<CR>
          nnoremap <silent> <C-q> <cmd>Telescope current_buffer_fuzzy_find theme=cursor<CR>
          nnoremap <silent> <C-g> <cmd>Telescope live_grep<CR>
          vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
          nnoremap <silent> <A-,> :tabprevious<CR>
          nnoremap <silent> <A-.> :tabnext<CR>
          nnoremap <silent> <A-h> :tabmove -1<CR>
          nnoremap <silent> <A-l> :tabmove +1<CR>
	'';

      plugins = with pkgs.vimPlugins; [
        auto-pairs
        cmp-nvim-lsp
        cmp-buffer
        cmp-vsnip
        {
          plugin = (plugin "stevearc/dressing.nvim");
          config = ''
            lua << EOF
              require('dressing').setup({
                input = {
                  -- Set to false to disable the vim.ui.input implementation
                  enabled = true,

                  -- Default prompt string
                  default_prompt = "➤ ",

                  -- When true, <Esc> will close the modal
                  insert_only = true,

                  -- These are passed to nvim_open_win
                  anchor = "SW",
                  border = "rounded",
                  -- 'editor' and 'win' will default to being centered
                  relative = "cursor",

                  -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                  prefer_width = 40,
                  width = nil,
                  -- min_width and max_width can be a list of mixed types.
                  -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
                  max_width = { 140, 0.9 },
                  min_width = { 20, 0.2 },

                  -- Window transparency (0-100)
                  winblend = 10,
                  -- Change default highlight groups (see :help winhl)
                  winhighlight = "",

                  override = function(conf)
                    -- This is the config that will be passed to nvim_open_win.
                    -- Change values here to customize the layout
                    return conf
                  end,

                  -- see :help dressing_get_config
                  get_config = nil,
                },
                select = {
                  -- Set to false to disable the vim.ui.select implementation
                  enabled = true,

                  -- Priority list of preferred vim.select implementations
                  backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

                  -- Options for telescope selector
                  -- These are passed into the telescope picker directly. Can be used like:
                  -- telescope = require('telescope.themes').get_ivy({...})
                  telescope = nil,

                  -- Options for fzf selector
                  fzf = {
                    window = {
                      width = 0.5,
                      height = 0.4,
                    },
                  },

                  -- Options for fzf_lua selector
                  fzf_lua = {
                    winopts = {
                      width = 0.5,
                      height = 0.4,
                    },
                  },

                  -- Options for nui Menu
                  nui = {
                    position = "50%",
                    size = nil,
                    relative = "editor",
                    border = {
                      style = "rounded",
                    },
                    max_width = 80,
                    max_height = 40,
                  },

                  -- Options for built-in selector
                  builtin = {
                    -- These are passed to nvim_open_win
                    anchor = "NW",
                    border = "rounded",
                    -- 'editor' and 'win' will default to being centered
                    relative = "editor",

                    -- Window transparency (0-100)
                    winblend = 0,
                    -- Change default highlight groups (see :help winhl)
                    winhighlight = "",

                    -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                    -- the min_ and max_ options can be a list of mixed types.
                    -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
                    width = nil,
                    max_width = { 140, 0.8 },
                    min_width = { 40, 0.2 },
                    height = nil,
                    max_height = 0.9,
                    min_height = { 10, 0.2 },

                    override = function(conf)
                      -- This is the config that will be passed to nvim_open_win.
                      -- Change values here to customize the layout
                      return conf
                    end,
                  },

                  -- Used to override format_item. See :help dressing-format
                  format_item_override = {},

                  -- see :help dressing_get_config
                  get_config = nil,
                },
            })
            EOF
          '';
        }
        {
          plugin = lualine-nvim;
          config = ''
            lua << EOF
              require('lualine').setup()
            EOF
          '';
        }
        {
          plugin = luatab-nvim;
          config = ''
            lua << EOF
              require('luatab').setup({})
            EOF
          '';
        }
        {
          plugin = nvim-cmp;
          config =
            ''
              lua << EOF
                local cmp = require('cmp');
                cmp.setup({
                  snippet = {
                    expand = function(args)
                      vim.fn["vsnip#anonymous"](args.body)
                    end,
                  },
                  mapping = {
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm({select = true}),
                    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'}),
                    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'}),
                  },
                  sources = {
                    {name = 'nvim_lsp'},
                    {name = 'vsnip'},
                    {name = 'buffer'},
                  }
                })
              EOF
            '';
        }
        nvim-dap
        {
          plugin = nvim-lspconfig;
          config = ''
            autocmd BufWritePre *.nix lua vim.lsp.buf.formatting_sync(nil, 100)
            autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 100)
            lua << EOF
              require('lspconfig').rnix.setup{};
            EOF
          '';
        }
        {
          plugin = nvim-treesitter;
          config =
            ''
              lua << EOF
                require('nvim-treesitter.configs').setup {
                  ensure_installed = {"nix", "rust"},
                  highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                  },
                }
              EOF
            '';
        }
        {
          plugin = nvim-tree-lua;
          config = ''
            lua << EOF
              require('nvim-tree').setup {
                auto_close = true,
                diagnostics = {
                  enable = true,
                },
                view = {
                  mappings = {
                    list = {
                      { key = "i", action = "split" },
                      { key = "s", action = "vsplit" },
                    },
                  },
                },
                actions = {
                  open_file = {
                    quit_on_open = true,
                  },
                },
              }
            EOF
          '';
        }
        nvim-web-devicons
        plenary-nvim
        popup-nvim
        {
          plugin = rust-tools-nvim;
          config = ''
            lua << EOF
              require('rust-tools').setup({

               tools = {

                autoSetHints = true,
                hover_with_actions = true,
                executor = require("rust-tools/executors").termopen,
                on_initialized = nil,
                inlay_hints = {
                	only_current_line = false,
                	only_current_line_autocmd = "CursorHold",
                	show_parameter_hints = true,
                	show_variable_name = false,
                	parameter_hints_prefix = "<- ",
                	other_hints_prefix = "=> ",
                	max_len_align = false,
                	max_len_align_padding = 1,
                	right_align = false,
                	right_align_padding = 7,
                	highlight = "Comment",
                },
                hover_actions = {
                	border = {
                		{ "╭", "FloatBorder" },
                		{ "─", "FloatBorder" },
                		{ "╮", "FloatBorder" },
                		{ "│", "FloatBorder" },
                		{ "╯", "FloatBorder" },
                		{ "─", "FloatBorder" },
                		{ "╰", "FloatBorder" },
                		{ "│", "FloatBorder" },
                	},
                	auto_focus = false,
                },
                crate_graph = {
                	backend = "x11",
                	output = nil,
                	full = true,
                	enabled_graphviz_backends = {
                		"bmp",
                		"cgimage",
                		"canon",
                		"dot",
                		"gv",
                		"xdot",
                		"xdot1.2",
                		"xdot1.4",
                		"eps",
                		"exr",
                		"fig",
                		"gd",
                		"gd2",
                		"gif",
                		"gtk",
                		"ico",
                		"cmap",
                		"ismap",
                		"imap",
                		"cmapx",
                		"imap_np",
                		"cmapx_np",
                		"jpg",
                		"jpeg",
                		"jpe",
                		"jp2",
                		"json",
                		"json0",
                		"dot_json",
                		"xdot_json",
                		"pdf",
                		"pic",
                		"pct",
                		"pict",
                		"plain",
                		"plain-ext",
                		"png",
                		"pov",
                		"ps",
                		"ps2",
                		"psd",
                		"sgi",
                		"svg",
                		"svgz",
                		"tga",
                		"tiff",
                		"tif",
                		"tk",
                		"vml",
                		"vmlz",
                		"wbmp",
                		"webp",
                		"xlib",
                		"x11",
                	},
                  },
            	},
            	server = {
                    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
            		standalone = true,
                    settings = {
                      ["rust-analyzer"] = {
                        assist = {
                          importGranularity = "module",
                          importPrefix = "by_self",
                        },
                        rustfmt = {
                          extraArgs = { "+nighlty" }
                        },
                        cargo = {
                          loadOutDirsFromCheck = true,
                        },
                        procMacro = {
                          enable = true
                        },
                      }
                    }
            	},
              })
            EOF

            " au! CursorHold * call AutoDiagnosis()
            " set updatetime=500
            " 
            " func AutoDiagnosis()
            "   lua vim.diagnostic.open_float(nil, { focusable = false })
            " endfunc
          '';
        }
        telescope-nvim
        {
          plugin = toggleterm-nvim;
          config = ''
            lua << EOF
            require("toggleterm").setup {
              open_mapping = [[<c-t>]],
              hide_numbers = true,
              start_in_insert = true,
              insert_mappings = true,
              terminal_mappings = true,
              persist_size = true,
              direction = "float",
              close_on_exit = true,
              shell = vim.o.shell,
              float_opts = {
                border = "double",
                width = math.floor(vim.o.columns * 0.75),
                height = math.floor(vim.o.lines * 0.75),
              },
            }
            EOF
          '';
        }
        vim-highlightedyank
        vim-nix
        vim-vsnip
        {
          plugin = (plugin "sainnhe/everforest");
          config = ''
            set background=dark
            colorscheme everforest

            lua << EOF
              require('nvim-web-devicons').setup()
            EOF
          '';
        }
      ];
    };
}
