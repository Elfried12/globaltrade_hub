import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.setGlobalPrefix('suppliers');
  await app.listen(process.env.PORT ?? 3014);
  console.log('🚀 Suppliers service running on http://localhost:3014/suppliers');
}
bootstrap();
