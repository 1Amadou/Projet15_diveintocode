require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "Validation" do
    it "adds an error when Title is not provided" do
      task = Task.new(title: nil, description: "test", status: :todo, deadline: Time.current)
      task.valid?
      expect(task.errors[:title]).to include("can't be blank")
    end

    it "adds an error when Status is not provided" do
      task = Task.new(title: "test", description: "test", status: nil, deadline: Time.current)
      task.valid?
      expect(task.errors[:status]).to include("can't be blank")
    end

    it "adds an error when Deadline is not provided" do
      task = Task.new(title: "test", description: "test", status: :todo, deadline: nil)
      task.valid?
      expect(task.errors[:deadline]).to include("can't be blank")
    end

    it "adds an error when Deadline is in the past" do
      task = Task.new(title: "test", description: "test", status: :todo, deadline: 1.day.ago)
      task.valid?
      expect(task.errors[:deadline]).to include("must start from today.")
    end

    it "does not add errors when all attributes are valid" do
      task = Task.new(title: "test", description: "test", status: :todo, deadline: Time.current)
      expect(task).to be_valid
    end

    it "adds an error when Deadline is in the past" do
      task = Task.new(title: "test", description: "test", status: :todo, deadline: 1.day.ago)
      task.valid?
      expect(task.errors[:deadline]).to include("must start from today.")
    end
  end
end
