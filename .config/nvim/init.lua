local config = vim.fn.stdpath("config")
package.path = config .. "/lua/?.lua;" .. config .. "/lua/?/init.lua;" .. package.path

require("core.options")
require("core.keymap")
require("core.commands")
require("core.autocmds")

require("core.lazy")
