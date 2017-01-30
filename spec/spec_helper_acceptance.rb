require 'beaker-rspec'

install_puppet_agent_on(hosts, {
  :puppet_agent_version => ENV.key?('PUPPET_AGENT') ? ENV['PUPPET_AGENT'] : '1.4.1'
})

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.color     = true
  c.formatter = :documentation

  c.before :suite do
    hosts.each do |host|
      copy_module_to(host, :source => proj_root, :module_name => 'cron')
      on host, puppet('module','install','puppetlabs-stdlib')
    end
  end
end