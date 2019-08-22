UserMembership.seed(:id,
   { id: 1, user_id: 1, company_id: 1, app_id: 1, role_id: 1, invitation_email: 'master@kriskhoury.com', invitation_token: '12345', invitation_accepted_at: Time.current },
   { id: 2, user_id: 2, company_id: 1, app_id: 1, role_id: 1, invitation_email: 'admin@kriskhoury.com', invitation_token: '23456', invitation_accepted_at: Time.current },
   { id: 3, user_id: 3, company_id: 1, app_id: 1, role_id: 1, invitation_email: 'manager@kriskhoury.com', invitation_token: '34567', invitation_accepted_at: Time.current },
   { id: 4, user_id: 4, company_id: 1, app_id: 1, role_id: 2, invitation_email: 'employee@kriskhoury.com', invitation_token: '45678', invitation_accepted_at: Time.current },
   { id: 5, user_id: 5, company_id: 1, app_id: 1, role_id: 3, invitation_email: 'office@kriskhoury.com', invitation_token: '56789', invitation_accepted_at: Time.current },
   { id: 6, user_id: 6, company_id: 1, app_id: 1, role_id: 2, invitation_email: 'employee2@kriskhoury.com', invitation_token: '45678', invitation_accepted_at: Time.current },
)