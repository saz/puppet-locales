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
          debian_legacy_location = '/etc/default/locale'
          debian_new_location = '/etc/locale.conf'
          case facts[:os]['name'].downcase
          when 'debian'
            default_file = if Gem::Version.new(facts[:os]['release']['major']) > Gem::Version.new('12')
                             debian_new_location
                           else
                             debian_legacy_location
                           end
          when 'ubuntu'
            default_file = if Gem::Version.new(facts[:os]['release']['full']) >= Gem::Version.new('24.04')
                             debian_new_location
                           else
                             debian_legacy_location
                           end
          end
        when 'sles', 'suse'
          default_file = '/etc/sysconfig/language'
        else
          default_file = '/etc/locale.conf'
        end

        it do
          is_expected.to contain_file(default_file).with(
            'ensure' => 'file',
            'owner' => 'root',
            'group' => 0,
            'mode' => '0644'
          )
        end

        if os =~ (%r{^(debian|ubuntu)})
          if default_file == debian_legacy_location
            it do
              is_expected.to contain_file(debian_new_location).with(
                'ensure' => 'absent'
              )
            end
          else
            it do
              is_expected.to contain_file(debian_legacy_location).with(
                'ensure' => 'present',
                'target' => '../locale.conf'
              )
            end
          end
        end
      end
    end
  end
end
