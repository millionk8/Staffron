module TimeoffRules
  #days
  PART_TIME = { pto: 5, sickness: 3 }
  FT_LT_1_YR = { pto: 7, sickness: 6 }
  FT_GTE_1_LT_3_YR = { pto: 14, sickness: 8 }
  FT_GTE_3_YR = { pto: 21, sickness: 10 }
end