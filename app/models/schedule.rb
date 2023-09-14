# TODO: add validation which doesn't allow creating a working day longer that 8 hours, for example
class Schedule < ApplicationRecord
  belongs_to :specialist

  enum week_day: {
    mon: 1,
    tue: 2,
    wed: 3,
    thu: 4,
    fri: 5,
    sat: 6,
    sun: 7,
  }
end
