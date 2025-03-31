import { execSync } from "child_process";
import * as fs from "fs";

const services = JSON.parse(fs.readFileSync("start-services.json", "utf-8")).services;

for (const service of services) {
  console.log(`🚀 Initialisation de ${service.name}...`);

  try {
    execSync("npm install", { cwd: service.path, stdio: "inherit" });
    execSync("npm prisma generate", { cwd: service.path, stdio: "inherit" });
    execSync("npm prisma migrate dev --name init --skip-seed", { cwd: service.path, stdio: "inherit" });
    console.log(`✅ ${service.name} prêt.\n`);
  } catch (err) {
    console.error(`❌ Échec pour ${service.name}.\n`, err);
  }
}
