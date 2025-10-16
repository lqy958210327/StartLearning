local function detail(e, tab)
    local ty = type(e)
    if ty == 'nil' then
        return 'nil'
    elseif ty == 'string' then
        return "'"..e.."'"
    elseif ty == 'table' then
        local mt = getmetatable(e)
        if mt and mt.__tostring then
            return tostring(e)
        else
            local t = {}
            local n = 1
            tab = tab or '\n'
            local ttab = tab..'\t'
            for i, x in pairs(e) do
                local v = detail(x, ttab)
                if i == n then
                    table.insert(t, v)
                    n = n + 1
                else
                    if type(i) == 'string' then
                        table.insert(t, tab..i..'='..v)
                    else
                        local k = detail(i, ttab)
                        table.insert(t, tab..'['..k..']='..v)
                    end
                end
            end
            return '{'..table.concat(t, ',')..'}'
        end
    else
        return tostring(e)
    end
end

local AbilityLogger = {}

AbilityLogger.Level = {fatal=1,error=2,warn=3,info=4,debug=5,trace=6,tick=7,all=1000}

function AbilityLogger:setLevel(n)
    self.level = n
end

function AbilityLogger:setFrame(frameNumber, realFrameNumber)
    self.frame, self.realFrame = frameNumber, realFrameNumber
end

function AbilityLogger:log(...)
    local s = detail({self.frame, self.realFrame, ...})
    self:write(s)
end

local function color(s)
    if string.find(s, 'error') then
        return 'red'
    elseif string.find(s, 'warn') then
        return 'yellow'
    elseif string.find(s, 'info') then
        return 'blue'
    elseif string.find(s, 'trace') then
        return 'green'
    else
        return 'cyan'
    end
end
function AbilityLogger:write(s)
    if LuaCallCs.IsEditor() then -- 编辑器模式下执行写文件操作
        local f = self.file
        if f then
            f:write(s..'\n')
            f:flush()
        end
    end
    if LuaCallCs.IsEditor() and LuaCallCs.EngineConfig.BattleLogOpen() then -- 实时日志不打印
        local print = self.print
        if print then
            print('<color='..color(s)..'>战斗日志</color>'..s)
        end
    end
end

--- @class Logger
local Logger = {}
local LoggerMt = {__index=Logger}

for l,v in pairs(AbilityLogger.Level) do
    Logger[l] = function(self, ...)
        local lv = self.level or self.writer.level
        if v <= lv then
           self.writer:log(l, self.module, self.name, ...)
        end
    end
end

function Logger.traceback(err)
    return err .. ' ' .. debug.traceback()
end
function Logger:newLogger(module, name, level)
    return setmetatable({module = module or self.module, name = name or self.name, level = level or self.level, writer=self.writer}, LoggerMt)
end

function AbilityLogger:newLogger(module, name, level)
    return setmetatable({module = module, name = name or module, level = level, writer=self}, LoggerMt)
end

function AbilityLogger:close()
    local f = self.file
    if f then
        f:close()
        self.file = nil
    end
end
local AbilityLoggerMt = {__index=AbilityLogger, __gc = AbilityLogger.close}

local function newAbilityLogger(matrixId, round, loggerConfig)
    loggerConfig = loggerConfig or { logpath = '.', logprint = print, loglevel = AbilityLogger.Level.trace }
    local file = nil
    if loggerConfig.logpath then
        local filename = string.format('%s/battlelog_%s_%s.log', loggerConfig.logpath, matrixId or os.date('%H%M%S'), round or 0)
        file = io.open(filename, 'a')
        if file then
            file:setvbuf ("line")
        end
    end
    local logger = {file = file, level = loggerConfig.loglevel, print = loggerConfig.logprint, frame = 0, realFrame = 0}
    setmetatable(logger, AbilityLoggerMt)
    return logger
end

return newAbilityLogger