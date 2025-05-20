import { Injectable, NotFoundException,HttpException, HttpStatus, } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { firstValueFrom } from 'rxjs';
import { ConfigService } from '@nestjs/config';
import { PrismaClient, Supplier } from '@prisma/client';
import { CreateResponseDto } from './dto/respond-request.dto';
import { ValidateTransactionDto } from './dto/validate-transaction.dto';
import { CancelTransactionDto } from './dto/cancel-transaction.dto';
import { CreateSupplierDto } from './dto/create-supplier.dto';
import { UpdateSupplierDto } from './dto/update-supplier.dto';
import { SearchSuppliersDto } from './dto/search-suppliers.dto';

@Injectable()
export class SuppliersService {
  productsUrl: any;
  contactsUrl: string | undefined;
  transactionsUrl: string | undefined;
  constructor(
    private prisma: PrismaClient,
    private readonly http: HttpService,
    private readonly config: ConfigService,) {this.productsUrl =
      this.config.get<string>('PRODUCTS_SERVICE_URL');
    this.contactsUrl =
      this.config.get<string>('CONTACTS_SERVICE_URL');
    this.transactionsUrl =
      this.config.get<string>('TRANSACTIONS_SERVICE_URL');}

  async create(dto: CreateSupplierDto): Promise<Supplier> {
    return this.prisma.supplier.create({ data: dto });
  }

  /** 1. Crée un produit via products-service */
  async addProduct(supplierId: string, dto: any) {
    const url = `${this.productsUrl}/products`;
    try {
      const resp = await firstValueFrom(
        this.http.post(url, { ...dto, supplierId }),
      );
      return resp.data;
    } catch (e: any) {
      throw new HttpException(
        e.response?.data || 'Error forwarding addProduct',
        e.response?.status || HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }


  /** 2. Répond à une demande de contact via contacts-service */
  async respondToRequest(
    requestId: string,
    supplierId: string,
    dto: CreateResponseDto,
  ) {
    const url = `${this.contactsUrl}/contacts/${requestId}/response`;
    try {
      const resp = await firstValueFrom(
        this.http.post(url, { supplierId, ...dto }),
      );
      return resp.data;
    } catch (e: any) {
      throw new HttpException(
        e.response?.data || 'Error forwarding response',
        e.response?.status || HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }


  /** 3. Valide une transaction via transactions-service */
  async validateTransaction(
    transactionId: string,
    supplierId: string,
    dto: ValidateTransactionDto,
  ) {
    const url = `${this.transactionsUrl}/transactions/${transactionId}/validate`;
    try {
      const resp = await firstValueFrom(
        this.http.post(url, { supplierId, ...dto }),
      );
      return resp.data;
    } catch (e: any) {
      throw new HttpException(
        e.response?.data || 'Error forwarding validate',
        e.response?.status || HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  
  /** 4. Annule une transaction via transactions-service */
  async cancelTransaction(
    transactionId: string,
    supplierId: string,
    dto: CancelTransactionDto,
  ) {
    const url = `${this.transactionsUrl}/transactions/${transactionId}/cancel`;
    try {
      const resp = await firstValueFrom(
        this.http.post(url, { supplierId, ...dto }),
      );
      return resp.data;
    } catch (e: any) {
      throw new HttpException(
        e.response?.data || 'Error forwarding cancel',
        e.response?.status || HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }


  /** 5. Supprime un produit via products-service */
  async deleteProduct(productId: string, supplierId: string) {
    const url = `${this.productsUrl}/products/${productId}`;
    try {
      const resp = await firstValueFrom(
        this.http.delete(url, { data: { supplierId } }),
      );
      return resp.data;
    } catch (e: any) {
      throw new HttpException(
        e.response?.data || 'Error forwarding deleteProduct',
        e.response?.status || HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

   async findAll(filters: SearchSuppliersDto) {
    const where: any = {};

    if (filters.name) {
      where.name = { contains: filters.name, mode: 'insensitive' };
    }
    if (filters.location) {
      where.location = { contains: filters.location, mode: 'insensitive' };
    }
    if (filters.verified !== undefined) {
      where.isVerified = filters.verified;
    }
    if (filters.premium !== undefined) {
      where.isPremium = filters.premium;
    }
    if (filters.category) {
      // on ne stocke pas la catégorie sur le supplier directement
      // on filtre via la relation produits
      where.products = {
        some: { category: { equals: filters.category, mode: 'insensitive' } },
      };
    }

    return this.prisma.supplier.findMany({
      where,
      include: {
        products: true,
      },
      orderBy: { createdAt: 'desc' },
    });
  }

  async findOne(id: string) {
    return this.prisma.supplier.findUnique({
      where: { id },
      include: { products: true, evaluations: true },
    });
  }

  async update(id: string, dto: UpdateSupplierDto): Promise<Supplier> {
    await this.findOne(id);
    return this.prisma.supplier.update({ where: { id }, data: dto });
  }

  async remove(id: string): Promise<{ message: string }> {
    await this.findOne(id);
    await this.prisma.supplier.delete({ where: { id } });
    return { message: 'fournisseur deleted successfully' };
  }
}