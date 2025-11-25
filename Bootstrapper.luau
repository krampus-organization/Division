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
        local Self = setmetatable({Packages = {}}, Bootstrapper)

        do -- Packages
            local Packages = {"Engine"}

            for Index, Package in pairs(Packages) do
                local Directory, Downloaded = "https://raw.githubusercontent.com/krampus-organization/Division/refs/heads/main/", nil

                local Success, Error = pcall(function()
                    Downloaded = request({Url = string.format("%s%s.luau", Directory, Package), Method = "GET"})
                end)

                if Success and Downloaded then
                    Self.Packages[Package] = loadstring(Downloaded.Body)()
                end
            end
        end

        return (Self :: any) :: Bootstrapper
    end

    -- @method GetPackage
    function Bootstrapper:GetPackage(Package: string)
        return self.Packages[Package]
    end
end

return Bootstrapper
