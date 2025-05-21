// src/products/products.service.ts
import { Injectable ,NotFoundException} from '@nestjs/common';
import { PrismaService } from 'prisma/prisma.service';
import { CreateProductDto } from '../dto/create-product.dto';
import { UpdateProductDto } from '../dto/update-product.dto';
import { SearchProductsDto } from '../dto/search-products.dto';


@Injectable()
export class ProductsService {
  constructor(private readonly prisma: PrismaService) {}

  async create(dto: CreateProductDto) {
    return this.prisma.product.create({ data: { ...dto, availability: dto.availability ?? true } });
  }

  async findAll(filters: SearchProductsDto) {
    const where: any = {};
    if (filters.name) {
      where.name = { contains: filters.name, mode: 'insensitive' };
    }
    if (filters.category) {
      where.category = filters.category;
    }
    if (filters.minPrice || filters.maxPrice) {
      where.price = {};
      if (filters.minPrice !== undefined) where.price.gte = filters.minPrice;
      if (filters.maxPrice !== undefined) where.price.lte = filters.maxPrice;
    }
    if (filters.supplierId) {
      where.supplierId = filters.supplierId;
    }
    if (filters.availability !== undefined) {
      where.quantity = filters.availability ? { gt: 0 } : { equals: 0 };
    }

    return this.prisma.product.findMany({
      where,
      include: {
        supplier: true,
        images: true,
      },
      orderBy: { createdAt: 'desc' },
    });
  }

  async findOne(id: string) {
    
    return this.prisma.product.findUnique({
      where: { id },
      include: { supplier: true, images: true },
    });
  }

  async update(id: string, dto: UpdateProductDto) {
    await this.findOne(id);
    return this.prisma.product.update({ where: { id }, data: dto });
  }

  async remove(id: string) {
    await this.findOne(id);
    return this.prisma.product.delete({ where: { id } });
  }
}
