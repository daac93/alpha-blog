require "test_helper"

class SignupUsersTest < ActionDispatch::IntegrationTest
   
    def setup
        #@user = User.create(username: "test", email: "test@test.com", password: "password", admin: true )
    end
    
    test "should sign up an user" do
        get signup_path
        assert_template 'users/new'
        assert_difference 'User.count', 1 do
            post_via_redirect users_path, user: {username: "test", email: "test@test.com", password: "password", admin: true}
        end
        assert_template 'users/show'
        assert_match "test", response.body
        assert_select 'div.alert-success'
    end
end