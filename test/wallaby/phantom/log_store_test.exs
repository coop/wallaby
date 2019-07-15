defmodule Wallaby.Driver.LogStoreTest do
  use ExUnit.Case, async: true

  alias Wallaby.Driver.LogStore

  @l1 %{"level" => "INFO", "message" => "l1 (:)", "timestamp" => 1470795015152}
  @l2 %{"level" => "INFO", "message" => "l2 (:)", "timestamp" => 1470795015290}
  @l3 %{"level" => "WARNING", "message" => "l3 (:)", "timestamp" => 1470795015345}

  @session "123abc"

  setup do
    Agent.update(LogStore, fn _ -> Map.new end)
  end

  describe "append_logs/2" do
    test "only appends new logs" do
      assert LogStore.append_logs(@session, [@l1, @l2]) == [@l1, @l2]
      assert LogStore.append_logs(@session, [@l2, @l3]) == [@l3]
      assert LogStore.get_logs(@session) == [@l1, @l2, @l3]
    end

    test "wraps logs in a list if they are not already in one" do
      assert LogStore.append_logs(@session, [@l1, @l2]) == [@l1, @l2]
      assert LogStore.append_logs(@session, @l3) == [@l3]
      assert LogStore.get_logs(@session) == [@l1, @l2, @l3]
    end
  end
end
