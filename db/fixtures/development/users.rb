User.seed(:id,
   { id: 1, password: '0umah12QW', confirmed_at: Time.current, master: true, admin: true, company_id: 1, locale: 'en_US', policy_accepted_at: nil },
   { id: 2, email: 'admin@kriskhoury.com', password: 'password', confirmed_at: Time.current, master: false, admin: true, company_id: 1, locale: 'en_US', policy_accepted_at: nil },
   { id: 3, email: 'manager@kriskhoury.com', password: 'password', confirmed_at: Time.current, master: false, admin: false, company_id: 1, locale: 'en_US', policy_accepted_at: nil },
   { id: 4, email: 'employee@kriskhoury.com', password: 'password', confirmed_at: Time.current, master: false, admin: false, company_id: 1, locale: 'en_US', policy_accepted_at: nil },
   { id: 5, email: 'office@kriskhoury.com', password: 'password', confirmed_at: Time.current, master: false, admin: false, company_id: 1, locale: 'en_US', policy_accepted_at: nil },
   { id: 6, email: 'employee2@kriskhoury.com', password: 'password', confirmed_at: Time.current, master: false, admin: false, company_id: 1, locale: 'en_US', policy_accepted_at: nil },
)