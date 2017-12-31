RSpec::Matchers.define :violate_check_constraint do |constraint_name| # define matcher and its name
  supports_block_expectations # included because of block syntax (execute code now)
  match do |code_to_test| # pass the code in block (user.update_attr....). 'match' takes a block and evalutes it to true or false
    begin
      code_to_test.() # actually execute the code in block
      false # if the code pass, test fail, since exception StatementInvalid is expected to raise
    rescue ActiveRecord::StatementInvalid => ex # this exception is expected to pass the test
      ex.message =~ /#{constraint_name}/ # test passes if constraint_name is the one we expected (in this case email_must_be_company_email)
    end
  end
end
