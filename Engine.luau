--[=[
    @author Desktop2677
    @class Engine
]=]

export type Engine = {
    New: () -> Engine,

    Objects: { Instance },
    Connections: { RBXScriptConnection },

    Create: (self: Engine, Class: string, Properties: { [string]: any }) -> Instance,
    Destroy: (self: Engine, Object: Instance) -> (),

    Connect: (self: Engine, Signal: RBXScriptSignal, Fn: (...any) -> ...any) -> RBXScriptConnection,
    Disconnect: (self: Engine, Connection: RBXScriptConnection) -> (),

    Unload: (self: Engine) -> (),
}

-- @class Engine
local Engine = {}; do
    Engine.__index = Engine

    -- @method New
    function Engine:New()
        local Self = setmetatable({}, Engine)
        
        do -- Self
            Self.Objects = {};
            Self.Connections = {}
        end

        return (Self :: any) :: Engine
    end

    -- @method Create
    function Engine:Create(Class: string, Properties: { [string]: any }): Instance
        local Object = Instance.new(Class)

        do -- Properties
            for Property, Value in pairs(Properties) do
                Object[Property] = Value
            end
        end

        do -- Cache Object
            table.insert(self.Objects, Object)
        end

        return Object
    end

    -- @method Destroy
    function Engine:Destroy(Object: Instance)
        do -- Remove Cache
            table.remove(self.Objects, table.find(self.Objects, Object))
        end

        do -- Destroy Object
            Object:Destroy()
        end
    end

    -- @method Connect
    function Engine:Connect(Signal: RBXScriptSignal, Fn: (...any) -> ...any)
        local Connection = nil

        do -- Connect Signal
            Connection = Signal:Connect(Fn)
        end

        do -- Cache Signal
            table.insert(self.Connections, Connection)
        end
        
        return Connection
    end

    -- @method Disconnect
    function Engine:Disconnect(Connection: RBXScriptConnection)
        local Index = table.find(self.Connections, Connection)
		
        if Index then
            do -- Remove Connection Memory
                table.remove(self.Connections, Index)
            end

            do -- Disconnect Connection
                Connection:Disconnect()
            end
        end
    end

    -- @method Unload
    function Engine:Unload()
        do -- Disconnect Connections
            for Index, Connection in pairs(self.Connections) do
                Connection:Disconnect()
            end
        end

        do -- Clear Connection Cache
            table.clear(self.Connections)
        end
    end
end

return Engine
