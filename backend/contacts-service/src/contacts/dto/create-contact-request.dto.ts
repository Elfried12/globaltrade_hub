import { IsUUID, IsOptional } from 'class-validator';

export class CreateContactRequestDto {
  @IsUUID()
  supplierId: string;

  @IsUUID()
  @IsOptional()
  productId?: string;
}