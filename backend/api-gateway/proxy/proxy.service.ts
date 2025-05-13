import { Injectable, Logger } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';

import { lastValueFrom } from 'rxjs';

@Injectable()
export class ProxyService {
  constructor(private readonly httpService: HttpService) {}

  async forwardRequest(
    url: string,
    method: string,
    body: any,
    headers: any,
  ): Promise<any> {
    const config = {
      method,
      url,
      data: body,
      headers,
    };

    try {
      const response = await lastValueFrom(this.httpService.request(config));
      return response.data;
    } catch (error) {
      throw error.response?.data || error;
    }
  }
}
