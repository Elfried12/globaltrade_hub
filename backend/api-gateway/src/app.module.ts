import { Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ProxyModule } from './proxy/proxy.module';

@Module({
  imports: [HttpModule, ProxyModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
