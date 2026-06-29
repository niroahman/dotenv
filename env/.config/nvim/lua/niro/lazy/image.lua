return {
    "3rd/image.nvim",
    ft = { "markdown", "mdx" },
    opts = {
        backend = "kitty",
        processor = "magick_cli",
        integrations = {
            markdown = {
                enabled = true,
                clear_in_insert_mode = false,
                download_remote_images = false,
                only_render_image_at_cursor = false,
                floating_windows = false,
            },
        },
        max_width = 60,
        max_height = 30,
        max_height_window_percentage = 40,
        max_width_window_percentage = 50,
        window_overlap_clear_enabled = true,
    },
}
