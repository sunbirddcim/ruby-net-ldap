require_relative '../test_helper'

# NOTE: These tests depend on the OpenLDAP retcode overlay.
# See: section 12.12 http://www.openldap.org/doc/admin24/overlays.html

class TestReturnCodeIntegration < LDAPIntegrationTestCase
  def test_operations_error
    refute @ldap.search(filter: "cn=operationsError", base: "ou=Retcodes,dc=rubyldap,dc=com")
    assert result = @ldap.get_operation_result

    assert_equal 1, result.code
    assert_equal Net::LDAP::ResultStrings[1], result.message
  end

  def test_protocol_error
    refute @ldap.search(filter: "cn=protocolError", base: "ou=Retcodes,dc=rubyldap,dc=com")
    assert result = @ldap.get_operation_result

    assert_equal 2, result.code
    assert_equal Net::LDAP::ResultStrings[2], result.message
  end

  def test_time_limit_exceeded
    refute @ldap.search(filter: "cn=timeLimitExceeded", base: "ou=Retcodes,dc=rubyldap,dc=com")
    assert result = @ldap.get_operation_result

    assert_equal 3, result.code
    assert_equal Net::LDAP::ResultStrings[3], result.message
  end

  def test_size_limit_exceeded
    refute @ldap.search(filter: "cn=sizeLimitExceeded", base: "ou=Retcodes,dc=rubyldap,dc=com")
    assert result = @ldap.get_operation_result

    assert_equal 4, result.code
    assert_equal Net::LDAP::ResultStrings[4], result.message
  end
end
