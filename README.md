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


OLD API
=======


### Ftp

#### Ftp config API

##### Get the current Ftp configuration
[X] GET /api/v1/ftp/config/

```ruby
config.show('ftp')
```

##### Update the FTP configuration
[X] PUT /api/v1/ftp/config/

```ruby
config.update('ftp', {
  :enabled => true
})
```

### NAT

#### Dmz Config API

##### Get the current Dmz configuration
[X] GET /api/v1/fw/dmz/

```ruby
config.show('dmz')
```

##### Update the current Dmz configuration
[X] PUT /api/v1/fw/dmz/

```ruby
config.update('dmz', {
  :enabled => true,
  :ip      => '192.168.1.42',
})
```

### Port Forwarding

#### Port Forwarding API

##### Getting the list of port forwarding
[X] GET /api/v1/fw/redir/

```ruby
port_forwardings = FreeboxApi::Resources::PortForwarding.new(mySession)
port_forwardings.index
```

##### Getting a specific port forwarding
[X] GET /api/v1/fw/redir/{redir\_id}

```ruby
port_forwardings.show(1)
```

##### Updating a port forwarding
[X] PUT /api/v1/fw/redir/{redir\_id}

```ruby
port_forwardings.update({
  :id      => 1,
  :enabled => false,
})
```

##### Add a port forwarding
[X] POST /api/v1/fw/redir/

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

##### Delete a port forwarding
[X] DELETE /api/v1/fw/redir/{redir\_id}

```ruby
port_forwardings.destroy(3)
```

### UPnP IGD

#### UPnP IGD config API

##### Get the current UPnP IGD configuration
[X] GET /api/v1/upnpigd/config/

```ruby
config.show('upnpigd')
```

##### Update the UPnP IGD configuration
[X] PUT /api/v1/upnpigd/config/

```ruby
config.update('upnpigd', {
  :enabled => true,
})
```

#### UPnP IGD Redirection API

##### Get the list of current redirection
[X] GET /api/v1/upnpigd/redir/

```ruby
upnp_redir = FreeboxApi::Resources::UPnPRedir.new(mySession)
upnp_redir.index
```

##### Delete a redirection
[X] DELETE /api/v1/upnpigd/redir/{id}

```ruby
upnp_redir.destroy('0.0.0.0-53644-udp')
```

### LCD

#### LCD config API

##### Get the current LCD configuration
[X] GET /api/v1/lcd/config/

```ruby
config.show('lcd')
```

##### Update the lcd configuration
[X] PUT /api/v1/lcd/config/

```ruby
config.update('lcd', {
  :brightness => 50,
})
```

### Network Share

#### Samba config API

##### Get the current Samba configuration
[X] GET /api/v1/netshare/samba/

```ruby
config.show('samba')
```

##### Update the Samba configuration
[X] PUT /api/v1/netshare/samba/

```ruby
config.update('samba', {
  :print_share_enabled => false,
})
```

#### Afp config API

##### Get the current Afp configuration
[X] GET /api/v1/netshare/afp/

```ruby
config.show('afp')
```

##### Update the Afp configuration
[X] PUT /api/v1/netshare/afp/

```ruby
config.update('afp', {
  :guest_allow => false,
})
```

### UPnP AV

#### UPnP AV config API

##### Get the current UPnP AV configuration
[X] GET /api/v1/upnpav/config/

```ruby
config.show('upnpav')
```

##### Update the UPnP AV configuration
[X] PUT /api/v1/upnpav/config/

```ruby
config.update('upnpav', {
  :enabled => false,
})
```

### Switch

#### Switch API

##### Get the current switch status
[ ] GET /api/v1/switch/status/

##### Get a port configuration
[ ] GET /api/v1/switch/port/{id}

##### Update a port configuration
[ ] PUT /api/v1/switch/port/{id}

##### Get a port stats
[ ] GET /api/v1/switch/port/{id}/stats

### Wi-Fi

#### Wi-Fi Status API

##### Get the current Wi-Fi status
[ ] GET /api/v1/wifi/

#### Wi-Fi config API

##### Get the current Wi-Fi configuration
[X] GET /api/v1/wifi/config/

```ruby
config.show('wifi')
```

##### Update the Wi-Fi configuration
[X] PUT /api/v1/wifi/config/

```ruby
config.update('wifi', {
  :ap_params => {
    :ht_mode => 'disabled',
  }
})
```

##### Reset the Wi-Fi configuration
[ ] POST /api/v1/wifi/config/reset/

#### Wi-Fi Stations API

##### Get Wi-Fi Stations List
[ ] GET /api/v1/wifi/stations/{bss\_name}/

#### Wi-Fi MAC Filter API

##### Get the MAC filter list
[ ] GET /api/v1/wifi/mac\_filter/

##### Getting a particular MAC filter
[ ] GET /api/v1/wifi/mac\_filter/{filter\_id}

##### Updating a MAC filter
[ ] PUT /api/v1/wifi/mac\_filter/{filter\_id}

##### Delete a MAC filter
[ ] DELETE /api/v1/wifi/mac\_filter/{filter\_id}

##### Create a new MAC filter
[ ] POST /api/v1/wifi/mac\_filter/
