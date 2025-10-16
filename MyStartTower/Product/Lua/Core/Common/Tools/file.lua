-------------------------------------------------------------------------------
-- Saves logging information in a file
--
-- @author Thiago Costa Ponte (thiago@ideais.com.br)
--
-- @copyright 2004-2007 Kepler Project
--
-- @release $Id: file.lua,v 1.5 2007/09/05 12:15:31 tomas Exp $
-------------------------------------------------------------------------------

local logging = require "Core/Common/Tools/logging"

function logging.file(filename, datePattern, logPattern)

    if type(filename) ~= "string" then
        filename = "lualogging.log"
    end
    filename = string.format(filename, os.date(datePattern))
    local f = io.open(filename, "a")
    if not f then
       return nil, string.format("file `%s' could not be opened for writing", filename)
    end
    f:setvbuf ("line")

    local logger = logging.new( function(self, level, message)
                            local s = logging.prepareLogMsg(logPattern, os.date(), level, message)
                            f:write(s)
                            f:flush()
                            return true
                        end
                      )
    logger.close = function (self)
        f:close()
        return true
    end

    logger.close = function (self)
        f:close()
        return true
    end

    return logger
end

return logging.file