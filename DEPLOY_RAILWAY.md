# Deploy Resume-Sphere Backend to Railway

## 1) Create a Railway project
1. Push this repository to GitHub.
2. In Railway, click **New Project** → **Deploy from GitHub repo**.
3. Select this repository.

Railway will use the repository `Dockerfile` to build and start the ASP.NET Core API.

## 2) Add a PostgreSQL database
1. In the same Railway project, click **New** → **Database** → **PostgreSQL**.
2. Open the PostgreSQL service and copy the connection string.

## 3) Configure required environment variables
In the API service (**Variables** tab), add:

- `ASPNETCORE_ENVIRONMENT=Production`
- `ConnectionStrings__DefaultConnection=<your-railway-postgres-connection-string>`
- `AppSettings__Token=<a strong random JWT secret>`
- `AiService__BaseUrl=<your ai-service base url>`

If OTP emails are enabled, also add:
- `EmailConfiguration__SmtpServer`
- `EmailConfiguration__Port`
- `EmailConfiguration__SenderEmail`
- `EmailConfiguration__SenderPassword`
- `EmailConfiguration__SenderName`

## 4) Deploy
Railway will trigger deployment automatically after variables are saved (or after a new push).

## 5) Verify
- Open the deployed URL from Railway.
- Open any known API endpoint (for example an auth or jobs route) and confirm you get an HTTP response instead of connection errors.

## Notes
- The container startup command binds Kestrel to `0.0.0.0:${PORT}` automatically (fallback: `8080`).
- On startup, the API automatically applies pending EF Core migrations in non-development environments.
- Keep production secrets in Railway variables, not in `appsettings.json`.
