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

	-- AI IDE features
	{
		"yetone/avante.nvim",
		-- WARN: Disabled
		enabled = true,
		event = "VeryLazy",
		opts = {
			-- add any opts here
			provider = "ollama",
			vendors = {
				---@type AvanteProvider
				ollama = {
					["local"] = true,
					endpoint = "127.0.0.1:11434/v1",
					model = "codegemma",
					parse_curl_args = function(opts, code_opts)
						return {
							url = opts.endpoint .. "/chat/completions",
							headers = {
								["Accept"] = "application/json",
								["Content-Type"] = "application/json",
							},
							body = {
								model = opts.model,
								messages = require("avante.providers").copilot.parse_message(code_opts), -- you can make your own message, but this is very advanced
								max_tokens = 2048,
								stream = true,
							},
						}
					end,
					parse_response_data = function(data_stream, event_state, opts)
						require("avante.providers").openai.parse_response(data_stream, event_state, opts)
					end,
				},
			},
		},
		build = "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			-- "zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				"folke/which-key.nvim",
				opts = {
					spec = {
						mode = { "n", "v" },
						{ "<leader>a", group = "ai" },
					},
				},
			},
		},
	},

	{
		"Wansmer/treesj",
		keys = {
			{ "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
		},
		opts = { use_default_keymaps = false, max_join_length = 150 },
	},
}
