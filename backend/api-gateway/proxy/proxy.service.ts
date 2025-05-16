import { Injectable, HttpException,HttpStatus } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { firstValueFrom } from 'rxjs';
import { ConfigService } from '@nestjs/config';
//import type { AxiosResponse } from 'axios';
import { serviceMap } from './proxy.config';

@Injectable()
export class ProxyService { 
  services: { auth: any; users: any; products: any; contacts: any; transactions: any; logistics: any; notifications: any; admin: any; payments: any; marketplace: any; recommendation: any; douane: any; evaluations: any; suppliers:any; } = {
    auth: undefined,
    users: undefined,
    products: undefined,
    contacts: undefined,
    transactions: undefined,
    logistics: undefined,
    notifications: undefined,
    admin: undefined,
    payments: undefined,
    marketplace: undefined,
    recommendation: undefined,
    douane: undefined,
    evaluations: undefined,
    suppliers: undefined
  };

  constructor(
    private readonly http: HttpService,
    private readonly config: ConfigService,) {
      // mappe le nom « service » à son URL
    this.services = {
      auth: this.config.get('AUTH_SERVICE_URL'),
      users: this.config.get('USERS_SERVICE_URL'),
      products: this.config.get('PRODUCTS_SERVICE_URL'),
      contacts: this.config.get('CONTACTS_SERVICE_URL'),
      transactions: this.config.get('TRANSACTIONS_SERVICE_URL'),
      logistics:this.config.get('LOGISTICS_SERVICE_URL'),
      notifications: this.config.get('NOTIFICATIONS_SERVICE_URL'),
      admin: this.config.get('ADMIN_SERVICE_URL'),
      payments: this.config.get('PAYMENTS_SERVICE_URL'),
      marketplace: this.config.get('MARKETPLACE_SERVICE_URL'),
      recommendation: this.config.get('AI_RECOMMENDATION_SERVICE_URL'),
      douane: this.config.get('DOUANE_SERVICE_URL'),
      evaluations: this.config.get('EVALUATIONS_SERVICE_URL'),
      suppliers :this.config.get('SUPPLIERS_SERVICE_URL'),

    };
  }

  async forward(
    service: string,
    path: string,
    method: string,
    body: any,
    headers: Record<string, any>,
  ): Promise<any> {
    const baseUrl = this.services[service];
    if (!baseUrl) {
      throw new HttpException(`Service "${service}" not found`, 404);
    }

    try {
      const response = await firstValueFrom(
        this.http.request({
          method,
          url: `${baseUrl}/${path}`,
          data: body,
          headers,
        }),
      );
      return response.data;
    } catch (err: any) {
      throw new HttpException(
        err.response?.data || err.message,
        err.response?.status || HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }
}
