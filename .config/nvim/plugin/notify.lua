vim.notify = function(msg, log_level, opts)
  opts = opts or {}
  opts.timeout = opts.timeout or 2000
  require('notify')(msg, log_level, opts)
end
