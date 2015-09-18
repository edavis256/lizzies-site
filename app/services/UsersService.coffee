app.factory 'UsersService', ->
  users = []
  names = ['Tim', 'John', 'Doe', 'Jackson']
  # generate some random user data
  for i in [0..4]
    name = "
    #{names[Math.floor((Math.random()*names.length)%names.length)]}
    #{names[Math.floor((Math.random()*names.length)%names.length)]}"
    user =
      id: i
      name: name
      description: "#{name} is just another cool guy."
    users.push user

  return {
    list: ->
      return users
    find: (id)->
      if users[id]? then return users[id]
      return {
        id: id,
        name: 'anonymous',
        description: 'user info goes here'
      }
  }
