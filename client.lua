local uiFaded = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData().job2 == nil do
		Citizen.Wait(10)
	end

	local xPlayer = ESX.GetPlayerData()
	local money, black_money, bank = 0, 0, 0

	for i = 1, #xPlayer.accounts, 1 do
		if xPlayer.accounts[i].name == 'black_money' then
			black_money = ESX.Math.GroupDigits(xPlayer.accounts[i].money)
		elseif xPlayer.accounts[i].name == 'money' then
			money = ESX.Math.GroupDigits(xPlayer.accounts[i].money)
		end
	end

	SendNUIMessage({
		action = 'setInfos',
		infos = {
			{
				name = 'money',
				value = money
			},
			{
				name = 'black_money',
				value = black_money
			},
			{
				name = 'job',
				value = ('%s - %s'):format(xPlayer.job.label, xPlayer.job.grade_label)
			},
			{
				name = 'job2',
				value = ('%s - %s'):format(xPlayer.job2.label, xPlayer.job2.grade_label)
			}
		}
	})
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	local money, black_money, bank = 0, 0, 0

	for i = 1, #xPlayer.accounts, 1 do
		if xPlayer.accounts[i].name == 'black_money' then
			black_money = ESX.Math.GroupDigits(xPlayer.accounts[i].money)
		elseif  xPlayer.accounts[i].name == 'money' then
			money = ESX.Math.GroupDigits(xPlayer.accounts[i].money)
		end
	end

	SendNUIMessage({
		action = 'setInfos',
		infos = {
			{
				name = 'money',
				value = money
			},
			{
				name = 'black_money',
				value = black_money
			},
			{
				name = 'job',
				value = ('%s - %s'):format(xPlayer.job.label, xPlayer.job.grade_label)
			},
			{
				name = 'job2',
				value = ('%s - %s'):format(xPlayer.job2.label, xPlayer.job2.grade_label)
			}
		}
	})
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	SendNUIMessage({
		action = 'setInfos',
		infos = {
			{
				name = 'job',
				value = ('%s - %s'):format(job.label, job.grade_label)
			}
		}
	})
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	SendNUIMessage({
		action = 'setInfos',
		infos = {
			{
				name = 'job2',
				value = ('%s - %s'):format(job2.label, job2.grade_label)
			}
		}
	})
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)

	if account.name == 'black_money' then
		SendNUIMessage({
			action = 'setInfos',
			infos = {
				{
					name = 'black_money',
					value = ESX.Math.GroupDigits(account.money)
				}
			}
		})
	elseif account.name == 'money' then
		SendNUIMessage({
			action = 'setInfos',
			infos = {
				{
					name = 'money',
					value = ESX.Math.GroupDigits(account.money)
				}
			}
		})
	end
end)

RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(e)
	SendNUIMessage({action = "setInfos", name = "money", value = "$"..e})
end)

RegisterNetEvent('hud:updatemoney')
AddEventHandler('hud:updatemoney', function(e)
	SendNUIMessage({
		action = "setInfos",
		infos = {
			{
				name = "money",
				value = ESX.Math.GroupDigits(e)
			}
		}
	})
end)

AddEventHandler('tempui:toggleUi', function(value)
	uiFaded = value

	if uiFaded then
		SendNUIMessage({action = 'fadeUi', value = true})
	else
		SendNUIMessage({action = 'fadeUi', value = false})
	end
end)