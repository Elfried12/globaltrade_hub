import { IsOptional, IsString, IsNumber, Min, IsBoolean } from 'class-validator';
import { Type } from 'class-transformer';

export class SearchProductsDto {
  @IsOptional() @IsString()           name?: string;
  @IsOptional() @IsString()           category?: string;
  @IsOptional() @Type(() => Number) @IsNumber() @Min(0) minPrice?: number;
  @IsOptional() @Type(() => Number) @IsNumber() @Min(0) maxPrice?: number;
  @IsOptional() @IsString()           supplierId?: string;
  @IsOptional() @Type(() => Boolean) @IsBoolean() availability?: boolean;
}