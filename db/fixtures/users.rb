User.seed(:id,
   { id: 1, email: 'jeffrey.atto@concise.com', password: 'password', confirmed_at: Time.current, master: true, admin: true, company_id: 1, locale: 'en_US' },
   { id: 2, email: 'bartoszhejman@gmail.com', password: 'password', confirmed_at: Time.current, master: true, admin: true, company_id: 2, locale: 'en_US' },
)