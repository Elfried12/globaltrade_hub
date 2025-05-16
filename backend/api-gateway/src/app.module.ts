import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { HttpModule } from '@nestjs/axios';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ProxyModule } from '../proxy/proxy.module';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }), // charge .env et rend ConfigService global
    HttpModule, 
    ProxyModule,
    HttpModule.register({ timeout: 5000 })
  ],// timeout global
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
