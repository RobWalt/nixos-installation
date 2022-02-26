{ pkgs, ... }:
let
  unstable = import <nixos-unstable> { };
in
{
  environment.variables.EDITOR = "nvim";

  environment.systemPackages = with pkgs;
    let
      general_settings = ''
        set nocompatible
        set showmatch
        set ignorecase
        set hlsearch
        set incsearch
        set background=dark
        set clipboard=unnamedplus
        set completeopt=menu,menuone,noselect
        set cursorline
        set hidden
        set inccommand=split
        set relativenumber
        set splitbelow splitright
        set title
        set wildmenu
        set cc=120
        set expandtab
        set shiftwidth=4
        set tabstop=4
        set softtabstop=4
        set autoindent
        filetype plugin indent on
      '';
      cmp_settings = ''
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
      lsp_settings = ''
        autocmd BufWritePre *.nix lua vim.lsp.buf.formatting_sync(nil, 100)
        autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 100)

        lua << EOF
          require('lspconfig').rnix.setup{};
          require('lspconfig').rust_analyzer.setup {
            capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
            settings = {
              ["rust-analyzer"] = {
                assist = {
                  importGranularity = "module",
                  importPrefix = "by_self",
                },
                cargo = {
                  loadOutDirsFromCheck = true
                },
                procMacro = {
                  enable = true
                },
              }
            }
          }
        EOF
      '';
      colorscheme_settings = ''
        autocmd vimenter * ++nested colorscheme gruvbox
      '';
      nerdtree_settings = ''
        let NERDTreeQuitOnOpen=1 
        autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.insTabTree() | quit | endif
      '';
      treesitter-settings = ''
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
      rust-tools-settings = ''
        lua << EOF
          local opts = {
            tools = {
              autoSetHints = true,
              hover_with_actions = true,
              runnables = {
                use_telescope = true
              },
              debuggables = {
                use_telescope = true
              },
              inlay_hints = {
                only_current_line = false,
                only_current_line_autocmd = "CursorHold",
                show_parameter_hints = true,
                parameter_hints_prefix = "<- ",
                other_hints_prefix = "=> ",
                max_len_align = false,
                max_len_align_padding = 1,
                right_align = false,
                right_align_padding = 7,
                highligh = "Comment",
              },
              hover_actions = {
                border = {
                  {"x", "FloatBoarder"}, {"x", "FloatBoarder"},
                  {"x", "FloatBoarder"}, {"x", "FloatBoarder"},
                  {"x", "FloatBoarder"}, {"x", "FloatBoarder"},
                  {"x", "FloatBoarder"}, {"x", "FloatBoarder"}
                },
                auto_focus = false
              },
              crate_graph = {
                backend = "x11",
                output = nil,
                full = true,
              }
            },
            server = {
            },
          }
          require('rust-tools').setup(opts)
        EOF

        "other Rust functionality
        au! CursorHold * call AutoDiagnosis()
        set updatetime=500
        func AutoDiagnosis()
          lua vim.diagnostic.open_float(nil, { focusable = false })
        endfunc
      '';
      keybindings = ''
        nnoremap <silent> <C-d> :NERDTree<CR>
        nnoremap <silent> <C-f> :NERDTreeFind<CR>
        nnoremap <silent> <C-t> :NERDTreeToggle<CR>
        nnoremap <silent> <C-K> <cmd>lua vim.lsp.buf.signature_help()<CR>
        nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
        nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
        nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
        nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
        nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
        nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
        nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
        nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action()<CR>
        vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
      '';
      myneovim = (unstable.neovim.override {
        viAlias = true;
        vimAlias = true;
        configure = {
          plug.plugins = with pkgs.vimPlugins;
            [
              vim-nix
              gruvbox
              rust-tools-nvim
              nvim-lspconfig
              cmp-nvim-lsp
              cmp-buffer
              nvim-cmp
              cmp-vsnip
              vim-vsnip
              plenary-nvim
              nvim-dap
              popup-nvim
              telescope-nvim
              nvim-treesitter
              nerdtree
              auto-pairs
              ctrlp-vim
            ];
          customRC = general_settings
            + cmp_settings
            + lsp_settings
            + colorscheme_settings
            + nerdtree_settings
            + treesitter-settings
            + rust-tools-settings
            + keybindings;
        };
      });
    in
    [
      myneovim
      gcc # needed for treesitter compilation
      clang # needed for rust-tools
      git # needed for treesitter download
      rnix-lsp # nix lsp
      rust-analyzer # rust lsp
    ];
}
