1. use factorybot (with databasaecleaner)

2. use contexts to setup once, and gradually add setup steps with every new context

3. Ultimately use contexts with FactoryBot

# Note that `let` and `before` comes from RSpec

context "A user" do
  let(:user) { create(:user) }

  it "..." do
    # ...
  end

  context "with a post" do
    let(:post) { create(:post, user: user) }

    it "..." do
      # ...
    end

  end

  context "with admin privileges" do
    before do
      user.update_attributes(admin: true)
    end

    it "..." do
      # ...
    end
  end
end
