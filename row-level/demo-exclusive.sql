use wallets;

BEGIN;
SELECT balance FROM accounts WHERE username = 'A' FOR UPDATE;
COMMIT;