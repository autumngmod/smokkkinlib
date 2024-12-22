local module = smokkkin.module:get("karma")

module:event(function(player)
  print(player)
end, "playerJoined", "id")