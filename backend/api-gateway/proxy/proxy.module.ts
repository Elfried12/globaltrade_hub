import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { HttpModule } from '@nestjs/axios';
import { ProxyService } from './proxy.service';

@Module({
  imports: [
    HttpModule,
    ConfigModule,               // pour accéder aux URLs depuis le .env
    HttpModule.register({ timeout: 5000 }),],
  providers: [ProxyService],
  exports: [ProxyService],
})
export class ProxyModule {}
