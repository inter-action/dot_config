return {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {
        label = {
            -- allow uppercase labels
            uppercase = false,
        }
    },
    -- stylua: ignore
    keys = {
        {
            "<leader><leader>w",
            mode = {
                "n"
            },
            function()
                require("flash").jump({
                    search = { forward = true, wrap = false, multi_window = false, mode = "fuzzy" },
                })
            end,
            desc = "Fash foward"
        },
        {
            "<leader><leader>b",
            mode = {
                "n"
            },
            function()
                require("flash").jump({
                    search = { forward = false, wrap = false, multi_window = false, mode = "fuzzy" },
                })
            end,
            desc = "Fash backwards"
        },
        -- {"s", mode = {"n", "x", "o"}, function() require("flash").jump({}) end, desc = "Flash"},
        {"<leader><leader>s", mode = {"n", "o", "x"}, function() require("flash").treesitter() end, desc = "Flash Treesitter"},
        {"r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash"},
        {"R", mode = {"o", "x"}, function() require("flash").treesitter_search() end, desc = "Treesitter Search"},
        {"<c-s>", mode = {"c"}, function() require("flash").toggle() end, desc = "Toggle Flash Search"}
    }
}
