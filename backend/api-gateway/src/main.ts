import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import { JwtMiddleware } from '../common/jwt.middleware';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.use(new JwtMiddleware().use);
  app.setGlobalPrefix('api');     // ==> tous vos endpoints commencent par /api
  app.useGlobalPipes(new ValidationPipe({
    whitelist: true,
    forbidNonWhitelisted: true,
  }));
  app.enableCors(); // à ajuster en production
  await app.listen(3000);
}
bootstrap();
