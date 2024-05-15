
Q1 - Fix or improve the implementation of the below methods

-- release storage should have two more parameters key and value
local function releaseStorage(player,key,value)
player:setStorageValue(key, value)
end

function onLogout(player,key,value)
-- if the key exist then the value is gotten
if player:getStorageValue(key) ~= -1 then
-- release storage is added tp the event manager with its 3 parameters
addEvent(releaseStorage, player,key,value)
return true
end
return false
end


Q2 - Fix or improve the implementation of the below method

function printSmallGuildNames(memberCount)
-- this method is supposed to print names of all guilds that have less than memberCount max members
-- %d moved to the right place in the string
local selectGuildQuery = "SELECT name FROM guilds WHERE %d < max_members"
local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
local guildName 
-- result state of the query is validated begore getting the name
if resultId ~= false then
guildName = result.getString("name")
print(guildName)
end
end


Q3 - Fix or improve the name and the implementation of the below method

function quit_PlayerParty(player, membername)
local party = player:getParty()
-- members is a map has the key and v is a pointer to the corresponding member
for k,v in pairs(party:getMembers()) do 
-- the name of the selected member is compared to the input name. if there are equal then the pointer v is fed to removeMember method in order to quit the party
if v:getname() == membername then 
party:removeMember(v)
end
end
end

Q4 - Assume all method calls work fine. Fix the memory leak issue in below method

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
Player* player = g_game.getPlayerByName(recipient);
if (!player) {
player = new Player(nullptr);
if (!IOLoginData::loadPlayerByName(player, recipient)) {
//if the loadPlayerByName failed the alocated pointer becomes useless causing memory leak. So it should be deleted when it is failed
   delete player;
return;
}
}

Item* item = Item::CreateItem(itemId);
if (!item) {
return;
}

g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

if (player->isOffline()) {
IOLoginData::savePlayer(player);
}
}
