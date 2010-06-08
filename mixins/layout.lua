--[[
LICENSE
	cargBags: An inventory framework addon for World of Warcraft

	Copyright (C) 2010  Constantin "Cargor" Schomburg <xconstruct@gmail.com>

	cargBags is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	cargBags is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with cargBags; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

DESCRIPTION:
	This file holds a list of default layouts
]]

local Container = cargBags.classes.Container
Container.layouts = {}
local layouts = Container.layouts

function Container:LayoutButtons(layout, ...)
	return self.layouts[layout](self, ...)
end


function layouts:grid(columns, spacing, xOffset, yOffset)
	columns, spacing = columns or 8, spacing or 5
	xOffset, yOffset = xOffset or 0, yOffset or 0


	local width, height
	local col, row = 0, 0
	for i, button in ipairs(self.buttons) do

		if(i == 1) then -- Hackish, I know
			width, height = button:GetSize()
		end

		col = i % columns
		if(col == 0) then col = columns end
		row = math.ceil(i/columns)

		local xPos = (col-1) * (width + spacing)
		local yPos = -1 * (row-1) * (height + spacing)

		button:ClearAllPoints()
		button:SetPoint("TOPLEFT", self, "TOPLEFT", xPos+xOffset, yPos+yOffset)
	end

	return columns * (37+spacing)-spacing, row * (37+spacing)-spacing
end

function layouts:circle(radius, xOffset, yOffset)
	radius = radius or (#self.buttons*50)/math.pi/2
	xOffset, yOffset = xOffset or 0, yOffset or 0

	local a = 360/#self.buttons

	for i, button in ipairs(self.buttons) do
		local x = radius*cos(a*i)
		local y = -radius*sin(a*i)

		button:ClearAllPoints()
		button:SetPoint("TOPLEFT", self, "TOPLEFT", radius+x+xOffset, y-radius+yOffset)
	end
	return radius*2, radius*2
end
