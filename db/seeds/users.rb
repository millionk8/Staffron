User.seed(:id,
   { id: 2, email: 'admin@kriskhoury.com', password: 'password', confirmed_at: Time.current, master: false, admin: true, company_id: 1, locale: 'en_US' },
   { id: 3, email: 'manager@kriskhoury.com', password: 'password', confirmed_at: Time.current, master: false, admin: false, company_id: 1, locale: 'en_US' },
   { id: 4, email: 'employee@kriskhoury.com', password: 'password', confirmed_at: Time.current, master: false, admin: false, company_id: 1, locale: 'en_US' },
   { id: 5, email: 'office@kriskhoury.com', password: 'password', confirmed_at: Time.current, master: false, admin: false, company_id: 1, locale: 'en_US' },
)