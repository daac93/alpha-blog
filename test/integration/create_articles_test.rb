require "test_helper"

class CreateArticlesTest < ActionDispatch::IntegrationTest
   
    def setup
        @user = User.create(username: "test", email: "test@test.com", password: "password")
    end
    
    test "should create a new article" do
        sign_in_as(@user, "password")
        get new_article_path
        assert_template 'articles/new'
        assert_difference 'Article.count', 1 do
            post_via_redirect articles_path, article: {title: "test", description: "integration test article"}
        end
        assert_template 'articles/show'
        assert_match "integration test article", response.body
        assert_select 'div.alert-success'
    end
    
    test "invalid article submission results in failure" do
        sign_in_as(@user, "password")
        get new_article_path
        assert_template 'articles/new'
        assert_no_difference 'Article.count' do
            post_via_redirect articles_path, article: {title: "", description: ""}
        end
        assert_template 'articles/new'
        assert_select 'div.panel-danger'
    end
end