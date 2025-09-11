
return {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
        require("rose-pine").setup({
            variant = "auto",
            dark_variant = "main",
            styles = {
                bold = true,
                italic = true,
                transparency = false, -- doesn't affect `Normal` bg unless you set it manually
            },
        })

        vim.api.nvim_create_user_command("LuaLoadRosePine", function()
            vim.cmd("colorscheme rose-pine")
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end, {})
    end,
}


