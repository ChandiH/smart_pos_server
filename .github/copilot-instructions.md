# Copilot instructions

## Architecture
- Entry point: `src/server.ts` (Express app, CORS, request logging, static `/static` + `/static/image`).
- HTTP flow: routes in `src/routes/*.routes.ts` → controllers in `src/controllers/*.controller.ts` → model helpers in `src/models/*.model.ts`.
- Data access: Prisma client wrapper in `src/config/prisma.ts`, schema in `prisma/schema.prisma`, generated client in `src/prisma` (import types like `product` from `"../prisma"`).
- Sales flow: `src/services/sales.service.ts` runs a Prisma transaction to insert sales + update inventory.
- Printing: `/print/raw` and `/print/receipt` in `src/controllers/printer.controller.ts` use ESC/POS payloads from `src/services/printer.service.ts` and receipt layout in `src/services/receipt.builder.ts`.
- Email reports: `/email/*` in `src/routes/emailScheduler.routes.ts` schedules node-cron jobs and persists time in `email_schedule.json`; reports use pg_dump via `DATABASE_URL` or Docker (`DATABASE_CONTAINER`).

## Workflows
- Dev server: `npm run dev` (tsx watch `src/server.ts`).
- Build/run: `npm run build` → `npm start` (uses `dist/server.js`).
- Typecheck/lint: `npm run typecheck`, `npm run lint` (see `eslint.config.mts`).
- Prisma: `npm run prisma:generate`, `npm run prisma:migrate`, `npm run prisma:reset` (requires `DATABASE_URL`).

## Conventions & patterns
- Auth: JWT token comes from `x-access-token` header (`src/middleware/authJWT.ts`); `SECRET_KEY` must be set.
- Response shape: controllers typically return `{ data }` on success and `{ error }` with 400/500 (keep that pattern when adding endpoints).
- File uploads: multer storage in `src/middleware/upload.ts` writes to `public/image`; product uses `upload.array("files")`, employee uses `upload.single("file")`.
- Printer payloads: `PrintPayload` schema in `printer.service.ts`; receipt builder handles Sinhala text by rasterizing it before printing.

## Configuration
- Env vars in `src/config/envs.ts`: `PORT`, `DATABASE_URL`, `DATABASE_CONTAINER`, `SECRET_KEY`, `PRINTER_HOST`, `PRINTER_SHARE_NAME`, `SCHEDULAR_EMAIL`, `EMAIL_PASSWORD`, `DEFAULT_RECEIVER_EMAIL`.
- Reports are written to `./reports` and the schedule is persisted in `email_schedule.json`.
