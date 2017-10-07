require 'serverspec'

# Required by serverspec
set :backend, :exec

describe 'Custom dnsmasq' do

  describe package('dnsmasq') do
    it { should be_installed }
  end
  
  describe file('/etc/dnsmasq.d/hypervisior.conf') do
      it { should be_file }
      it { should be_mode 644 }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      its(:content) { should contain '# My Hypervisior Booter' }
      its(:content) { should contain 'interface=eth0' }
      its(:content) { should contain '# KILL IPMI' }
      its(:content) { should contain 'dhcp-ignore=ipmi' }
      its(:content) { should contain '# For the initial boot, we match by MAC' }
      its(:content) { should contain 'dhcp-boot=net:pxe,pxelinux.0' }
      its(:content) { should contain '# Make sure we ignore examples' }
      its(:content) { should contain 'dhcp-ignore=examples' }
  end

  describe service('dnsmasq') do
    it { should be_enabled }
    it { should be_running.under('systemd') }
  end

end
