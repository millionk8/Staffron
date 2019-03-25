User.seed(:id,
   { id: 1, email: 'jeffrey.atto@concise.com', password: 'password', confirmed_at: Time.current, master: true, admin: true, company_id: 1, locale: 'en_US' },
   { id: 2, email: 'bartoszhejman@gmail.com', password: 'password', confirmed_at: Time.current, master: true, admin: true, company_id: 2, locale: 'en_US' },
   { id: 3, email: 'master@kriskhoury.com', password: 'password', confirmed_at: Time.current, master: true, admin: true, company_id: 1, locale: 'en_US' },
   { id: 4, email: 'admin@kriskhoury.com', password: 'password', confirmed_at: Time.current, master: false, admin: true, company_id: 1, locale: 'en_US' },
   { id: 5, email: 'employee@kriskhoury.com', password: 'password', confirmed_at: Time.current, master: false, admin: false, company_id: 1, locale: 'en_US' },
)

Profile.seed(:id,
   { id: 1, user_id: 1, first_name: 'Jeffrey', last_name: 'Atto' },
   { id: 2, user_id: 2, first_name: 'Bartosz', last_name: 'Hejman' },
   { id: 3, user_id: 3, first_name: 'Master', last_name: 'Concise'},
   { id: 4, user_id: 4, first_name: 'Admin', last_name: 'Concise' },
   { id: 5, user_id: 5, first_name: 'Employee', last_name: 'Concise' },
)