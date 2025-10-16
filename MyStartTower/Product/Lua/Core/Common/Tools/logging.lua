
local type, table, string, assert, _tostring = type, table, string, assert, tostring

local logging = {}

-- The DEBUG Level designates fine-grained instring.formational events that are most
-- useful to debug an application
local DEBUG = "DEBUG"

-- The INFO level designates instring.formational messages that highlight the
-- progress of the application at coarse-grained level
local INFO = "INFO"

-- The WARN level designates potentially harmful situations
local WARN = "WARN"

-- The ERROR level designates error events that might still allow the
-- application to continue running
local ERROR = "ERROR"

-- The FATAL level designates very severe error events that will presumably
-- lead the application to abort
local FATAL = "FATAL"

--network send--
local SEND = "SEND"
--network recv--
local RECV = "RECV"

local LEVEL = {
  [DEBUG] = 1,
  [INFO]  = 2,
  [WARN]  = 3,
  [ERROR] = 4,
  [FATAL] = 5,
  [SEND] = 6,
  [RECV] = 7,
}


-------------------------------------------------------------------------------
-- Creates a new logger object
-- @param append Function used by the logger to append a message with a
--  log-level to the log stream.
-- @return Table representing the new logger object.
-------------------------------------------------------------------------------
function logging.new(append)

  if type(append) ~= "function" then
    return nil, "Appender must be a function."
  end

  local logger = {}
  logger.level = DEBUG
  logger.append = append

  logger.setLevel = function (self, level)
    assert(LEVEL[level], string.format("undefined level `%s'", tostring(level)))
    self.level = level
  end

  logger.log = function (self, level, message)
    assert(LEVEL[level], string.format("undefined level `%s'", tostring(level)))
    if LEVEL[level] < LEVEL[self.level] then
      return
    end
    if type(message) ~= "string" then
      message = tostring(message)
    end
    return logger:append(level, message)
  end

  logger.debug = function (logger, message) return logger:log(DEBUG, message) end
  logger.info  = function (logger, message) return logger:log(INFO,  message) end
  logger.warn  = function (logger, message) return logger:log(WARN,  message) end
  logger.error = function (logger, message) return logger:log(ERROR, message) end
  logger.fatal = function (logger, message) return logger:log(FATAL, message) end
  logger.send = function (logger, message) return logger:log(SEND, message) end
  logger.recv = function (logger, message) return logger:log(RECV, message) end
  return logger
end


-------------------------------------------------------------------------------
-- Prepares the log message
-------------------------------------------------------------------------------
function logging.prepareLogMsg(pattern, dt, level, message)

    local logMsg = pattern or "%level %message\n"
    message = string.gsub(message, "%%", "%%%%")
    -- logMsg = string.gsub(logMsg, "%%date", dt)
    logMsg = string.gsub(logMsg, "%%level", level)
    logMsg = string.gsub(logMsg, "%%message", message)
    return logMsg
end


-------------------------------------------------------------------------------
-- Converts a Lua value to a string
--
-- Converts Table fields in alphabetical order
-------------------------------------------------------------------------------
function logging.tostring(value)
  local str = ''

  if (type(value) ~= 'table') then
    if (type(value) == 'string') then
      str = string.format("%q", value)
    else
      str = _tostring(value)
    end
  else
    local auxTable = {}
    table.foreach(value, function(i, v)
      if (tonumber(i) ~= i) then
        table.insert(auxTable, i)
      else
        table.insert(auxTable, tostring(i))
      end
    end)
    table.sort(auxTable)

    str = str..'{'
    local separator = ""
    local entry = ""
    table.foreachi (auxTable, function (i, fieldName)
      if ((tonumber(fieldName)) and (tonumber(fieldName) > 0)) then
        entry = tostring(value[tonumber(fieldName)])
      else
        entry = fieldName.." = "..tostring(value[fieldName])
      end
      str = str..separator..entry
      separator = ", "
    end)
    str = str..'}'
  end
  return str
end

return logging

