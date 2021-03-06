require 'spec_helper'

describe Railsyard::Backend::Config::List do

  it "lets you add fields, and get them back via .field and .fields" do
    field = stub(:name => :foo)
    subject.add_field(field)
    subject.fields.should have(1).field
    subject.fields.first.should == field
    subject.field(:foo).should == field
  end


  %w(sorting_type sorting_attribute).each do |attr|
    it "let get and set :#{attr} attribute" do
      subject.send("#{attr}=", :foo)
      subject.send(attr).should == :foo
    end
  end

end
