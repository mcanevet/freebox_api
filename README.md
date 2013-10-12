Freebox OS API bindings for Ruby
================================

WARNING: Work In Progress.

Overview
--------

This gem contains Freebox OS API bindings for the Ruby language.
I started working on that to use it with https://github.com/mcanevet/puppet-freebox.

The official documentation is located here: http://dev.freebox.fr/sdk/os/

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

### Creating the session object

```ruby
myApp = {
  :app_id      => 'fr.freebox.testapp',
  :app_version => '0.0.7',
  :app_token   => 'dyNYgfK0Ya6FWGqq83sBHa7TwzWo+pg4fDFUJHShcjVYzTfaRrZzm93p7OTAfH/0',
}
mySession = FreeboxApi::Session.new(myApp, myFreebox)
```

or

```ruby
mySession = FreeboxApi::Session.new({
  :app_id      => 'fr.freebox.testapp',
  :app_version => '0.0.7',
  :app_token   => 'dyNYgfK0Ya6FWGqq83sBHa7TwzWo+pg4fDFUJHShcjVYzTfaRrZzm93p7OTAfH/0',
}, FreeboxApi::Freebox.new)
```

Reference
---------

### Configuration

#### Connection

##### Get the current Connection status

```ruby
FreeboxApi::Configuration::Connection.getStatus(mySession)
```

##### Get the current Connection configuration

```ruby
FreeboxApi::Configuration::Connection.getConfig(mySession)
```

##### Update the Connection configuration

```ruby
FreeboxApi::Configuration::Connection.updateConfig(mySession, {
  :ping => true,
  :wol  => false,
})
```

##### IPv6

###### Get the current IPv6 Connection configuration

```ruby
FreeboxApi::Configuration::Connection::IPv6.getConfig(mySession)
```

###### Update the IPv6 Connection configuration

```ruby
FreeboxApi::Configuration::Connection::IPv6.updateConfig(mySession, {
  :delegations => [
    {
     :prefix   => '2a01:e30:d252:a2a2::/64',
     :next_hop => 'fe80::be30:5bff:feb5:fcc7',
    }
  ]
})
```

##### Connection DynDNS status

###### Get the status of a DynDNS service

```ruby
FreeboxApi::Configuration::Connection::DDNS.getStatus(mySession, 'dyndns')
```

or

```ruby
ddns = FreeboxApi::Configuration::Connection::DDNS.new(mySession, 'dyndns')
ddns.status
```

###### Get the config of a DynDNS service

```ruby
FreeboxApi::Configuration::Connection::DDNS.getConfig(mySession, 'dyndns')
```

or

```ruby
ddns = FreeboxApi::Configuration::Connection::DDNS.new(mySession, 'dyndns')
ddns.config
```

##### Set the config of a DynDNS service

```ruby
FreeboxApi::Configuration::Connection::DDNS.updateConfig(mySession, 'dyndns', {
  :enabled  => false,
  :user     => 'test',
  :password => 'ssss',
  :hostname => 'ttt',
})
```

or

```ruby
ddns = FreeboxApi::Configuration::Connection::DDNS.new(mySession, 'dyndns')
ddns.config = {
  :enabled  => false,
  :user     => 'test',
  :password => 'ssss',
  :hostname => 'ttt',
}
```

#### Lan

##### Get the current Lan configuration

```ruby
FreeboxApi::Configuration::Lan.getConfig(mySession)
```

##### Update the current Lan configuration

```ruby
FreeboxApi::Configuration::Lan.updateConfig({
  :mode         => 'router',
  :ip           => '192.168.69.254',
  :name         => 'Freebox de r0ro',
  :name_dns     => 'freebox-de-r0ro',
  :name_mdns    => 'Freebox-de-r0ro',
  :name_netbios => 'Freebox_de_r0ro',
})
```

##### Lan Browser

###### Getting the list of browsable LAN interfaces

```ruby
FreeboxApi::Configuration::Lan::Browser.interfaces(mySession)
```

##### Getting the list of hosts on a given interface

```ruby
FreeboxApi::Configuration::Lan::Browser::Interface.getLanHosts(mySession, 'pub')
```

```ruby
interface = FreeboxApi::Configuration::Lan::Browser::Interface.new(mySession, 'pub')
interface.lan_hosts
```

##### Getting an host information

```ruby
FreeboxApi::Configuration::Lan::Browser::LanHost.show(mySession, 'pub', 'ether-00:24:d4:7e:00:4c')
```

or

