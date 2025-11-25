--[=[
    @author Desktop2677
    @class Bootstrapper
]=]

export type Bootstrapper = {
    New: () -> Engine,
    Packages: { table },
    GetPackage: (Package: string) -> Table,
}

-- @class Bootstrapper
local Bootstrapper = {}; do
    Bootstrapper.__index = Bootstrapper

    -- @method New
    function Bootstrapper:New()
        local self = setmetatable({Packages = {}}, Bootstrapper)

        do -- Self
            self.Packages = {}
        end

        do -- Packages
            local Packages = {"Engine"}

            for Index, Package in pairs(Packages) do
                local Directory, Downloaded = "https://raw.githubusercontent.com/krampus-organization/Division/refs/heads/main/", nil

                local Success, Error = pcall(function()
                    Downloaded = request({Url = string.format("%s%s.luau", Directory, Package), Method = "GET"})
                end)

                if Success and Downloaded then
                    self.Packages[Package] = loadstring(Downloaded.Body)()
                end
            end
        end

        return (self :: any) :: Bootstrapper
    end

    -- @method GetPackage
    function Bootstrapper:GetPackage(Package: string)
        return self.Packages[Package]
    end
end

return Bootstrapper
