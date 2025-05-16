import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  @Get()
  getHealth() {
    return { status: 'Suppliers service is up' };
  }
}
