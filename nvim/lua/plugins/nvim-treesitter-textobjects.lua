return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = false,
    config = function()
        require("nvim-treesitter.configs").setup({
            textobjects = {
                select = {
                    enable = true,

                    --     -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,

                    keymaps = {
                        --         -- You can use the capture groups defined in textobjects.scm
                        ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
                        ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
                        ["=l"] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
                        ["=r"] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

                        ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
                        ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

                        ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
                        ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

                        ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
                        ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

                        ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
                        ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

                        ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
                        ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

                        ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },

                        ["a/"] = { query = "@comment.outer", desc = "Select outer part of a comment" },
                        ["i/"] = { query = "@comment.inner", desc = "Select inner part of a comment" },
                    },
                },
                -- swap = {
                --     enable = true,
                --     swap_next = {
                --         ["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
                --         ["<leader>nm"] = "@function.outer",  -- swap function with next
                --     },
                --     swap_previous = {
                --         ["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
                --         ["<leader>pm"] = "@function.outer",  -- swap function with previous
                --     },
                -- },
            },
        })
    end,
}
