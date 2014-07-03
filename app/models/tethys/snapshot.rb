module Tethys
  class Snapshot < ActiveRecord::Base
    belongs_to :aggregate

    def root_snapshot= root
      self.data = Oj.dump root
    end

    def root_snapshot
      Oj.load data
    end
  end
end
