# frozen_string_literal: true

require 'spec_helper'

describe 'locales' do
  let :node do
    'rspec.puppet.com'
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      describe 'with all defaults' do
        it { is_expected.to compile.with_all_deps }

        case facts[:os]['family'].downcase
        when 'debian'
          case facts[:os]['name'].downcase
          when 'debian'
            default_file = if Gem::Version.new(facts[:os]['release']['major']) > Gem::Version.new('12')
                             '/etc/locale.conf'
                           else
                             '/etc/default/locale'
                           end
          when 'ubuntu'
            default_file = if Gem::Version.new(facts[:os]['release']['full']) >= Gem::Version.new('24.04')
                             '/etc/locale.conf'
                           else
                             '/etc/default/locale'
                           end
          end
        when 'sles', 'suse'
          default_file = '/etc/sysconfig/language'
        else
          default_file = '/etc/locale.conf'
        end

        it do
          is_expected.to contain_file(default_file).with(
            'ensure' => 'present',
            'owner' => 'root',
            'group' => 0,
            'mode' => '0644'
          )
        end

        if os =~ (%r{^(debian|ubuntu)}) && (default_file != '/etc/default/locale')
          it do
            is_expected.to contain_file(default_file).with(
              'ensure' => 'present',
              'target' => '/etc/locale.conf'
            )
          end
        end
      end
    end
  end
end
