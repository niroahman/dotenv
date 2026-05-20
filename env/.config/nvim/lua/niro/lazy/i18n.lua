return {
	"niroahman/js-i18n.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
		"nvim-lua/plenary.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		primary_language = { "en" }, -- The default language to display (initial setting for displaying virtual text, etc.)
		translation_source = { "**/{locales,messages,i18n}/*.json" }, -- Pattern for translation resources
		respect_gitignore = true, -- Whether to respect .gitignore when retrieving translation resources and implementation files. Setting to false may improve performance.
		-- detect_language = function(path)
		-- 	return path:match(".%.([^.]+)%.json$")
		-- end, -- Function to detect the language. By default, a function that detects the language heuristically from the file name is used.
		key_separator = ".", -- Key separator
		virt_text = {
			enabled = true, -- Enable virtual text display
			format = ..., -- Format function for virtual text
			conceal_key = false, -- Hide keys and display only translations
			fallback = false, -- Fallback if the selected virtual text cannot be displayed
			max_length = 0, -- Maximum length of virtual text. 0 means unlimited.
			max_width = 0, -- Maximum width of virtual text. 0 means unlimited. (`max_length` takes precedence.)
		},
		diagnostic = {
			enabled = true, -- Enable the display of diagnostic information
			severity = vim.diagnostic.severity.WARN, -- Severity level of diagnostic information
		},
	},
}