```ruby
lan_host = FreeboxApi::Configuration::Lan::Browser::LanHost.new(mySession, 'pub', 'ether-00:24:d4:7e:00:4c')
lan_host.show
```

##### Updating an host information

```ruby
FreeboxApi::Configuration::Lan::Browser::LanHost.update(mySession, 'pub', 'ether-00:24:d4:7e:00:4c', {
  :id           => 'ether-00:24:d4:7e:00:4c',
  :primary_name => 'Freebox Tv',
})
```

or

```ruby
lan_host = FreeboxApi::Configuration::Lan::Browser::LanHost.new(mySession, 'pub', 'ether-00:24:d4:7e:00:4c')
lan_host.update({
  :id           => 'ether-00:24:d4:7e:00:4c',
  :primary_name => 'Freebox Tv',
})
```

#### Wake on LAN

##### Send Wake ok Lan packet to an host

```ruby
FreeboxApi::Configuration::Lan::Browser::Interface.wol(mySession, 'pub', {
  :mac      => '00:24:d4:7e:00:4c',
  :password => '',
}
```

or

```ruby
interface = FreeboxApi::Configuration::Lan::Browser::Interface.new(mySession, 'pub')
interface.wol({
  :mac      => '00:24:d4:7e:00:4c',
  :password => '',
}
```

or

```ruby
lan_host = FreeboxApi::Configuration::Lan::Browser::LanHost.new(mySession, 'pub', 'ether-00:24:d4:7e:00:4c')
lan_host.wol({ :password => '' })
```

#### Freeplug

##### Get the current Freeplugs networks

```ruby
FreeboxApi::Configuration::Freeplug.network(mySession)
```

##### Get a particular Freeplug information

```ruby
FreeboxApi::Configuration::Freeplug.show(mySession, 'F4:CA:E5:1D:46:AE')
```

or

```ruby
freeplug = FreeboxApi::Configuration::Freeplug.new(mySession, 'F4:CA:E5:1D:46:AE')
freeplug.show
```

##### Reset a Freeplug

```ruby
FreeboxApi::Configuration::Freeplug.reset(mySession, 'F4:CA:E5:1D:46:AE')
```

or

```ruby
freeplug = FreeboxApi::Configuration::Freeplug.new(mySession, 'F4:CA:E5:1D:46:AE')
freeplug.reset
```

#### DHCP

##### Get the current DHCP configuration

```ruby
FreeboxApi::Configuration::Dhcp.getConfig(mySession)
```

##### Update the current DHCP configuration

```ruby
FreeboxApi::Configuration::Dhcp.updateConfig(mySession, {
  :enabled => false,
})
```

##### Get the list of DHCP static leases

```ruby
FreeboxApi::Configuration::Dhcp.static_leases(mySession)
```

##### Get a given DHCP static lease

```ruby
FreeboxApi::Configuration::Dhcp::StaticLease.show(mySession, '00:DE:AD:B0:0B:55')
```

or

```ruby
static_lease = FreeboxApi::Configuration::Dhcp::StaticLease.new(mySession, '00:DE:AD:B0:0B:55')
static_lease.show
```

##### Update DHCP static lease

```ruby
FreeboxApi::Configuration::Dhcp::StaticLease.update(mySession, {
  :id      => '00:DE:AD:B0:0B:55',
  :comment => 'Mon PC',
})
```

or

```ruby
static_lease = FreeboxApi::Configuration::Dhcp::StaticLease.new(mySession, '00:DE:AD:B0:0B:55')
static_lease.update({
  :id      => '00:DE:AD:B0:0B:55',
  :comment => 'Mon PC',
})
```

##### Delete a DHCP static lease

```ruby
FreeboxApi::Configuration::Dhcp::StaticLease.delete(mySession, '00:DE:AD:B0:0B:55')
```

or

```ruby
static_lease = FreeboxApi::Configuration::Dhcp::StaticLease.new(mySession, '00:DE:AD:B0:0B:55')
static_lease.delete
```

##### Add a DHCP static lease

```ruby
FreeboxApi::Configuration::Dhcp::StaticLease.create(mySession, {
  :ip  => '192.168.1.222',
  :mac => '00:00:00:11:11:11',
})
```

or

```ruby
static_lease = FreeboxApi::Configuration::Dhcp::StaticLease.new(mySession, '00:00:00:11:11:11')
static_lease.create({
  :ip  => '192.168.1.222',
  :mac => '00:00:00:11:11:11',
})
```

##### Get the list of DHCP dynamic leases

```ruby
FreeboxApi::Configuration::Dhcp.dynamic_leases(mySession)
```
