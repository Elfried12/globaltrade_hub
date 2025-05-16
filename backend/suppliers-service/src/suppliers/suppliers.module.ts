import { Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { ConfigModule } from '@nestjs/config';
import { SuppliersService } from './suppliers.service';
import { SuppliersController } from './suppliers.controller';
import { PrismaClient } from '@prisma/client';

@Module({
  imports: [
    HttpModule.register({ timeout: 5000 }), // pour forwarder les requêtes
    ConfigModule,                          // lit les variables d'env. pour les URLs
  ],
  controllers: [SuppliersController],
  providers: [SuppliersService, PrismaClient],
})
export class SuppliersModule {}