-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls" }
local util = require "lspconfig/util"

local sorbet_on_attach = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = { noremap = true, silent = true }
    if not vim.keymap.get("n", "gd", { buffer = bufnr }) then
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    end
    if not vim.keymap.get("n", "gD", { buffer = bufnr }) then
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    end
    if not vim.keymap.get("n", "K", { buffer = bufnr }) then
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    end
end

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

-- Golang/gopls config
lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}
-- End

-- Ruby/solargraph config
-- lspconfig.solargraph.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   on_init = on_init,
--   cmd = { "solargraph", "stdio" },
--   filetypes = { "ruby", "rake" },
--   init_options = {
--     formatting = true,
--   },
--   root_dir = util.root_pattern("Gemfile", ".git"),
--   settings = {
--     solargraph = {
--       diagnostics = true,
--       formatting = true,
--     },
--   },
-- }
-- End

-- Ruby/sorbet config
lspconfig.sorbet.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  -- cmd = { "bundle", "exec", "srb", "tc", "--lsp" }, -- Uses bundler to execute sorbet
  -- Alternatively, if you have sorbet installed globally:
  -- cmd = { "srb", "tc", "--lsp" },
  cmd = {
    "srb", "tc", "--lsp",
    "--dir", ".", -- Your main source directory (adjust if needed)
  },
  filetypes = { "ruby", "rake" },
  root_dir = require("lspconfig/util").root_pattern("Gemfile", ".git"),
}
-- End

-- Possible other options for sorbet above
-- "--include", ".bundle/gems/**/gems", -- Include gem definitions
-- "--exclude", "vendor/bundle/**", -- Exclude vendor directory (optional)
-- "--exclude", "tmp/**", -- Exclude tmp directory (optional)


-- Ruby/rubocop config (TOO SLOW TO RUN ON  MACOS WITH OLD RUBY VERSIONS :( )
-- lspconfig.rubocop.setup {
--   cmd = { "rubocop", "--lsp" },
--   filetypes = { "ruby", "rake" },
--   root_dir = util.root_pattern("Gemfile", ".git"),
-- }
-- End
