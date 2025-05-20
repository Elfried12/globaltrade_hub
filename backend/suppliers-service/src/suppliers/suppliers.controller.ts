import {Controller, Get, Post, Body, Param, Patch, Delete,Query} from '@nestjs/common';
import { SuppliersService } from './suppliers.service';
import { Request } from 'express';
import { CreateSupplierDto } from './dto/create-supplier.dto';
import { UpdateSupplierDto } from './dto/update-supplier.dto';
import { CreateResponseDto } from './dto/respond-request.dto';
import { ValidateTransactionDto } from './dto/validate-transaction.dto';
import { CancelTransactionDto } from './dto/cancel-transaction.dto';
import { SearchSuppliersDto } from './dto/search-suppliers.dto';

@Controller('suppliers/:supplierId')
export class SuppliersController {
  constructor(private readonly suppliersService: SuppliersService) {}

  /** 1. Le fournisseur crée un nouveau produit */
  @Post('products')
  addProduct(
    @Param('supplierId') supplierId: string,
    @Body() createDto: any /* utilisez votre CreateProductDto */,
  ) {
    return this.suppliersService.addProduct(supplierId, createDto);
  }

  /** 2. Répondre à une demande de prise de contact */
  @Post('requests/:requestId/respond')
  respondToRequest(
    @Param('supplierId') supplierId: string,
    @Param('requestId') requestId: string,
    @Body() dto: CreateResponseDto,
  ) {
    return this.suppliersService.respondToRequest(
      requestId,
      supplierId,
      dto,
    );
  }

  /** 3. Valider une transaction */
  @Post('transactions/:transactionId/validate')
  validateTransaction(
    @Param('supplierId') supplierId: string,
    @Param('transactionId') transactionId: string,
    @Body() dto: ValidateTransactionDto,
  ) {
    return this.suppliersService.validateTransaction(
      transactionId,
      supplierId,
      dto,
    );
  }

  /** 4. Annuler une transaction */
  @Post('transactions/:transactionId/cancel')
  cancelTransaction(
    @Param('supplierId') supplierId: string,
    @Param('transactionId') transactionId: string,
    @Body() dto: CancelTransactionDto,
  ) {
    return this.suppliersService.cancelTransaction(
      transactionId,
      supplierId,
      dto,
    );
  }

  /** 5. Supprimer un produit */
  @Delete('products/:productId')
  deleteProduct(
    @Param('supplierId') supplierId: string,
    @Param('productId') productId: string,
  ) {
    return this.suppliersService.deleteProduct(
      productId,
      supplierId,
    );
  }

  @Post()
  create(@Body() dto: CreateSupplierDto) {
    return this.suppliersService.create(dto);
  }

  @Get()
  search(@Query() filters: SearchSuppliersDto) {
    return this.suppliersService.findAll(filters);
  }


   @Get(':id')
  findOne(@Param('id') id: string) {
    return this.suppliersService.findOne(id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() dto: UpdateSupplierDto) {
    return this.suppliersService.update(id, dto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.suppliersService.remove(id);
  }
}

/*function Query(): (target: SuppliersController, propertyKey: "search", parameterIndex: 0) => void {
  throw new Error('Function not implemented.');
}*/
