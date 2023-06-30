use wallets;
BEGIN;
SELECT balance FROM accounts WHERE username = 'A' LOCK IN SHARE MODE;
SELECT balance FROM accounts WHERE username = 'A' FOR SHARE;
COMMIT;