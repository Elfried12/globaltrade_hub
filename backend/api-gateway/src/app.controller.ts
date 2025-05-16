// app.controller.ts
import { Controller, All, Req, Res, Param, Body, Query } from '@nestjs/common';
import { Request, Response } from 'express';
import { ProxyService } from '../proxy/proxy.service';

@Controller('api/:service')
export class AppController {
  constructor(private readonly proxyService: ProxyService) {}

  @All('*path')
  async handleAll(
    @Param('service') service: string,
    @Req() req: Request,
    @Res() res: Response,
    @Query() query: any,
    @Body() body: any
  ) {
    const path = req.url.replace(/^\//, '');
    try {
      const result = await this.proxyService.forward(
        service,
        path,
        req.method,
        body,
        req.headers
      );
      res.json(result);
    } catch (error) {
      res.status(error.status || 500).json(error.response || { message: 'Unexpected error' });
    }
  }
}
