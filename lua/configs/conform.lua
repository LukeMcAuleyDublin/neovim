local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    ruby = { "rufo" },
    go = { "gofmt" },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 100,
    lsp_fallback = true,
  },
}

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function(args)
--     require("conform").format({ bufnr = args.buf })
--   end,
-- })

-- require("conform").setup({
--   formatters = {
--     rubocop = {
--       command = "bundle exec rubocop -a -s"
--     }
--   }
-- })

require("conform").setup(options)
