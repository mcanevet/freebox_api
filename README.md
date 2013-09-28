Freebox OS API bindings for Ruby
================================

WARNING: Work In Progress.

Overview
--------
This gem contains Freebox OS API bindings for the Ruby language.
I started working on that to use it with https://github.com/mcanevet/puppet-freebox

Building the Freebox object
---------------------------

```ruby
require 'freebox_api'

myFreebox = FreeboxApi::Freebox.new
```

or

```ruby
require 'freebox_api'

myFreebox = FreeboxApi::Freebox.new({
  :freebox_ip   => 'mafreebox.example.com',
  :freebox_port => 4242,
})
```

Login
-----

### Obtaining an app\_token

#### Request authorization

This is the first step, the app will ask for an app\_token using the following call. A message will be displayed on the Freebox LCD asking the user to grant/deny access to the requesting app.

Once the app has obtained a valid app\_token, it will not have to do this procedure again unless the user revokes the app\_token.

```ruby
token_request = {
  :app_id      => 'fr.freebox.testapp',
  :app_name    => 'Test App',
  :app_version => '0.0.7',
  :device_name => 'Pc de Xavier'
}

auth_request = myFreebox.authorize(token_request)

app_token = auth_request['app_token']
```

#### Track authorization progress

```ruby
puts myFreebox.track_auth(auth_request['track_id'])
```

### Obtaining a session\_token

```ruby
myApp = {
  :app_id      => 'fr.freebox.testapp',
  :app_version => '0.0.7',
  :app_token   => 'dyNYgfK0Ya6FWGqq83sBHa7TwzWo+pg4fDFUJHShcjVYzTfaRrZzm93p7OTAfH/0',
}
mySession = FreeboxApi::Session.new(myApp, myFreebox)
```

#### Getting the current challenge value

```ruby
myFreebox.challenge
```

#### Opening a session

```ruby
mySession.session_token
```

LAN Browser
-----------

### Getting the list of browsable LAN interfaces

```ruby
interfaces = FreeboxApi::Resources::Interface.new(mySession)
interfaces.index
```

### Getting the list of hosts

```ruby
lan_hosts = FreeboxApi::Resources::LanHost.new(mySession)
lan_hosts.index
```

### Getting an host information

```ruby
lan_hosts.show('ether-00:24:d4:7e:00:4c')
```

### Updating an host information

```ruby
lan_hosts.update({
  :id           => 'ether-00:24:d4:7e:00:4c',
  :primary_name => 'Freebox Tv',
})
```

DHCP
----

### Get the list of DHCP static leases

```ruby
static_leases = FreeboxApi::Resources::StaticLease.new(mySession)
static_leases.index
```

### Get a given DHCP static lease

```ruby
static_leases.show('00:DE:AD:B0:0B:55)
```

### Update DHCP static lease

```ruby
static_leases.update({
  :id      => '00:DE:AD:B0:0B:55',
  :comment => 'Mon PC',
})
```

### Delete a DHCP static lease

```ruby
static_lease.destroy('00:DE:AD:B0:0B:55')
```

### Add a DHCP static lease
```ruby
static_lease.create({
  :ip  => '192.168.1.222',
  :mac => '00:00:00:11:11:11',
})
```

Port Forwarding
---------------

### Getting the list of port forwarding

```ruby
port_forwardings = FreeboxApi::Resources::PortForwarding.new(mySession)
port_forwardings.index
```

### Getting a specific port forwarding

```ruby
port_forwardings.show(1)
```

### Updating a port forwarding

```ruby
port_forwardings.update({
  :id      => 1,
  :enabled => false,
})
```

### Add a port forwarding

```ruby
port_forwardings.create({
  :enabled        => true,
  :comment        => 'test',
  :lan_port       => 4242,
  :wan_port_end   => 4242,
  :wan_port_start => 4242,
  :lan_ip         => '192.168.1.42',
  :ip_proto       => 'tcp',
})
```

### Delete a port forwarding

```ruby
port_forwardings.destroy(3)
```