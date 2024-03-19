SELECT
audit_option,
CASE WHEN user_name IS NOT NULL
THEN user_name
ELSE 'ALL USERS'
END AS username
FROM dba_stmt_audit_opts
ORDER BY audit_option, user_name;

