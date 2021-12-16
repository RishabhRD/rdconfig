local api = require "rd.formatter.api"

return function()
  api.format_with_cmd { "clang-format" }
end
