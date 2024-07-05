return {
	-- Run ollama models for code completion, setup for codellama:7b-code
	{
		"huggingface/llm.nvim",
		opts = {
			tokens_to_clear = { "<|endoftext|>" },
			fim = {
				enabled = true,
				prefix = "<fim_prefix>",
				middle = "<fim_middle>",
				suffix = "<fim_suffix>",
			},
			model = "starcoder2:3b",
			content_window = 8192,
			tokenizer = {
				url = "http://localhost:11434/api/generate",
				accept_keymap = "<Right>",
				repository = "bigcode/starcoder2-3b",
			},
			dismiss_keymap = "<Left>",
			adaptor = "ollama",
			request_body = { model = "starcoder2:3b" },
		},
		event = "LspAttach",
		-- WARN: Disabled
		enabled = false,
	},

	-- Run ollama models from neovim
	{
		"David-Kunz/gen.nvim",
		cmd = "Gen",
		opts = {
			model = "codellama",
		},
		-- WARN: Disabled
		enabled = false,
	},

	-- Set <tab> and <s-tab> to move between items of LuaSnip
	{
		"hrsh7th/nvim-cmp",
		opts = function()
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
			local cmp = require("cmp")
			local defaults = require("cmp.config.default")()
			local auto_select = true

			return {
				auto_brackets = {}, -- configure any filetype to auto add brackets
				completion = {
					completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
				},
				preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
					["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
					["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<C-CR>"] = function(fallback)
						cmp.abort()
						fallback()
					end,
					-- NOTE: Added tab controls to lazyvim defaults
					["<Tab>"] = function(fallback)
						if not cmp.select_next_item() then
							if vim.bo.buftype ~= "prompt" and has_words_before() then
								cmp.complete()
							else
								fallback()
							end
						end
					end,
					["<S-Tab>"] = function(fallback)
						if not cmp.select_prev_item() then
							if vim.bo.buftype ~= "prompt" and has_words_before() then
								cmp.complete()
							else
								fallback()
							end
						end
					end,
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
				formatting = {
					format = function(_, item)
						local icons = LazyVim.config.icons.kinds
						if icons[item.kind] then
							item.kind = icons[item.kind] .. item.kind
						end
						return item
					end,
				},
				experimental = {
					ghost_text = {
						hl_group = "CmpGhostText",
					},
				},
				sorting = defaults.sorting,
			}
		end,
	},

	{
		"Wansmer/treesj",
		keys = {
			{ "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
		},
		opts = { use_default_keymaps = false, max_join_length = 150 },
	},
}
