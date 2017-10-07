require 'serverspec'

# Required by serverspec
set :backend, :exec

describe 'Basic dnsmasq' do
  describe package('dnsmasq') do
    it { should be_installed }
  end
  
  describe service('dnsmasq') do
    it { should be_enabled }
    it { should be_running.under('systemd') }
  end
end
