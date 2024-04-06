-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },

  -- themes
  { import = "astrocommunity.colorscheme.catppuccin" },

  -- language packs
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.proto" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.terraform" },
  { import = "astrocommunity.pack.helm" },

  -- debugging 
  { import = "astrocommunity.debugging.persistent-breakpoints-nvim" },

  -- Markdown handling
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim"},
}
