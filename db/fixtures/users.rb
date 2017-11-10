User.seed_once(:id,
   { id: 1, email: 'test@test.com', password: 'password', confirmed_at: Time.current, master: true, admin: true, company_id: 1, locale: 'en_US' },
)